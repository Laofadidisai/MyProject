//
//  LeftViewController.m
//  OrderDish
//
//  Created by charles on 15-11-4.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "LeftViewController.h"
//1.数据库工具类和数据模型要提前写好，导入进来
#import "DatabaseTool.h"
#import "Dish.h"

#import "DishDetailVC.h"
#import "MyOrderVC.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

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
    //2.从主界面右侧列表获得，选中了哪种菜系
    _headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dicon.png",self.index+1]];
    
    NSString *name = [DatabaseTool getNameByGroupID:self.index+1];
    _nameArray = [name componentsSeparatedByString:@"|"];
    _dishArray = [[NSMutableArray alloc] initWithCapacity:0];
    //3.根据菜系从数据库中取得对应的菜品，并存入数组中
    for (int i = 0; i<_nameArray.count; i++)
    {
        NSArray *array = [DatabaseTool getDishesByGroupID:self.index+1 andKind:_nameArray[i]];
        [_dishArray addObject:array];
    }
    //4.给关联的菜品列表设置代理等属性
    _table.delegate = self;
    _table.dataSource = self;
    _table.sectionHeaderHeight = 40;
    _table.backgroundColor = [UIColor clearColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //5.设置滚动视图相关代理和属性
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    //6.刷新滚动视图显示
    [self refreshScrollView];
}
#pragma mark 表的数据源协议方法
//表中几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}
//每个区有几行（折合表思路）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == currentOpenSection)
    {
        return [[_dishArray objectAtIndex:section] count];
    }
    else
    {
        return 0;
    }
}
//每行如何显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor yellowColor];
        cell.detailTextLabel.textColor = [UIColor yellowColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //将菜品从数组中还原，并显示在单元格中
    Dish *dish = [[_dishArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = dish.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d元/%@",dish.price,dish.unit];
    return cell;
}
//选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.根据你选中了哪一行单元格，设置滚动视图需要滚动几屏
    [_scrollView setContentOffset:CGPointMake(indexPath.row*_scrollView.frame.size.width, 0) animated:YES];
    //2.找出对应的单元格，做翻转动画
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    [UIView commitAnimations];
    
    currentSelectDishIndex = indexPath.row;
}
//折合视图相关
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 40)];
    UIButton *button = [[UIButton alloc]init];
    button.frame = view.frame;
    button.tag = section+1;
    [button addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"line31.png"] forState:UIControlStateNormal];
    [button setTitle:[_nameArray objectAtIndex:section] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}
- (void)headerButtonClick:(UIButton *)sender{
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    //之前打开的section
    [indexSet addIndex:currentOpenSection];
    
    currentOpenSection = sender.tag - 1;
    
    //将要打开的section
    [indexSet addIndex:currentOpenSection];
    
    [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self refreshScrollView];
}

#pragma mark- scroll
- (void)refreshScrollView
{
    //1.首先得到当前哪个区处于打开状态，这个区有几行数据
    int count = [[_dishArray objectAtIndex:currentOpenSection] count];
    //2.处理这个区对应的右侧滚动视图显示
    //先移除之前添加的图片（类似易百生活城市模块）
    for (UIView *view in [_scrollView subviews])
    {
        if (view.tag == 10)
        {
            [view removeFromSuperview];
        }
    }
    //然后设置滚动视图容量
    _scrollView.contentSize = CGSizeMake(count*_scrollView.frame.size.width, _scrollView.frame.size.height);
    //创建相应的图片视图，放到滚动视图中
    for (int i = 0; i<count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imgView.tag = 10;
        Dish *dish = [[_dishArray objectAtIndex:currentOpenSection] objectAtIndex:i];
        imgView.image = [UIImage imageNamed:dish.picName];
        [_scrollView addSubview:imgView];
    }
    //设置默认显示位置
    _scrollView.contentOffset = CGPointMake(0, 0);
}
#pragma mark 滚动视图的协议方法
//滚动视图停止加速的时候，该方法被调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView)
    {
        //1.根据偏移量计算出偏移到了哪个单元格索引
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:page inSection:currentOpenSection];
        //2.找出对应的单元格，滚到这个单元格，并做翻转动画
        UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
        
        [_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
        [UIView commitAnimations];
    }
}
#pragma mark 点菜和菜品详情按钮事件
- (IBAction)orderBtnClicked:(id)sender {
    Dish *dish = [[_dishArray objectAtIndex:currentOpenSection] objectAtIndex:currentSelectDishIndex];
    [DatabaseTool insertDish:dish];
    //[self reFreshNumberLabel];
}
- (IBAction)detailsBtnClicked:(id)sender
{
    //找到选中了哪个菜品
    Dish *sel_dish = [[_dishArray objectAtIndex:currentOpenSection] objectAtIndex:currentSelectDishIndex];
    //创建菜品详情界面
    DishDetailVC *dishdetails = [[DishDetailVC alloc ] init];
    //将选中的菜品赋值给详情界面的属性
    dishdetails.dish = sel_dish;
    //设置模态方式，并模态显示
    dishdetails.modalPresentationStyle = UIModalPresentationFormSheet;
    dishdetails.modalTransitionStyle =
    UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:dishdetails animated:YES completion:nil];
}
//我的菜单
- (IBAction)myOrder:(id)sender
{
    MyOrderVC *vc = [[MyOrderVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
