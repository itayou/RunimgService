//
//  UpdateStanza.m
//  RuningServiceTest
//
//  Created by lizq on 16/4/25.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "UpdateStanza.h"
#import "Record.h"

@implementation UpdateStanza

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        NSString *status = dic[@"status"];
        self.status = @(status.integerValue);
        NSArray *dics = dic[@"records"];
        NSMutableArray *records = [[NSMutableArray alloc] initWithCapacity:1];
        for(NSDictionary *tmp in dics) {
            Record *record = [[Record alloc] initWithDic:tmp];
            [records addObject:record];
        }
        self.records = [records copy];
    }
    return self;
}
@end
