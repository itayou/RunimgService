//
//  ImageOperator.h
//  RunimgService
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunimgDefine.h"
@interface ImageOperator : NSObject

/*
 * 获取图片处理的字符串
 */
- (NSString *)toString;

/*
 * 缩放
 * @width   图片宽度.  [1,4096]
 * @height  图片高度.  [1,4096]
 * @process 是否处理图片. [0,1];
 */
- (BOOL)setImageZoomWidth:(int)width height:(int)height process:(BOOL)process;

/*
 * 均衡宽高 参数e:[0,1,2]
 */
- (BOOL)setImageZoomProportion:(int)proportion;

/*
 *  缩放 对应参数:p [1,1000]
 */
- (BOOL)setImageZoom:(int)zoom;

/*
 * 区域裁剪 参数rc:100*200-5
 * @width  裁剪的宽度
 * @height 裁剪的高度
 * @index  裁剪的区域 ,[1,9]
 */
- (BOOL)setImageClipperWidth:(int)width height:(int)height index:(int)index;

/*
 * 圆角 参数ci:100-1ci
 * @radius:  圆角大小 [1,4096]
 * @type:    圆角类型 [0,1,2]
 */
- (BOOL)setImageClipperRadius:(int)radius type:(ClipperType)type;

/*
 * 索引切割 参数ic： 100-2ic
 * @chunk  等分的长度. [1,4096]
 * @direct 等分的方向. x or y
 * @index  等分的索引. 0~切割的最大块数
 */
- (BOOL)setImageClipperChunk:(int)chunk direction:(ClipperDirection)direction index:(int)index;

/*
 * 矩形切割 参数a:100-100-100-100
 */
- (BOOL)setimageClipperRectX:(int)x y:(int)y w:(int)w h:(int)h;

/*
 * 旋转 参数r: [0,360]
 */
- (BOOL)setImageRotation:(int)rotation;

/*
 * 锐化 参数sh: [50,399]
 */
- (BOOL)setImageSharpen:(int)sharpen;

/*
 * 模糊效果 参数bl: radius-sigmal [1,50]-[1,50]
 */
- (BOOL)setImageBlurryRadius:(int)radius sigmal:(int)sigmal;

/*
 * 亮度调节 参数:b [-100,100]
 */
- (BOOL)setImageBrightness:(int)brightness;

/*
 * 对比度 参数:d [－100,100]
 */
- (BOOL)setImageContrast:(int)contrast;

/*
 * 相对图片质量 参数q: [1,100]
 */
- (BOOL)setJPGImageRelationQuality:(int)quality;

/*
 * 绝对图片质量 参数Q: [1,100];
 */
- (BOOL)setJPGImageAbsoluteQuality:(int)quality;

/*
 * JPG图片呈现方式
 * 参数[pr]:[0,1]
 */
- (BOOL)setJPGProgressive:(ProgressiveType)progressive;

/*
 * 图片格式  参数format: @ImageFormat
 */
- (BOOL)setImageFormat:(ImageFormat)foramt;

/*
 * 重置设置项
 */
- (void)reset;
@end
