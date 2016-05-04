//
//  NSString+Runimg.h
//  RuningServiceTest
//
//  Created by lizq on 16/5/3.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Runimg)
/*
 * url 编码
 * URL编码后的字符串
 */
- (NSString *)urlEncode;

/*
 * url 解码
 * @return URL解码的字符串
 */
- (NSString *)urlDecode;

/*
 * HMAC SHA1 加密
 * @key 加密的密钥
 * @return 加密后的字符串
 */
- (NSString *)HMAC_SHA1WithKey:(NSString *)key;

/*
 * base64编码
 */
- (NSString *)base64Encode;
@end
