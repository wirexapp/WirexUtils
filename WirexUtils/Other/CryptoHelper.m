//
//  CryptoHelper.m
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/27/17.
//  Copyright © 2017 wirex. All rights reserved.
//

#import "CryptoHelper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation CryptoHelper

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

@end
