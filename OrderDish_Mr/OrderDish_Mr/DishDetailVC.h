//
//  DishDetailVC.h
//  OrderDish
//
//  Created by Charles on 15/11/5.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dish.h"

@interface DishDetailVC : UIViewController{
    
    IBOutlet UIImageView    *imgView;
    IBOutlet UILabel        *priceLabel;
    IBOutlet UILabel        *nameLabel;
}
//直接把菜品作为属性传递过来
@property (nonatomic,retain)Dish *dish;
@end
