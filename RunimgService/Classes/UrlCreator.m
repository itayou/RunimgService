//
//  UrlCreator.m
//  RunimgService
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "UrlCreator.h"


@interface UrlCreator ()
@property(nonatomic,strong)NSString *tokenId;
@property(nonatomic,strong)NSString *tokenKey;
@property(nonatomic,assign)ImageType imageType;
@property(nonatomic,assign)NSInteger expired;
@property(nonatomic,strong)ImageOperator *imageOperator;
@property(nonatomic,strong)NSString *timestamp;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *imageopt;
@property(nonatomic,strong)NSString *recInv;
@end

@implementation UrlCreator

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
                  imageOperator:(ImageOperator *)imageOperator {
    self = [super init];
    if(self){
        self.tokenId = tokenId;
        self.tokenKey = tokenKey;
        self.imageType = imageType;
        self.expired = expired;
        self.imageOperator = imageOperator;
        self.imageopt = [self.imageOperator toString];
        self.timestamp = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    }
    return self;
}


/*
 * 签名获得请求的URL地址
 */
- (NSString *)toUrlString {
    NSMutableString *content = [[NSMutableString alloc] init];
    [content appendFormat:@"%@=%@",@"expired",@(_expired)];
    if(_imageopt) {
        [content appendFormat:@"&%@=%@",@"img_opt",[[_imageopt base64Encode] urlEncode]];
    }
    [content appendFormat:@"&%@=%@",@"img_type",[[self conversionImageType] urlEncode]];
    if(_recInv) {
         [content appendFormat:@"&%@=%@",@"rec_inv",[[_recInv base64Encode] urlEncode]];
    }
    [content appendFormat:@"&%@=%@",@"signature",[[self signature] urlEncode]];
    [content appendFormat:@"&%@=%@",@"timestamp",[_timestamp urlEncode]];
    [content appendFormat:@"&%@=%@",@"token_id", [_tokenId urlEncode]];
    [content appendFormat:@"&%@=%@",@"version",[@"1.0" urlEncode]];
     NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,content];
    return url;
}

/*
 * @startTime 开始时间
 * @endTime 结束时间
 */
- (BOOL)setRecordIntervalStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    if(startTime) {
        if(endTime) {
            if(endTime.longLongValue > startTime.longLongValue) {
                _startTime = startTime;
                _endTime = endTime;
                return YES;
            }
        }else {
            _startTime = startTime;
            _endTime = endTime;
            return YES;
        }
        _recInv = [self getRecInterval];
    }
    return NO;
}

- (NSString *)getRecInterval {
    long long start = 0;
    long long end = 0;
    if(_startTime) {
        start = _startTime.longLongValue;
        if(_endTime) {
            end = _endTime.longLongValue;
        }
        NSString *recIntverval = [NSString stringWithFormat:@"{\"st\":\"%lld\",\"et\":\"%lld\"}",start,end];
        return recIntverval;
    }
    return nil;
}

- (NSString *)signature {
    NSMutableString *content = [[NSMutableString alloc] init];
    [content appendFormat:@"%@=%@",@"expired",@(_expired)];
    if(_imageopt) {
        [content appendFormat:@"&%@=%@",@"img_opt",[_imageopt base64Encode]];
    }
    [content appendFormat:@"&%@=%@",@"img_type",[self conversionImageType]];
    if(_recInv) {
        [content appendFormat:@"&%@=%@",@"rec_inv",[_recInv base64Encode]];
    }
    [content appendFormat:@"&%@=%@",@"timestamp",_timestamp];
    [content appendFormat:@"&%@=%@",@"token_id",_tokenId];
    [content appendFormat:@"&%@=%@",@"version",@"1.0"];
    NSString *signature = [content HMAC_SHA1WithKey:_tokenKey];
    return signature;
}

- (NSString *)conversionImageType {
    //1d_0_0 模式
    NSString *type = @"";
    switch (self.imageType) {
        case TYPE_1D:
            type = @"1d";
            break;
        case TYPE_2D:
            type = @"2d";
            break;
        case TYPE_2D_0_0:
            type = @"2d_0_0";
            break;
        case TYPE_2D_0_1:
            type = @"2d_0_1";
            break;
        case TYPE_2D_1_0:
            type = @"2d_1_0";
            break;
        case TYPE_2D_1_1:
            type = @"2d_1_1";
            break;
        case TYPE_4D:
            type = @"4d";
            break;
        case TYPE_4D_0_0:
            type = @"4d_0_0";
            break;
        case TYPE_4D_0_1:
            type = @"4d_0_1";
            break;
        case TYPE_4D_0_2:
            type = @"4d_0_2";
            break;
        case TYPE_4D_0_3:
            type = @"4d_0_3";
            break;
        case TYPE_4D_1_0:
            type = @"4d_1_0";
            break;
        case TYPE_4D_1_1:
            type = @"4d_1_1";
            break;
        case TYPE_4D_1_2:
            type = @"4d_1_2";
            break;
        case TYPE_4D_1_3:
            type = @"4d_1_3";
            break;
        case TYPE_4D_2_0:
            type = @"4d_2_0";
            break;
        case TYPE_4D_2_1:
            type = @"4d_2_1";
            break;
        case TYPE_4D_2_2:
            type = @"4d_2_2";
            break;
        case TYPE_4D_2_3:
            type = @"4d_2_3";
            break;
        case TYPE_4D_3_0:
            type = @"4d_3_0";
            break;
        case TYPE_4D_3_1:
            type = @"4d_3_1";
            break;
        case TYPE_4D_3_2:
            type = @"4d_3_2";
            break;
        case TYPE_4D_3_3:
            type = @"4d_3_3";
            break;
        default:
            type = @"2d";
            break;
    }
    return type;
}

@end

