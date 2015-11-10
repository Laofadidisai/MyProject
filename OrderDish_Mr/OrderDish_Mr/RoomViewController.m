//
//  RoomViewController.m
//  OrderDish_Mr
//
//  Created by Charles on 15/11/9.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "RoomViewController.h"

@interface RoomViewController ()

@end

@implementation RoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)selectRoom:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if ([self.delegate respondsToSelector:@selector(chooseRoom:)])
    {
        [self.delegate chooseRoom:btn.tag];
    }

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
