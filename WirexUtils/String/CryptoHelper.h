//
//  CryptoHelper.h
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/27/17.
//  Copyright © 2017 wirex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptoHelper : NSObject

+ (nonnull NSString *)md5HexDigest:(nonnull NSString *)src;
+ (nonnull NSData *)sha256:(nonnull NSData *)src;

@end
