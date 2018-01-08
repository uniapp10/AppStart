//
//  ZDIndexViewController.m
//  App启动流程
//
//  Created by ZD on 2018/1/8.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "ZDIndexViewController.h"
#import "ZDTabBarController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
#define BaseTag 1000

@interface ZDIndexViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIScrollView *scrollImagesView;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ZDIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    CGFloat topMargin = 30;
    CGFloat leftMargin = 10;
    CGFloat btnLeftW = 90;
    CGFloat btnRightW = 50;
    CGFloat btnH = 30;
    CGFloat bottomMargin = 50;
    CGFloat bottomBtnMargin = 250;
    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenSize.width - leftMargin - btnRightW), topMargin, btnRightW, btnH)];
    self.closeBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.closeBtn];
    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(btnBottomClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.scrollImagesView.backgroundColor = [UIColor blueColor];
    self.scrollImagesView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 2 * topMargin , ScreenSize.width, ScreenSize.height - 2 * topMargin)];
    [self.view addSubview:self.scrollImagesView];
    CGFloat imageViewY = CGRectGetMaxY(self.closeBtn.frame) + 20;
    CGFloat imageViewH = ScreenSize.height - imageViewY;
    NSInteger count = self.imageNames.count;
    [self.imageNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
        imageV.contentMode = UIViewContentModeScaleToFill;
        imageV.backgroundColor = [UIColor redColor];
        imageV.frame = CGRectMake(idx * ScreenSize.width, imageViewY, ScreenSize.width, imageViewH);
        [self.scrollImagesView addSubview:imageV];
        
        if (idx == count - 1) {
            CGFloat imageH = imageV.frame.size.height;
            UIButton *btnLook = [[UIButton alloc] initWithFrame:CGRectMake(2*leftMargin, imageH -  bottomBtnMargin, btnLeftW, btnH)];
            btnLook.tag = BaseTag;
            btnLook.backgroundColor = [UIColor orangeColor];
            [btnLook setTitle:@"随便看看" forState:(UIControlStateNormal)];
            UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width - 3*leftMargin - 2 * btnRightW, imageH - bottomBtnMargin, btnRightW, btnH)];
            btnLogin.tag = BaseTag + 1;
            btnLogin.backgroundColor = [UIColor orangeColor];
            [btnLogin setTitle:@"登录" forState:(UIControlStateNormal)];
            UIButton *btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width - 2*leftMargin - 1 * btnRightW, imageH - bottomBtnMargin, btnRightW, btnH)];
            btnRegister.tag = BaseTag + 2;
            btnRegister.backgroundColor = [UIColor orangeColor];
            [btnRegister setTitle:@"注册" forState:(UIControlStateNormal)];
            
            [btnLook addTarget:self action:@selector(btnBottomClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [btnLogin addTarget:self action:@selector(btnBottomClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [btnRegister addTarget:self action:@selector(btnBottomClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [imageV addSubview:btnLook];
            [imageV addSubview:btnLogin];
            [imageV addSubview:btnRegister];
            imageV.userInteractionEnabled = true;
        }
    }];
    self.scrollImagesView.showsVerticalScrollIndicator = false;
    self.scrollImagesView.showsHorizontalScrollIndicator = false;
    self.scrollImagesView.contentSize = CGSizeMake(count * ScreenSize.width, imageViewH);
    self.scrollImagesView.pagingEnabled = true;
    self.scrollImagesView.delegate = self;
    UIPageControl *pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, ScreenSize.height - bottomMargin, ScreenSize.width, 30)];
    self.pageControl = pageC;
    pageC.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageC.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    pageC.numberOfPages = count;
    [self.view addSubview:pageC];
}

- (void)btnBottomClick:(UIButton *)btn{
    long flag = btn.tag - BaseTag;
    switch (flag) {
            //随便看看
        case 0:
            
//            break;
            //登录
        case 1:
            
//            break;
            //注册
        default:
            [UIApplication sharedApplication].keyWindow.rootViewController = [[ZDTabBarController alloc] init];
            break;
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (scrollView.contentOffset.x + ScreenSize.width * 0.5) / ScreenSize.width;
}

- (NSArray *)imageNames{
    return @[@"apple", @"banana",
             @"berray", @"tomato",];
}
@end
