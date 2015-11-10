//
//  DatabaseTool.m
//  OrderDish
//
//  Created by charles on 15-11-4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "DatabaseTool.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DishRecord.h"
FMDatabase *database = nil;

@implementation DatabaseTool
//注释：工程中的资源是只读的，后期我们需要对数据库进行增删改查的操作，所以需要将数据库放到沙盒目录中，便于操作
+ (void)initDatabase
{
    
    //获取数据库文件在工程中的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
    //设置要存放数据库的沙盒路径
    NSString *sandBoxPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/database.sqlite"];
    //创建文件管理器对象
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *err = nil;
    //检测沙盒路径中是否存在数据库文件，不存在的话就复制一份过去
    if (![manager fileExistsAtPath:sandBoxPath]) {
        [manager copyItemAtPath:path toPath:sandBoxPath error:&err];
    }
    //现在已经有数据库文件了，我们使用FMDB工具库类初始化一个数据库对象
    database = [[FMDatabase alloc] initWithPath:sandBoxPath];
    //设置缓存，提高效率
    [database setShouldCacheStatements:YES];
}

+ (NSString *)getNameByGroupID:(int)groupID
{
    //首先，打开数据库
    [database open];
    //声明一个结果集对象，用于接收数据库查询结果
    FMResultSet *rsSet = [database executeQuery:@"SELECT * FROM groupTable WHERE id = ?",[NSString stringWithFormat:@"%d",groupID]];
    //声明一个字符串对象
    NSString *name = nil;
    [rsSet next];
    //从查询出的数据中筛选对应的列
    name = [rsSet stringForColumn:@"name"];
    //对字符串进行特殊处理，过滤换行符以及空格
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //关闭结果集
    [rsSet close];
    //关闭数据库
    [database close];
    //将处理好的字符串对象返回
    return name;
}

+ (NSArray *)getDishesByGroupID:(int)groupID andKind:(NSString *)kind
{
    //首先，打开数据库
    [database open];
    //声明一个结果集对象，用于接收数据库查询结果
    FMResultSet *rsSet = [database executeQuery:@"SELECT * FROM menuTable WHERE groupID = ? AND iKind = ?",[NSString stringWithFormat:@"%d",groupID],kind];
    //创建一个数组，用于接收查询处理后的结果
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    //next不仅会检查有没有下一条数据，而且会跳到下一条数据
    while ([rsSet next]) {
        //Dish是自己创建的数据模型类，用于存储每一个菜的数据
        Dish *di = [Dish new];//new相当于alloc init
        di.dishID = [rsSet intForColumn:@"id"];
        di.groupID = [rsSet intForColumn:@"groupID"];
        di.kind = [rsSet stringForColumn:@"iKind"];
        di.name = [rsSet stringForColumn:@"name"];
        di.price = [rsSet intForColumn:@"price"];
        di.unit = [rsSet stringForColumn:@"unit"];
        di.detail = [rsSet stringForColumn:@"detail"];
        di.picName = [rsSet stringForColumn:@"picName"];
        [array addObject:di];
    }
    //关闭结果集
    [rsSet close];
    //关闭数据库
    [database close];
    //将处理好的数据返回
    return [NSArray arrayWithArray:array];
}
//15-11-6
+ (void)insertDish:(Dish *)dish
{
    [database open];
    FMResultSet *rsSet = [database executeQuery:@"SELECT * FROM orderTable WHERE id = ?",[NSString stringWithFormat:@"%d",dish.dishID]];
    
    if ([rsSet next])
    {
        //如果已经存在这道菜，就数量+1
        int num = [rsSet intForColumn:@"menuNum"];
        num++;
        [database executeUpdate:@"UPDATE orderTable SET menuNum = ? WHERE id = ?",[NSString stringWithFormat:@"%d",num],[NSString stringWithFormat:@"%d",dish.dishID]];
    }
    else
    {
        [database executeUpdate:@"INSERT INTO orderTable (id,menuName,Price,kind,menuNum,remark) VALUES (?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",dish.dishID],dish.name,[NSString stringWithFormat:@"%d",dish.price],dish.kind,@"1",@""];
    }
    [rsSet close];
    [database close];
}
+ (int)getNumberOfOrderedDishKind
{
    [database open];
    FMResultSet *rsSet = [database executeQuery:@"SELECT count(*) from orderTable"];
    [rsSet next];
    int number = [rsSet intForColumnIndex:0];
    [rsSet close];
    [database close];
    return number;
}
+ (NSMutableArray *)getAllOrderedDishes
{
    [database open];
    FMResultSet *rsSet = [database executeQuery:@"SELECT * FROM orderTable"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ([rsSet next]) {
        DishRecord *record = [DishRecord new];
        record.dishID = [rsSet intForColumn:@"id"];
        record.name = [rsSet stringForColumn:@"menuName"];
        record.price = [rsSet intForColumn:@"Price"];
        record.kind = [rsSet stringForColumn:@"kind"];
        record.number = [rsSet intForColumn:@"menuNum"];
        record.remark = [rsSet stringForColumn:@"remark"];
        [array addObject:record];
    }
    [rsSet close];
    [database close];
    return array;
}
+ (void)changeNumber:(int)number ByID:(int)dishID
{
    [database open];
    [database executeUpdate:@"UPDATE orderTable SET menuNum = ? WHERE id = ?",[NSString stringWithFormat:@"%d",number],[NSString stringWithFormat:@"%d",dishID]];
    [database close];
}
+ (void)changeRemark:(NSString *)remark ByID:(int)dishID
{
    [database open];
    [database executeUpdate:@"UPDATE orderTable SET remark = ? WHERE id = ?",remark,[NSString stringWithFormat:@"%d",dishID]];
    [database close];
}
+ (void)deleteOrderedDishByID:(int)dishID
{
    [database open];
    [database executeUpdate:@"DELETE FROM orderTable WHERE id = ?",[NSString stringWithFormat:@"%d",dishID]];
    [database close];
}
@end






