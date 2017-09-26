//
//  CryptoFacade.h
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/27/17.
//  Copyright © 2017 wirex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CryptoFacade : NSObject

+ (NSString *)md5HexDigest:(NSString *)src;
+ (NSData *)sha256:(NSData *)src;
    
+ (nullable NSData *)DESEncryptData: (NSData *) data usingKey: (NSData* ) key iv: (NSData *) iv error: (NSError **) error;
+ (nullable NSData *)DESDecryptData: (NSData *) data usingKey: (NSData* ) key iv: (NSData *) iv error: (NSError **) error;

+ (nullable NSData *)AESEncryptData: (NSData *) data usingKey: (NSData* ) key iv: (NSData *) iv error: (NSError **) error;
+ (nullable NSData *)AESDecryptData: (NSData *) data usingKey: (NSData* ) key iv: (NSData *) iv error: (NSError **) error;

@end

NS_ASSUME_NONNULL_END
