//
//  DatabaseTool.h
//  OrderDish
//
//  Created by charles on 15-11-4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dish.h"
@interface DatabaseTool : NSObject

    //初始化数据库
+ (void)initDatabase;

    //根据分组id获得这个分组的所有种类
+ (NSString *)getNameByGroupID:(int)groupID;

    //根据groupID和种类取出一种菜(一个分区section中所有的菜)
+ (NSArray *)getDishesByGroupID:(int)groupID andKind:(NSString *)kind;
//15-11-6
//写入一道菜
+ (void)insertDish:(Dish *)dish;

//获得已经点的菜的种类的数量
+ (int)getNumberOfOrderedDishKind;

//获得已经点的所有菜
+ (NSMutableArray *)getAllOrderedDishes;

//修改一个已点菜的数量
+ (void)changeNumber:(int)number ByID:(int)dishID;

//修改一个已点菜的备注
+ (void)changeRemark:(NSString *)remark ByID:(int)dishID;

//删除一种已点的菜
+ (void)deleteOrderedDishByID:(int)dishID;
@end





