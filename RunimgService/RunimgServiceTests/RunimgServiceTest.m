//
//  RunimgServiceTest.m
//  RunimgService
//
//  Created by lizq on 16/5/17.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RunimgService.h"

@interface RunimgServiceTest : XCTestCase
@property(nonatomic,strong)NSString *tokenId;
@property(nonatomic,strong)NSString *tokenKey;
@property(nonatomic,strong)ImageOperator *imageOperator;
@property(nonatomic,assign)NSInteger expired;
@end

@implementation RunimgServiceTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tokenId = @"123456789ABCDEF0";
    self.tokenKey = @"0123456789ABCDEF";
    self.expired = 3600;
    self.imageOperator = [[ImageOperator alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)test001GetImageUrl {
    [self.imageOperator setImageZoomWidth:500 height:500 process:YES];
    [self.imageOperator setImageZoom:50];
    [self.imageOperator setImageRotation:30];
    [self.imageOperator setImageFormat:FORMAT_PNG];
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:self.tokenId tokenKey:self.tokenKey imageType:TYPE_4D expired:self.expired imageOperator:self.imageOperator];
    [[RunimgService sharedInstance] getImageUrlWithBaseUrl:BASE_URL urlCreator:urlCreator successed:^(NSObject *object) {
        XCTAssertNotNil(object);
    } failed:^(NSObject *object, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNil(object);
    }];
}

- (void)test002GetImageByUrl {
    [self.imageOperator setImageZoomWidth:500 height:500 process:YES];
    [self.imageOperator setImageZoom:50];
    [self.imageOperator setImageRotation:30];
    [self.imageOperator setImageFormat:FORMAT_PNG];
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:self.tokenId tokenKey:self.tokenKey imageType:TYPE_4D expired:self.expired imageOperator:self.imageOperator];
    [[RunimgService sharedInstance] getImageUrlWithBaseUrl:BASE_URL urlCreator:urlCreator successed:^(NSObject *object) {
        XCTAssertNotNil(object);
        UpdateStanza *updateStanza = (UpdateStanza *)object;
        Record *recode = nil;
        if(updateStanza.records.count > 0) {
            recode = [updateStanza.records objectAtIndex:0];
            [[RunimgService sharedInstance] getImageByUrl:recode.url successed:^(NSObject *object) {
                XCTAssertNotNil(object);
            } failed:^(NSObject *object, NSError *error) {
                XCTAssertNil(object);
            }];
        }
    } failed:^(NSObject *object, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNil(object);
    }];
}


@end
