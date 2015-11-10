//
//  SendOrderViewController.m
//  OrderDish_Mr
//
//  Created by Charles on 15/11/9.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "SendOrderViewController.h"
#import "RoomViewController.h"

@interface SendOrderViewController ()<RoomViewControllerDelegate>
{
    NSArray *_roomArray;
}
@property (weak, nonatomic) IBOutlet UILabel *roomLab;

@end

@implementation SendOrderViewController

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
    _roomArray = @[@"希尔顿",@"万丽"];
}
- (IBAction)selectRoomBtnClick:(id)sender
{
    RoomViewController *roomVC = [[RoomViewController alloc] init];
    roomVC.delegate = self;
    [self presentViewController:roomVC animated:YES completion:nil];
}
- (IBAction)dismissVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//送单
- (IBAction)sendOrder:(id)sender
{
    UIAlertView *songdan = [[UIAlertView alloc] initWithTitle:@""message:@"已送单" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [songdan show];
}

#pragma mark -  room的协议方法

- (void)chooseRoom:(int)tag
{
    self.roomLab.text = [_roomArray objectAtIndex:tag-1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
