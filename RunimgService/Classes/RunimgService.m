//
//  RunimgService.m
//  RunimgService
//
//  Created by lizq on 16/4/19.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "RunimgService.h"
#import <objc/runtime.h>
#import "UpdateStanza.h"

@implementation RunimgService

+ (instancetype)sharedInstance {
    Class clazz = [self class];
    id instance = objc_getAssociatedObject(clazz, @"sharedInstance");
    if (!instance) {
        instance = [[clazz alloc] init];
        objc_setAssociatedObject(clazz, @"sharedInstance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}

/*
 * 通过图片操作参数获取图片地址
 * @urlCreator 请求的UrlCreator对象
 * @success 返回一个UpdateStanza对象
 * @failed 返回一个错误信息
 */
- (void)getImageUrlWithBaseUrl:(NSString *)baseUrl urlCreator:(UrlCreator *)urlCreator successed:(Successed)successed failed:(Failed)failed {
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,[urlCreator toUrlString]];
    NSLog(@"%@<url>:%@",NSStringFromSelector(_cmd), url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kRequestTimeout];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        if(data){
            NSError *jsonError = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"<result>:%@",result);
            if(dic) {
                NSInteger state = [dic[@"status"] integerValue];
                if(state == 200) {
                    UpdateStanza *updateStanza = [[UpdateStanza alloc] initWithDic:dic];
                    successed(updateStanza);
                }else {
                    NSError *responseError = [NSError errorWithDomain:@"response error data" code:601 userInfo:nil];
                    NSLog(@"%@<response error>%@,%@",NSStringFromSelector(_cmd),responseError,dic);
                    failed(dic,error);
                }
            }else {
                NSLog(@"%@<json error>%@,%@",NSStringFromSelector(_cmd),jsonError,dic);
                failed(data,jsonError);
                
            }
        }else {
            NSLog(@"%@<request error>%@",NSStringFromSelector(_cmd),error);
            failed(data,error);
        }
    }];
    [task resume];
}

/*
 * 通过图片地址获取图片内容
 * @success 返回一个UIImage对象
 * @failed 返回一个错误信息
 */
- (void)getImageByUrl:(NSString *)url successed:(Successed)successed failed:(Failed)failed {
    NSLog(@"<request image url>%@",url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        if(data) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            if(image) {
                successed(image);
            }else {
                NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSError *imageError = [NSError errorWithDomain:errorString code:701 userInfo:nil];
                NSLog(@"%@<image date error>%@",NSStringFromSelector(_cmd),imageError);
                failed(data,imageError);
            }
        }else {
            NSLog(@"%@<request image error>%@",NSStringFromSelector(_cmd),error);
            failed(data,error);
        }
    }];
    [task resume];
    
}

@end
