//
//  MyOrderVC.h
//  OrderDish
//
//  Created by Charles on 15/11/6.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *_table;
    
    IBOutlet UILabel *_priceLabel;
    
    NSMutableArray *orderArray;
}

@end
