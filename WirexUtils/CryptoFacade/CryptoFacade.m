//
//  CryptoHelper.m
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/27/17.
//  Copyright © 2017 wirex. All rights reserved.
//

#import "CryptoFacade.h"
#import <CommonCrypto/CommonCrypto.h>

NSString * const kCommonCryptoErrorDomain = @"CommonCryptoErrorDomain";

static NSError* errorWithCCCryptorStatus(CCCryptorStatus status) {
    NSError *result = [NSError errorWithDomain: kCommonCryptoErrorDomain code: status userInfo: nil];
    return result;
}

static void FixKeyLengths(CCAlgorithm algorithm, NSMutableData *keyData, NSMutableData *ivData) {
    NSUInteger keyLength = [keyData length];
    switch (algorithm) {
        case kCCAlgorithmAES128:
            if ( keyLength < 16 ) {
                [keyData setLength: 16];
            } else if ( keyLength < 24 ) {
                [keyData setLength: 24];
            } else {
                [keyData setLength: 32];
            }
            break;
        
        case kCCAlgorithmDES:
            [keyData setLength: 8];
            break;
        
        case kCCAlgorithm3DES:
            [keyData setLength: 24];
            break;
        
        case kCCAlgorithmCAST:
            if ( keyLength < 5 ) {
                [keyData setLength: 5];
            } else if ( keyLength > 16 ) {
                [keyData setLength: 16];
            }
            break;
        
        case kCCAlgorithmRC4:
            if ( keyLength > 512 )
                [keyData setLength: 512];
            break;
        
        default:
            break;
    }
    
    [ivData setLength: [keyData length]];
}

#pragma mark -

@implementation CryptoFacade

+ (NSString *)md5HexDigest:(NSString *)src {
    const char* str = [src UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


+ (NSData *)sha256:(NSData *)src {
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(src.bytes, (CC_LONG)src.length, hash);
    return [NSData dataWithBytes: hash length: CC_SHA256_DIGEST_LENGTH];
}
    
#pragma mark - cryptor/decryptor
    
+ (NSData *)DESEncryptData: (NSData *) data usingKey: (NSData* ) key error: (NSError **) error {
    CCCryptorStatus status = kCCSuccess;
    NSData * result = [CryptoFacade encryptData: data
                                      algorithm: kCCAlgorithmDES
                                            key: key
                           initializationVector: nil
                                        options: kCCOptionPKCS7Padding
                                          error: &status];
        
    if (result != nil)
        return result;
        
    if (error != NULL)
        *error = errorWithCCCryptorStatus(status);
        
    return nil;
}
    
+ (NSData *)DESDecryptData: (NSData *) data usingKey: (NSData* ) key error: (NSError **) error {
    CCCryptorStatus status = kCCSuccess;
    NSData * result = [CryptoFacade decryptData: data
                                      algorithm: kCCAlgorithmDES
                                            key: key
                           initializationVector: nil
                                        options: kCCOptionPKCS7Padding
                                          error: &status];
        
    if (result != nil)
        return result;
        
    if (error != NULL)
    *error = errorWithCCCryptorStatus(status);
        
    return nil;
}

#pragma mark - cryptor/decryptor - low level
    
+ (NSData *)encryptData: (NSData* ) data
              algorithm: (CCAlgorithm) algorithm
                    key: (NSData* ) key
   initializationVector: (NSData* ) iv
                options: (CCOptions) options
                  error: (CCCryptorStatus *) error {

    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    NSMutableData *keyData = (NSMutableData *) [key mutableCopy];
    NSMutableData *ivData =(NSMutableData *) [iv mutableCopy];
    
    // ensure correct lengths for key and iv data, based on algorithms
    FixKeyLengths(algorithm, keyData, ivData);
    
    status = CCCryptorCreate(kCCEncrypt, algorithm, options, [keyData bytes], [keyData length], [ivData bytes], &cryptor);
    if (status != kCCSuccess) {
        if (error != NULL)
            *error = status;
        return nil;
    }
        
    NSData *result = [CryptoFacade runCryptor: data cryptor: cryptor result: &status];
    if (result == nil && error != NULL )
       *error = status;
        
    CCCryptorRelease(cryptor);
    return result;
}
    
+ (NSData *) decryptData: (NSData* ) data
               algorithm: (CCAlgorithm) algorithm
                     key: (id) key
    initializationVector: (id) iv
                 options: (CCOptions) options
                   error: (CCCryptorStatus *) error {
    
    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
        
    NSMutableData *keyData = (NSMutableData *) [key mutableCopy];
    NSMutableData *ivData =(NSMutableData *) [iv mutableCopy];
        
    // ensure correct lengths for key and iv data, based on algorithms
    FixKeyLengths(algorithm, keyData, ivData);
        
    status = CCCryptorCreate(kCCDecrypt, algorithm, options, [keyData bytes], [keyData length], [ivData bytes], &cryptor);
    if (status != kCCSuccess) {
        if (error != NULL)
            *error = status;
        return nil;
    }
        
    NSData * result = [self runCryptor: data cryptor: cryptor result: &status];
    if (result == nil && error != NULL)
        *error = status;
    
    CCCryptorRelease(cryptor);
    return result;
}

+ (NSData *)runCryptor: (NSData *) data cryptor: (CCCryptorRef) cryptor result: (CCCryptorStatus *) status {
    size_t length = [data length];
    size_t bufsize = CCCryptorGetOutputLength(cryptor, length, true);
    void * buf = malloc(bufsize);
    size_t bufused = 0;
    size_t bytesTotal = 0;
    
    *status = CCCryptorUpdate( cryptor, [data bytes], length, buf, bufsize, &bufused);
    if (*status != kCCSuccess) {
        free(buf);
        return nil;
    }
        
    bytesTotal += bufused;
        
    // From Brent Royal-Gordon (Twitter: architechies):
    //  Need to update buf ptr past used bytes when calling CCCryptorFinal()
    *status = CCCryptorFinal(cryptor, buf + bufused, bufsize - bufused, &bufused);
    if (*status != kCCSuccess) {
        free(buf);
        return (nil);
    }
        
    bytesTotal += bufused;
    return [NSData dataWithBytesNoCopy: buf length: bytesTotal];
}

@end
