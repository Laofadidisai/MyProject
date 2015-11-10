//
//  MainViewController.h
//  OrderDish_Mr
//
//  Created by Charles on 15/11/4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class 仅仅是导入这个类名，但是.m文件中还是要写#import "LeftViewController.h"的
@class LeftViewController;
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *caixiTableView;
    
    //普通图片数组
    NSArray *array;
    
    //高亮图片数组
    NSArray *highLightArray;
    
    //记录当前哪一行cell被选中(哪一行需要显示高亮图片)
    int _currentSelectIndex;
    
//    NSMutableArray *caixiNameArray;
//    
    LeftViewController *leftVC;
}
@end
