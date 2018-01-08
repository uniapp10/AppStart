//
//  ConfigManager.h
//  App启动流程
//
//  Created by ZD on 2018/1/8.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDTabBarController.h"
#import "ZDIndexViewController.h"

#define ZDShareDefaults [NSUserDefaults standardUserDefaults]
extern NSString * const isLaunchedKey;

@interface ConfigManager : NSObject

@property (nonatomic, assign) BOOL isLaunched;
@property (nonatomic, copy) NSString *appHost;
@property (nonatomic, copy) NSString *appImageHost;
@property (nonatomic, copy) NSString *urlToken;
@property (nonatomic, strong) ZDTabBarController *tabBarController;
@property (nonatomic, strong) ZDIndexViewController *indexVC;

+ (instancetype)shareManager;
@end
