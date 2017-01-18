//
//  XQQShopHeaderView.m
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "XQQShopHeaderView.h"
#import "XQQShopModel.h"

#define boardWidth 10
#define headerHeight 50
#define leftSelBtnWH  30

@interface XQQShopHeaderView ()
/** 左侧按钮 */
@property(nonatomic, strong)  UIButton *  leftSelBtn;
/** 店铺名字label */
@property(nonatomic, strong)  UILabel  *  shopNameLabel;


/** 左侧按钮点击 */
@property(nonatomic, assign)  BOOL   isLeftBtnSel;

@end

@implementation XQQShopHeaderView
//50
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIButton * leftSelBtn = [[UIButton alloc]initWithFrame:CGRectMake(boardWidth,(headerHeight - leftSelBtnWH)*.5, leftSelBtnWH, leftSelBtnWH)];
        //leftSelBtn.backgroundColor = [UIColor redColor];
//        [leftSelBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        [self addSubview:leftSelBtn];
        [leftSelBtn addTarget:self action:@selector(leftSelBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        self.leftSelBtn = leftSelBtn;
        
        UILabel * shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSelBtn.xqq_right + boardWidth, leftSelBtn.xqq_x, iphoneWidth - 3 * boardWidth - leftSelBtn.xqq_width, leftSelBtnWH)];
        shopNameLabel.text = @"今年今月旗舰店";
        shopNameLabel.font = [UIFont boldSystemFontOfSize:19];
        shopNameLabel.textColor = [UIColor blackColor];
        //shopNameLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:shopNameLabel];
        self.shopNameLabel = shopNameLabel;
    }
    return self;
}

- (void)leftSelBtnDidPress:(UIButton*)button{
    if (self.isLeftBtnSel) {
        [self.leftSelBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        self.isLeftBtnSel = NO;
    }else{
        [self.leftSelBtn setImage:XQQImageName(@"GameCenterNewAppTag") forState:UIControlStateNormal];
        self.isLeftBtnSel = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewDidPress:shopModel:isSel:)]) {
        [self.delegate headerViewDidPress:self.index shopModel:self.shopModel isSel:self.isLeftBtnSel];
    }
}

- (void)setShopModel:(XQQShopModel *)shopModel{
    _shopModel = shopModel;
    if (shopModel.isAllSelected) {
        [self.leftSelBtn setImage:XQQImageName(@"GameCenterNewAppTag") forState:UIControlStateNormal];
        self.isLeftBtnSel = YES;
    }else{
        [self.leftSelBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        self.isLeftBtnSel = NO;
    }
    self.shopNameLabel.text = shopModel.shopName;
    
}


@end
