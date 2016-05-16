//
//  UrlCreator.h
//  RunimgService
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageOperator.h"
#import "RunimgDefine.h"
@interface UrlCreator : NSObject

/*
 * @tokenId   用户tokenId
 * @tokenKey  用户tokenKey
 * @imageType 原图片大小 @ImageType
 * @expired   目标图片的有效时间
 * @imageOperator 图片的处理对象
 * @return    请求图片的对象
 */
- (instancetype)initWithTokenId:(NSString *)tokenId
                       tokenKey:(NSString *)tokenKey
                      imageType:(ImageType )imageType
                        expired:(NSInteger )expired
                  imageOperator:(ImageOperator *)imageOperator;

/*
 * 签名获得请求的URL地址
 */
- (NSString *)toUrlString;

/*
 * @startTime 开始时间戳 到秒
 * @endTime 结束时间戳 到秒
 */
- (BOOL)setRecordIntervalStartTime:(long)startTime endTime:(long)endTime;
@end
