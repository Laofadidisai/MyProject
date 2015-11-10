//
//  DishDetailVC.m
//  OrderDish
//
//  Created by Charles on 15/11/5.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "DishDetailVC.h"

@interface DishDetailVC ()

@end

@implementation DishDetailVC
@synthesize dish;
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
    
    imgView.image = [UIImage imageNamed:self.dish.picName];
    nameLabel.text = self.dish.name;
    priceLabel.text = [NSString stringWithFormat:@"%d元/%@",self.dish.price,self.dish.unit];
}

- (IBAction)gobackClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
