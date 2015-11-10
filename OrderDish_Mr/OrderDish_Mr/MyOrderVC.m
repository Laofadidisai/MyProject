//
//  MyOrderVC.m
//  OrderDish
//
//  Created by Charles on 15/11/6.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "MyOrderVC.h"
#import "DishRecord.h"
#import "DatabaseTool.h"
#import "MyOrderCell.h"
#import "SendOrderViewController.h"
@interface MyOrderVC ()

@end

@implementation MyOrderVC

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
    
    orderArray = [DatabaseTool getAllOrderedDishes];
    
    _table.delegate = self;
    _table.dataSource = self;
    [self resetPriceLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return orderArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyOrderCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        [cell.numberField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
        cell.numberField.tag = (indexPath.row+1)*2;
        [cell.remarkField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
        cell.remarkField.tag = (indexPath.row+1)*2+1;
    }
    DishRecord *record = [orderArray objectAtIndex:indexPath.row];
    cell.indexLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.nameLabel.text = record.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%d",record.price];
    cell.kindLabel.text = record.kind;
    cell.numberField.text = [NSString stringWithFormat:@"%d",record.number];
    cell.remarkField.text = record.remark;
    //删除菜单的按钮
    [cell.closeBtn addTarget:self action:@selector(deleteDish:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
//删除菜单
-(void)deleteDish:(UIButton*)btn
{
    MyOrderCell *cell = (MyOrderCell *)btn.superview.superview.superview;
    
    NSIndexPath *indexPath = [_table indexPathForCell:cell];
    
    DishRecord *mydish = [orderArray objectAtIndex:indexPath.row];
    //数据库删除数据
    [DatabaseTool deleteOrderedDishByID:mydish.dishID];
    //数组删除数据
    [orderArray removeObjectAtIndex:indexPath.row];
    [_table reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    DishRecord *record = [orderArray objectAtIndex:indexPath.row];
    [DatabaseTool deleteOrderedDishByID:record.dishID];
    [orderArray removeObject:record];
    [_table reloadData];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int rowIndex = textField.tag/2-1;
    DishRecord *record = [orderArray objectAtIndex:rowIndex];
    if (textField.tag%2 == 0)
    {
        //left
        if ([textField.text intValue]>0)
        {
            [DatabaseTool changeNumber:[textField.text intValue] ByID:record.dishID];
        }else{
            NSLog(@"输入不合法");
        }
        record.number = [textField.text intValue];
        [self resetPriceLabel];
    }else
    {
        //right
        if (textField.text == nil)
        {
            textField.text = @"";
        }
        [DatabaseTool changeRemark:textField.text ByID:record.dishID];
        record.remark = textField.text;
    }
}

- (IBAction)gobackClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)resetPriceLabel
{
    int totalPrice = 0;
    for (int i = 0 ; i<orderArray.count; i++)
    {
        DishRecord *record = [orderArray objectAtIndex:i];
        totalPrice = totalPrice+record.price*record.number;
    }
    _priceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
}
- (IBAction)sendOrder:(id)sender
{
    SendOrderViewController *sendOrderVC = [[SendOrderViewController alloc] init];
    sendOrderVC.allDishArray = orderArray;
    [self presentViewController:sendOrderVC animated:YES completion:nil];
}

@end
