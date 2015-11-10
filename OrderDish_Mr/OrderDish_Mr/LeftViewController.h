//
//  LeftViewController.h
//  OrderDish
//
//  Created by charles on 15-11-4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    //左上侧用于显示菜系的图片
    IBOutlet UIImageView *_headerImageView;
    //显示菜单的列表
    IBOutlet UITableView *_table;
    
    NSArray *_nameArray;
    NSMutableArray *_dishArray;
    
    //当前打开的section
    int currentOpenSection;
    //当前选中了哪个菜品
    int currentSelectDishIndex;
    
    //滚动显示菜品的滚动视图
    IBOutlet UIScrollView *_scrollView;

    //菜品详情
    IBOutlet UIButton *detailsButton;
    
    //点菜按钮
    IBOutlet UIButton *orderButton;
}

@property (nonatomic,assign)int index;

@end
