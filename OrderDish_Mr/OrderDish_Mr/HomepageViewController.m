//
//  HomepageViewController.m
//  OrderDish_Mr
//
//  Created by Charles on 15/11/4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "HomepageViewController.h"
#import "LangueChooseViewController.h"
@interface HomepageViewController ()

@end

@implementation HomepageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//进入网站首页
- (IBAction)jumpToWebHome:(id)sender
{
    //跳转到系统浏览器
    NSURL *url = [NSURL URLWithString:@"http://www.meituan.com"];
    [[UIApplication sharedApplication] openURL:url];
}
//进入点菜系统
- (IBAction)jumpToOrderSystem:(id)sender
{
    LangueChooseViewController *languageChooseVC = [[LangueChooseViewController alloc] init];
    //找窗口
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    //跳转
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:YES];
    [UIView commitAnimations];
    //为了避免穿透，让窗口昨晚动画之后，再设置窗口根视图控制器
    window.rootViewController = languageChooseVC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
