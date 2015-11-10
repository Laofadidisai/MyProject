//
//  Dish.h
//  OrderDish
//
//  Created by charles on 15-11-4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dish : NSObject
@property (assign,nonatomic)int dishID;
@property (assign,nonatomic)int groupID;
@property (copy,nonatomic)NSString *kind;
@property (copy,nonatomic)NSString *name;
@property (assign,nonatomic)int price;
@property (copy,nonatomic)NSString *unit;
@property (copy,nonatomic)NSString *detail;
@property (copy,nonatomic)NSString *picName;
@end
