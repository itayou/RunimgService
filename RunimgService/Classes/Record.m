//
//  Record.m
//  RuningServiceTest
//
//  Created by lizq on 16/4/25.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "Record.h"
#import "NSString+Runimg.h"

@implementation Record

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.date = [NSString stringWithFormat:@"%@",dic[@"date"]];
        self.timestamp = [NSString stringWithFormat:@"%@",dic[@"timestamp"]];
        self.url = [NSString stringWithFormat:@"%@",dic[@"url"]];
    }
    return self;
}
@end
