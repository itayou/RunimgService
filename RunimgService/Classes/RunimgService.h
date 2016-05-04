//
//  RunimgService.h
//  RunimgService
//
//  Created by lizq on 16/4/19.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunimgDefine.h"
#import "UrlCreator.h"
#import "UpdateStanza.h"
#import "Record.h"

@interface RunimgService : NSObject

+ (instancetype)sharedInstance;

/* 1.0.2
 * 通过图片操作参数获取图片地址
 * @urlCreator 请求的UrlCreator对象
 * @success 返回一个UpdateStanza对象
 * @failed 返回一个错误信息
 */
- (void)getImageUrlWithUrlCreator:(UrlCreator *)urlCreator
                        successed:(Successed)successed
                           failed:(Failed)failed;

/*
 * 通过图片地址获取图片内容
 * @success 返回一个UIImage对象
 * @failed 返回一个错误信息
 */
- (void)getImageByUrl:(NSString *)url
            successed:(Successed)successed
               failed:(Failed)failed;

@end
