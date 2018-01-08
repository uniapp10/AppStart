//
//  AppDelegate.m
//  App启动流程
//
//  Created by ZD on 2018/1/8.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "AppDelegate.h"
#import <MJExtension/MJExtension.h>
#import "UrlConfigModel.h"
#import "ConfigManager.h"
#import "ZDIndexViewController.h"
#import "ZDTabBarController.h"

@interface AppDelegate ()
@property (nonatomic, strong) ConfigManager *manager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //与服务器协商的基本配置
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"ServiceSetting.json" ofType:nil];
    
    //模拟请求服务器, 获取baseUrl, 数据需要缓存
    NSData *dataHost = [[NSData alloc] initWithContentsOfFile:pathFile];
    NSArray *arrayHost = [NSJSONSerialization JSONObjectWithData:dataHost options:NSJSONReadingMutableContainers error:nil];
    UrlConfigModel *urlModel = [UrlConfigModel mj_objectArrayWithKeyValuesArray:arrayHost].firstObject;
    self.manager = [ConfigManager shareManager];
    [ConfigManager shareManager].appHost = urlModel.appHost;
    [ConfigManager shareManager].appImageHost = urlModel.appImageHost;
    [ConfigManager shareManager].isLaunched = true;
    
    //模拟请求服务器, 获取urlToken; urlToken一般有有效时间，可以选择根据时间, UUID, App版本, 和系统版本共同生成. 用来标识不同的用户和防止第三方恶意请求.
    NSString *tokenFile = [[NSBundle mainBundle] pathForResource:@"ServiceToken.json" ofType:nil];
    NSData *dataToken = [[NSData alloc] initWithContentsOfFile:tokenFile];
    NSDictionary *dictToken = [NSJSONSerialization JSONObjectWithData:dataToken options:NSJSONReadingMutableContainers error:nil];
    NSString *urlToken = dictToken[@"appToken"];
    [ConfigManager shareManager].urlToken = urlToken;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    if ([ConfigManager shareManager].isLaunched) {
        ZDTabBarController *tabBarC = [[ZDTabBarController alloc] init];
        [ConfigManager shareManager].tabBarController = tabBarC;
        self.window.rootViewController = tabBarC;
    }else{        
        [ZDShareDefaults setObject:@(true) forKey:isLaunchedKey];
        [ZDShareDefaults synchronize];
        ZDIndexViewController *indexVC = [[ZDIndexViewController alloc] init];
        self.window.rootViewController = [[ZDIndexViewController alloc] init];
        [ConfigManager shareManager].indexVC = indexVC;
    }
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
