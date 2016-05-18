//
//  ImageOperator.m
//  RunimgService
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "ImageOperator.h"
#import <objc/runtime.h>
#import "UrlCreator.h"

@interface ImageOperator ()
@property(nonatomic,strong)NSNumber *w;
@property(nonatomic,strong)NSNumber *h;
@property(nonatomic,strong)NSNumber *l;
@property(nonatomic,strong)NSNumber *e;
@property(nonatomic,strong)NSNumber *p;
@property(nonatomic,strong)NSString *rc;
@property(nonatomic,strong)NSString *ci;
@property(nonatomic,strong)NSString *ic;
@property(nonatomic,strong)NSString *a;
@property(nonatomic,strong)NSNumber *r;
@property(nonatomic,strong)NSNumber *sh;
@property(nonatomic,strong)NSString *bl;
@property(nonatomic,strong)NSNumber *b;
@property(nonatomic,strong)NSNumber *d;
@property(nonatomic,strong)NSNumber *q;
@property(nonatomic,strong)NSNumber *Q;
@property(nonatomic,strong)NSNumber *pr;
@property(nonatomic,strong)NSString *format;
@end


@implementation ImageOperator

- (instancetype)init {
    self = [super init];
    if(self) {
        [self reset];
    }
    return self;
}

- (void)reset {
    _w = nil;
    _h = nil;
    _l = nil;
    _e = nil;
    _p = nil;
    _rc = nil;
    _ci = nil;
    _ic = nil;
    _a = nil;
    _r = nil;
    _sh = nil;
    _bl = nil;
    _b = nil;
    _d = nil;
    _q = nil;
    _Q = nil;
    _pr = nil;
    _format = nil;
}

/*
 * 获取图片处理的字符串
 */
