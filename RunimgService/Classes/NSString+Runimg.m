//
//  NSString+Runimg.m
//  RuningServiceTest
//
//  Created by lizq on 16/5/3.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "NSString+Runimg.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Runimg)
/*
 * url 编码
 * URL编码后的字符串
 */
- (NSString *)urlEncode {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_.~"];
    NSString * encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
    return encodedString;
}

/*
 * url 解码
 * @return URL解码的字符串
 */
- (NSString *)urlDecode {
    NSString *decodedString = [self stringByRemovingPercentEncoding];
    return decodedString;
}

/*
 * HMAC SHA1 加密
 * @key 加密的密钥
 * @return 加密后的字符串
 */
- (NSString *)HMAC_SHA1WithKey:(NSString *)key {
    const char *cKey   = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData  = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC   = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return hash;
}

/*
 * base64编码
 */
- (NSString *)base64Encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return result;
}
@end
