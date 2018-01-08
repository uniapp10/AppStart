//
//  ConfigManager.m
//  App启动流程
//
//  Created by ZD on 2018/1/8.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "ConfigManager.h"

NSString * const isLaunchedKey = @"isLaunchedKey";

@implementation ConfigManager
+ (instancetype)shareManager{
    

    static ConfigManager *configM;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configM = [[self alloc] init];
    });
    return configM;
}

- (BOOL)isLaunched{
    BOOL flag = [[ZDShareDefaults objectForKey:isLaunchedKey] boolValue];
    return flag;
}
@end
