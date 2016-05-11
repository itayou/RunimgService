//
//  ImageOperatorTest.m
//  RunimgService
//
//  Created by lizq on 16/5/11.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageOperator.h"
@interface ImageOperatorTest : XCTestCase
@property(nonatomic,strong)ImageOperator *imageOperator;
@end

@implementation ImageOperatorTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"%@---%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    self.imageOperator = [[ImageOperator alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"%@---%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"%@---%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSLog(@"%@---%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testToString {
    XCTAssertNil([self.imageOperator toString]);
    [self.imageOperator setImageZoomWidth:100 height:100 process:YES];
    XCTAssertNotNil([self.imageOperator toString]);
    XCTAssertEqualObjects([self.imageOperator toString], @"{\"w\":\"100\",\"h\":\"100\",\"l\":\"1\"}");
}

- (void)test001ZoomWidthHeight {
    //边界值
    XCTAssertFalse([self.imageOperator setImageZoomWidth:0 height:0 process:YES]);
    XCTAssertFalse([self.imageOperator setImageZoomWidth:-1 height:0 process:YES]);
    XCTAssertFalse([self.imageOperator setImageZoomWidth:0 height:4097 process:YES]);
    XCTAssertFalse([self.imageOperator setImageZoomWidth:4097 height:0 process:YES]);
    XCTAssertFalse([self.imageOperator setImageZoomWidth:4097 height:4097 process:YES]);
    //范围内
    XCTAssertTrue([self.imageOperator setImageZoomWidth:1 height:0 process:NO]);
    XCTAssertTrue([self.imageOperator setImageZoomWidth:4096 height:1 process:YES]);
    XCTAssertTrue([self.imageOperator setImageZoomWidth:1 height:4096 process:YES]);
    XCTAssertTrue([self.imageOperator setImageZoomWidth:255 height:255 process:YES]);
}

- (void)test002ZoomProportion {
    XCTAssertFalse([self.imageOperator setImageZoomProportion:-1]);
    XCTAssertFalse([self.imageOperator setImageZoomProportion:3]);
    
    XCTAssertTrue([self.imageOperator setImageZoomProportion:0]);
    XCTAssertTrue([self.imageOperator setImageZoomProportion:1]);
    XCTAssertTrue([self.imageOperator setImageZoomProportion:2]);
}

- (void)test003Zoom {
    XCTAssertFalse([self.imageOperator setImageZoom:0]);
    XCTAssertFalse([self.imageOperator setImageZoom:1001]);
    XCTAssertTrue([self.imageOperator setImageZoom:100]);
}

- (void)test004ClipperWidthHeight {
    XCTAssertFalse([self.imageOperator setImageClipperWidth:0 height:0 index:0]);
    XCTAssertFalse([self.imageOperator setImageClipperWidth:0 height:1 index:1]);
    XCTAssertFalse([self.imageOperator setImageClipperWidth:1 height:100 index:10]);
    
    XCTAssertTrue([self.imageOperator setImageClipperWidth:1 height:1 index:1]);
    XCTAssertTrue([self.imageOperator setImageClipperWidth:1 height:1 index:5]);
    XCTAssertTrue([self.imageOperator setImageClipperWidth:100 height:100 index:9]);
}

- (void)test005ClipperRadius {
    XCTAssertFalse([self.imageOperator setImageClipperRadius:0 type:SOURCE - 1]);
    XCTAssertFalse([self.imageOperator setImageClipperRadius:1 type:ROUND_RECTANGLE +1]);
    XCTAssertFalse([self.imageOperator setImageClipperRadius:4097 type:ROUND_RECTANGLE]);
    
    XCTAssertTrue([self.imageOperator setImageClipperRadius:1 type:ROUND_RECTANGLE]);
    XCTAssertTrue([self.imageOperator setImageClipperRadius:100 type:ROUND_RECTANGLE]);
    XCTAssertTrue([self.imageOperator setImageClipperRadius:4096 type:ROUND_RECTANGLE]);
}

- (void)test006ClipperChunk {
    XCTAssertFalse([self.imageOperator setImageClipperChunk:0 direction:CLIPPER_X index:0]);
    XCTAssertFalse([self.imageOperator setImageClipperChunk:4097 direction:CLIPPER_X index:0]);
    
    XCTAssertTrue([self.imageOperator setImageClipperChunk:1 direction:CLIPPER_Y index:100]);
    XCTAssertTrue([self.imageOperator setImageClipperChunk:1 direction:CLIPPER_X index:100]);
}

