//
//  RunimgDefine.h
//  RunimgService
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 lizq. All rights reserved.
//

#ifndef RunimgDefine_h
#define RunimgDefine_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+Runimg.h"

#define BASE_URL  @"http://www.runimg.com/services.php/lastupdate?"

typedef NS_ENUM(NSInteger,ImageType) {
    TYPE_1D,
    TYPE_2D,
    TYPE_2D_0_0,
    TYPE_2D_0_1,
    TYPE_2D_1_0,
    TYPE_2D_1_1,
    TYPE_4D,
    TYPE_4D_0_0,
    TYPE_4D_0_1,
    TYPE_4D_0_2,
    TYPE_4D_0_3,
    TYPE_4D_1_0,
    TYPE_4D_1_1,
    TYPE_4D_1_2,
    TYPE_4D_1_3,
    TYPE_4D_2_0,
    TYPE_4D_2_1,
    TYPE_4D_2_2,
    TYPE_4D_2_3,
    TYPE_4D_3_0,
    TYPE_4D_3_1,
    TYPE_4D_3_2,
    TYPE_4D_3_3
};

typedef NS_ENUM(NSInteger,ImageFormat) {
    FORMAT_SRC,  // SRC
    FORMAT_JPG,  // JPG
    FORMAT_PNG,  // PNG
    FORMAT_WEBP, // WEBP
    FORMAT_BMP,  // BMP
    FORMAT_GIT   // GIT
};


typedef NS_ENUM(NSInteger,ClipperType) {
    SOURCE = 0,
    MIN_SQUARE,
    ROUND_RECTANGLE
};

typedef NS_ENUM(NSInteger,ClipperDirection) {
    CLIPPER_X,
    CLIPPER_Y
};

typedef NS_ENUM(NSInteger,ProgressiveType){
    ENABLE_PROGRESSIVE, //普通的JPG格式
    DISABLE_PROGRESSVIE //渐进显示的JPG格式
};

typedef void(^Successed)(NSObject *object);
typedef void(^Failed)(NSObject *object ,NSError *error);
#endif /* RunimgDefine_h */