- (NSString *)toString {
    //组装json字符串
    NSMutableString *parament = [[NSMutableString alloc] initWithCapacity:1];
    unsigned int count;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    for(unsigned int i = 0; i < count;i++) {
        const char *propertyName = property_getName(list[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSObject *value = [self valueForKey:name];
        if(value) {
            [parament appendFormat:@"\"%@\":\"%@\",",name,value];
        }
    }
    if(parament.length > 0) {
        [parament deleteCharactersInRange:NSMakeRange(parament.length-1, 1)];
        NSString *result = [NSString stringWithFormat:@"{%@}",parament];
        return result;
    }
    return nil;
}

/*
 * 缩放
 * @width   图片宽度.  [1,4096]
 * @height  图片高度.  [1,4096]
 * @process 是否处理图片. [0,1];
 */
- (BOOL)setImageZoomWidth:(int)width height:(int)height process:(BOOL)process {
    _l = process?@(1):@(0);
    if([self checkValid:width min:1 max:4096]) {
        _w = @(width);
    }
    if([self checkValid:height min:1 max:4096]) {
        _h = @(height);
    }
    return _w != nil || _h != nil;
}

/*
 * 均衡宽高 参数e:[0,1,2]
 */
- (BOOL)setImageZoomProportion:(int)proportion {
    if([self checkValid:proportion min:0 max:2]) {
        _e = @(proportion);
    }
    return _e != nil;
}

/*
 * 缩放 对应参数:p [1,1000]
 */
- (BOOL)setImageZoom:(int)zoom {
    if([self checkValid:zoom min:1 max:1000]) {
        _p = @(zoom);
    }
    return _p != nil;
}

/*
 * 区域裁剪 参数rc:100*200-5
 * @width  裁剪的宽度
 * @height 裁剪的高度
 * @index  裁剪的区域 ,[1,9]
 */
- (BOOL)setImageClipperWidth:(int)width height:(int)height index:(int)index {
    if([self checkValid:width min:1 max:4096] &&
       [self checkValid:height min:1 max:4096] &&
       [self checkValid:index min:1 max:9]) {
        _rc = [NSString stringWithFormat:@"%dx%d-%d",width,height,index];
    }
    return _rc != nil;
}

/*
 * 圆角 参数ci:100-1ci
 * @radius:  圆角大小 [1,4096]
 * @type:    圆角类型 [0,1,2]
 */
- (BOOL)setImageClipperRadius:(int)radius type:(ClipperType)type {
    
    if([self checkValid:radius min:1 max:4096] &&
       [self checkValid:type min:0 max:2]) {
        _ci = [NSString stringWithFormat:@"%d-%@",radius,@(type)];
    }
    return _ci != nil;
}

/*
 * 索引切割 参数ic： 100-2ic
 * @chunk  等分的长度. [1,4096]
 * @direct 等分的方向. x or y
 * @index  等分的索引. 0~切割的最大块数
 */
- (BOOL)setImageClipperChunk:(int)chunk direction:(ClipperDirection)direction index:(int)index {
    if([self checkValid:chunk min:1 max:4096] &&
       [self checkValid:index min:0 max:4096]) {
        NSString *directionX = direction == CLIPPER_X ?@"x":@"y";
        _ic = [NSString stringWithFormat:@"%d%@-%d",chunk,directionX,index];
    }
    return _ic != nil;
}

/*
 * 矩形切割 参数a:100-100-100-100
 */
- (BOOL)setimageClipperRectX:(int)x y:(int)y w:(int)w h:(int)h {
    if([self checkValid:x min:1 max:4096] &&
       [self checkValid:y min:1 max:4096] &&
       [self checkValid:w min:1 max:4096] &&
       [self checkValid:h min:1 max:4096]) {
        _a = [NSString stringWithFormat:@"%d-%d-%d-%d",x,y,w,h];
    }
    return _a != nil;
}

/*
 *  旋转 参数r: [0,360]
 */
- (BOOL)setImageRotation:(int)rotation {
    if([self checkValid:rotation min:0 max:360]) {
        _r = @(rotation);
    }
    return _r != nil;
}

/*
 * 锐化 参数sh: [50,399]
 */
- (BOOL)setImageSharpen:(int)sharpen {
    if([self checkValid:sharpen min:50 max:399]) {
        _sh = @(sharpen);
    }
    return _sh != nil;
}

/*
 * 模糊效果 参数bl: radius-sigmal [1,50]-[1,50]
 */
- (BOOL)setImageBlurryRadius:(int)radius sigmal:(int)sigmal {
    if([self checkValid:radius min:1 max:50] &&
       [self checkValid:sigmal min:1 max:50]) {
        _bl = [NSString stringWithFormat:@"%d-%d",radius,sigmal];
    }
    return _bl != nil;
}

/*
 * 亮度调节 参数:b [-100,100]
 */
- (BOOL)setImageBrightness:(int)brightness {
    if([self checkValid:brightness min:-100 max:100]) {
        _b = @(brightness);
    }
    return _b != nil;
}

/*
 * 对比度 参数:d [－100,100]
 */
- (BOOL)setImageContrast:(int)contrast {
    if([self checkValid:contrast min:-100 max:100]) {
        _d = @(contrast);
    }
    return _d != nil;
}

/*
 * 相对图片质量 参数q: [1,100]
 */
- (BOOL)setJPGImageRelationQuality:(int)quality {
    if([self checkValid:quality min:1 max:100]) {
        _q = @(quality);
    }
    return _q != nil;
}

/*
 * 绝对图片质量 参数Q: [1,100]
 */
- (BOOL)setJPGImageAbsoluteQuality:(int)quality {
    if([self checkValid:quality min:1 max:100]) {
        _Q = @(quality);
    }
    return _Q != nil;
}

/*
 * JPG图片呈现方式
 * 参数[pr]:[0,1]
 */
- (BOOL)setJPGProgressive:(ProgressiveType)progressive {
    if([self checkValid:progressive min:ENABLE_PROGRESSIVE max:DISABLE_PROGRESSVIE]) {
        _pr = @(progressive);
    }
    return _pr != nil;
}

/*
 * 图片格式  参数format: @ImageFormat
 */
- (BOOL)setImageFormat:(ImageFormat)format {
    if([self checkValid:format min:FORMAT_SRC max:FORMAT_GIT]) {
        switch (format) {
            case FORMAT_SRC:
                _format = @"src";
                break;
            case FORMAT_JPG:
                _format = @"jpg";
                break;
            case FORMAT_PNG:
                _format = @"png";
                break;
            case FORMAT_WEBP:
                _format = @"webp";
                break;
            case FORMAT_BMP:
                _format = @"bmp";
                break;
            case FORMAT_GIT:
                _format = @"git";
                break;
            default:
                _format = @"jpg";
                break;
        }
    }
    return _format != nil;
}

- (BOOL)checkValid:(int)target min:(int)min max:(int)max {
    return target >= min && target <= max;
}

@end
