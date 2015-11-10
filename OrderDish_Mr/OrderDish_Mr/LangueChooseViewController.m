//
//  LangueChooseViewController.m
//  OrderDish_Mr
//
//  Created by Charles on 15/11/4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "LangueChooseViewController.h"
#import "HomepageViewController.h"
#import "MainViewController.h"
@interface LangueChooseViewController ()

@end

@implementation LangueChooseViewController

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
- (IBAction)chineseLanguage:(id)sender
{
    [self jumpToMainUI];
}

- (IBAction)englishLanguage:(id)sender
{
    [self jumpToMainUI];    
}
-(void)jumpToMainUI
{
    MainViewController *mainVC = [[MainViewController alloc] init];
    //找窗口
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    //跳转
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:window cache:YES];
    [UIView commitAnimations];
    //为了避免穿透，让窗口昨晚动画之后，再设置窗口根视图控制器
    window.rootViewController = mainVC;
}
- (IBAction)backToHomePage:(id)sender
{
    HomepageViewController *lhomepageVC = [[HomepageViewController alloc] init];
    //找窗口
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    //跳转
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:window cache:YES];
    [UIView commitAnimations];
    //为了避免穿透，让窗口昨晚动画之后，再设置窗口根视图控制器
    window.rootViewController = lhomepageVC;
}
- (IBAction)orderMenuHistory:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
