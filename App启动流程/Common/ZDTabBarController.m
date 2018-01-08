//
//  ZDTabBarController.m
//  App启动流程
//
//  Created by ZD on 2018/1/8.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "ZDTabBarController.h"
#import "ZDNavigationController.h"
#import "ConfigManager.h"
#import "ZDIndexViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ZDTabBarController ()

@end

@implementation ZDTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSections];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:(UIControlStateSelected)];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:(UIControlStateNormal)];
}

- (void)addSections{
    UIViewController *homeVC = [[UIViewController alloc] init];
    UIViewController *mineVC = [[UIViewController alloc] init];
    CGFloat btnLeft = 10;
    CGFloat btnTop = 80;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, btnTop, ScreenSize.width - 2 * btnLeft, 100)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"切换到引导页" forState:(UIControlStateNormal)];
    [mineVC.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, CGRectGetMaxY(btn.frame) + 20, ScreenSize.width - 2 * btnLeft, 100)];
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"切换到正常页面" forState:(UIControlStateNormal)];
    [mineVC.view addSubview:btn2];
    
    homeVC.navigationItem.title = @"首页";
    mineVC.navigationItem.title = @"我的";
    
    ZDNavigationController *homeNav = [[ZDNavigationController alloc] initWithRootViewController:homeVC];
    ZDNavigationController *mineNav = [[ZDNavigationController alloc] initWithRootViewController:mineVC];
    homeNav.tabBarItem.title = @"首页";
    mineNav.tabBarItem.title = @"我的";
    
    [self addChildViewController:homeNav];
    [self addChildViewController:mineNav];
}

- (void)btnClick{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[ZDIndexViewController alloc] init];
}
- (void)btnClick2{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[ZDTabBarController alloc] init];
}

@end
