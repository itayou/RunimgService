//
//  UrlCreatorTest.m
//  RunimgService
//
//  Created by lizq on 16/5/17.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageOperator.h"
#import "UrlCreator.h"
@interface UrlCreatorTest : XCTestCase
@property(nonatomic,strong)NSString *tokenId;
@property(nonatomic,strong)NSString *tokenKey;
@property(nonatomic,strong)ImageOperator *imageOperator;
@property(nonatomic,assign)NSInteger expired;
@end

@implementation UrlCreatorTest

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

- (void)test001ToUrlString {
    [self.imageOperator setImageZoomWidth:100 height:100 process:YES];
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:self.tokenId tokenKey:self.tokenKey imageType:TYPE_4D expired:self.expired imageOperator:self.imageOperator];
    XCTAssertNotNil([urlCreator toUrlString]);
    
    [self.imageOperator setImageClipperChunk:100 direction:CLIPPER_X index:3];
    urlCreator = [[UrlCreator alloc] initWithTokenId:self.tokenId tokenKey:self.tokenKey imageType:TYPE_4D expired:self.expired imageOperator:self.imageOperator];
    XCTAssertNotNil([urlCreator toUrlString]);
}

- (void)test002RecordInterval {
    [self.imageOperator setImageZoomWidth:100 height:100 process:YES];
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:self.tokenId tokenKey:self.tokenKey imageType:TYPE_4D expired:self.expired imageOperator:self.imageOperator];
    NSDate *currentDate = [NSDate date];
    long start = [currentDate timeIntervalSince1970];
    [urlCreator setRecordIntervalStartTime:start endTime:0];
    XCTAssertNotNil([urlCreator toUrlString]);
}

@end
