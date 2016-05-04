//
//  UpdateStanza.h
//  RuningServiceTest
//
//  Created by lizq on 16/4/25.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateStanza : NSObject
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSArray *records;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
