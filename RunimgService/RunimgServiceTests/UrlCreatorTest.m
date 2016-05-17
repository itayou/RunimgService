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

@end

@implementation UrlCreatorTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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
    ImageOperator *imageOpertort = [[ImageOperator alloc] init];
    [imageOpertort setImageZoomWidth:100 height:100 process:YES];
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:@"123456789ABCDEF0" tokenKey:@"0123456789ABCDEF" imageType:TYPE_4D expired:3600 imageOperator:imageOpertort];
    NSLog(@"%@",[urlCreator toUrlString]);
    XCTAssertNotNil([urlCreator toUrlString]);
}

- (void)test002RecordInterval {
    ImageOperator *imageOpertort = [[ImageOperator alloc] init];
    [imageOpertort setImageZoomWidth:100 height:100 process:YES];
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:@"123456789ABCDEF0" tokenKey:@"0123456789ABCDEF" imageType:TYPE_4D expired:3600 imageOperator:imageOpertort];
    NSDate *currentDate = [NSDate date];
    long start = [currentDate timeIntervalSince1970];
    [urlCreator setRecordIntervalStartTime:start endTime:0];
    NSLog(@"%@",[urlCreator toUrlString]);
    XCTAssertNotNil([urlCreator toUrlString]);
}

@end
