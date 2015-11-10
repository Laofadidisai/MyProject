//
//  DishRecord.h
//  OrderDish
//
//  Created by Charles on 15/11/6.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DishRecord : NSObject

@property (assign,nonatomic)int dishID;
@property (copy,nonatomic)NSString *name;
@property (assign,nonatomic)int price;
@property (copy,nonatomic)NSString *kind;
@property (copy,nonatomic)NSString *remark;

@property (assign,nonatomic)int number;

@end
