//
//  mainViewController.m
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "mainViewController.h"
#import "XQQShoppingController.h"
@interface mainViewController ()


@property(nonatomic, strong) UIButton * nextBtn;

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.nextBtn];
}


- (void)nextBtnDidPress:(UIButton*)button{
    XQQShoppingController * shopVC = [[XQQShoppingController alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
}



- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake((iphoneWidth - 100)*.5, 100, 100, 44)];
        [_nextBtn setTitle:@"进入购物车" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = [UIColor yellowColor];
        [_nextBtn addTarget:self action:@selector(nextBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
@end