- (void)test007ClipperRect {
    XCTAssertFalse([self.imageOperator setimageClipperRectX:0 y:0 w:0 h:0]);
    XCTAssertFalse([self.imageOperator setimageClipperRectX:4097 y:4097 w:4097 h:4097]);
    
    XCTAssertTrue([self.imageOperator setimageClipperRectX:1 y:1 w:1 h:1]);
    XCTAssertTrue([self.imageOperator setimageClipperRectX:4096 y:4096 w:4096 h:4096]);
}

- (void)test008Rotation {
    XCTAssertFalse([self.imageOperator setImageRotation:-1]);
    XCTAssertFalse([self.imageOperator setImageRotation:361]);
    XCTAssertTrue([self.imageOperator setImageRotation:0]);
    XCTAssertTrue([self.imageOperator setImageRotation:100]);
    XCTAssertTrue([self.imageOperator setImageRotation:360]);
}

- (void)test009Sharpen {
    XCTAssertFalse([self.imageOperator setImageSharpen:49]);
    XCTAssertFalse([self.imageOperator setImageSharpen:400]);
    XCTAssertTrue([self.imageOperator setImageSharpen:50]);
    XCTAssertTrue([self.imageOperator setImageSharpen:300]);
    XCTAssertTrue([self.imageOperator setImageSharpen:399]);
}

- (void)test010BlurryRadius {
    XCTAssertFalse([self.imageOperator setImageBlurryRadius:0 sigmal:0]);
    XCTAssertFalse([self.imageOperator setImageBlurryRadius:1 sigmal:0]);
    XCTAssertFalse([self.imageOperator setImageBlurryRadius:0 sigmal:1]);
    XCTAssertFalse([self.imageOperator setImageBlurryRadius:51 sigmal:50]);
    XCTAssertFalse([self.imageOperator setImageBlurryRadius:50 sigmal:51]);
    
    XCTAssertTrue([self.imageOperator setImageBlurryRadius:1 sigmal:1]);
    XCTAssertTrue([self.imageOperator setImageBlurryRadius:1 sigmal:50]);
    XCTAssertTrue([self.imageOperator setImageBlurryRadius:50 sigmal:1]);
    XCTAssertTrue([self.imageOperator setImageBlurryRadius:25 sigmal:25]);
}

- (void)test011Brightness {
    XCTAssertFalse([self.imageOperator setImageBrightness:-101]);
    XCTAssertFalse([self.imageOperator setImageBrightness:101]);
    XCTAssertTrue([self.imageOperator setImageBrightness:-100]);
    XCTAssertTrue([self.imageOperator setImageBrightness:0]);
    XCTAssertTrue([self.imageOperator setImageBrightness:100]);
}

- (void)test012RelationQuality {
    XCTAssertFalse([self.imageOperator setJPGImageRelationQuality:0]);
    XCTAssertFalse([self.imageOperator setJPGImageRelationQuality:101]);
    XCTAssertTrue([self.imageOperator setJPGImageRelationQuality:1]);
    XCTAssertTrue([self.imageOperator setJPGImageRelationQuality:50]);
    XCTAssertTrue([self.imageOperator setJPGImageRelationQuality:100]);
    
}

- (void)test013AbsolutQuality {
    XCTAssertFalse([self.imageOperator setJPGImageAbsoluteQuality:0]);
    XCTAssertFalse([self.imageOperator setJPGImageAbsoluteQuality:101]);
    XCTAssertTrue([self.imageOperator setJPGImageAbsoluteQuality:1]);
    XCTAssertTrue([self.imageOperator setJPGImageAbsoluteQuality:50]);
    XCTAssertTrue([self.imageOperator setJPGImageAbsoluteQuality:100]);
}

- (void)test014Progressive {
    XCTAssertFalse([self.imageOperator setJPGProgressive:ENABLE_PROGRESSIVE-1]);
    XCTAssertFalse([self.imageOperator setJPGProgressive:DISABLE_PROGRESSVIE+1]);
    XCTAssertTrue([self.imageOperator setJPGProgressive:ENABLE_PROGRESSIVE]);
    XCTAssertTrue([self.imageOperator setJPGProgressive:DISABLE_PROGRESSVIE]);
}

- (void)test015Format {
    XCTAssertTrue([self.imageOperator setImageFormat:FORMAT_SRC]);
    XCTAssertTrue([self.imageOperator setImageFormat:FORMAT_GIT]);
    XCTAssertTrue([self.imageOperator setImageFormat:FORMAT_JPG]);
    XCTAssertTrue([self.imageOperator setImageFormat:FORMAT_PNG]);
    XCTAssertTrue([self.imageOperator setImageFormat:FORMAT_WEBP]);
    XCTAssertTrue([self.imageOperator setImageFormat:FORMAT_BMP]);
}
@end
