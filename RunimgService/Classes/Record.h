//
//  Record.h
//  RuningServiceTest
//
//  Created by lizq on 16/4/25.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *timestamp;
@property(nonatomic,strong)NSString *url;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
