//
//  RoomViewController.h
//  OrderDish_Mr
//
//  Created by Charles on 15/11/9.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomViewController : UIViewController
@property id delegate;
@end

@protocol RoomViewControllerDelegate <NSObject>

- (void)chooseRoom:(int)tag;

@end