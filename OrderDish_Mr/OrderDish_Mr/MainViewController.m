//
//  MainViewController.m
//  OrderDish_Mr
//
//  Created by Charles on 15/11/4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "MainViewController.h"
#import "LeftViewController.h"
#import "RecomendViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
//    caixiNameArray = [[NSMutableArray alloc]initWithObjects:@"主厨推荐",@"菜系1",@"菜系2",@"菜系3",@"菜系4",@"菜系5",@"菜系6", nil];
    
    array = [[NSArray alloc] initWithObjects:@"zctj.png",@"cp.png",@"lc.png",@"rc.png",@"tl.png",@"zs.png",@"jsyl.png", nil];
    
    highLightArray = [[NSArray alloc] initWithObjects:@"hzctj.png",@"hcp.png",@"hlc.png",@"hrc.png",@"htl.png",@"hzs.png",@"hjsyl.png", nil];
    //设置table背景颜色
    caixiTableView.backgroundColor = [UIColor clearColor];
    //设置table分割线
    caixiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    caixiTableView.delegate = self;
    caixiTableView.dataSource = self;
    //先将左侧界面创建好，放到自身上面
    leftVC = [[RecomendViewController alloc] init];
    //默认显示主厨推荐
    leftVC.index = 0;
    [self.view addSubview:leftVC.view];
    //改变视图层次，让主界面视图显示在最前面
    [self.view bringSubviewToFront:caixiTableView];
}
#pragma mark 数据源协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        //设置单元格选中状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    //如果是当前选中的行，就显示高亮跟图片，否则显示普通图片
    if (indexPath.row == _currentSelectIndex) {
        cell.imageView.image = [UIImage imageNamed:[highLightArray objectAtIndex:indexPath.row]];
    }else{
        cell.imageView.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark 代理协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选哪一行就把哪一行设为高亮
    _currentSelectIndex = indexPath.row;
    [caixiTableView reloadData];
    
    //改变左侧的VC
    //先把之前显示的左边的VC.view移除
    [leftVC.view removeFromSuperview];
    
    if (indexPath.row == 0)
    {
        //主厨推荐，单独处理
        leftVC = [[RecomendViewController alloc] init];
    }
    else
    {
        //然后添加新的左侧VC.view
        leftVC = [[LeftViewController alloc] init];
    }
    //选中了右侧的菜系，左侧会有一个子界面显示相应的内容
    leftVC.index = indexPath.row;
    [self.view addSubview:leftVC.view];
    //把table放在前边
    [self.view bringSubviewToFront:caixiTableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
