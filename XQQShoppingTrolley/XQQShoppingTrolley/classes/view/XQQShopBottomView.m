//
//  XQQShopBottomView.m
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "XQQShopBottomView.h"
#import "XQQCommodityModel.h"

#define selectBtnWH 30
#define boardWidth 10
#define viewHeight 70


@interface XQQShopBottomView ()
/** 全选按钮 */
@property(nonatomic, strong)  UIButton *  selectAllBtn;
/** 价格label */
@property(nonatomic, strong)  UILabel  *  sumLabel;
/** 结算按钮 */
@property(nonatomic, strong)  UIButton  *  accountBtn;

/** 全选按钮点击 */
@property(nonatomic, assign)  BOOL   isSelectAll;
/** 选中商品的个数 */
@property(nonatomic, assign)  NSInteger   selectCount;
@end


@implementation XQQShopBottomView
//100
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = XQQSingleColor(222);
        //左侧按钮
        UIButton * selectAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(boardWidth, (viewHeight - selectBtnWH)*.5, selectBtnWH*3, selectBtnWH)];
        [selectAllBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectAllBtn addTarget:self action:@selector(leftSelectAllBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        //selectAllBtn.backgroundColor = [UIColor redColor];
        [self addSubview:selectAllBtn];
        self.selectAllBtn = selectAllBtn;
        
        UIButton * accountBtn = [[UIButton alloc]initWithFrame:CGRectMake(iphoneWidth - (iphoneWidth /3.0 - 2*boardWidth), 0, iphoneWidth /3.0 - 2*boardWidth, viewHeight)];
        accountBtn.backgroundColor = XQQColor(226, 84, 91);
        [accountBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [accountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [accountBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [accountBtn addTarget:self action:@selector(accountBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:accountBtn];
        self.accountBtn = accountBtn;
        
        //价格label
        UILabel * sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(selectAllBtn.xqq_right + boardWidth, (viewHeight - selectBtnWH)*.5, iphoneWidth - 3*boardWidth - self.selectAllBtn.xqq_width - self.accountBtn.xqq_width, selectBtnWH)];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"合计:¥0.00"];
        [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} range:NSMakeRange(3, att.length - 3)];
        sumLabel.attributedText = att;
        //sumLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:sumLabel];
        self.sumLabel = sumLabel;
    }
    return self;
}

- (void)updateArr:(NSArray*)selectedArr{
    //计算价格
    CGFloat sumPrice = 0;
    NSInteger sumCount = 0;//选中商品总数
    for (NSArray * selArr in selectedArr) {
        NSInteger count = selArr.count;
        sumCount += count;
        if (count > 0) {
            for (NSInteger i = 0; i < count; i ++) {
                XQQCommodityModel * commodModel = selArr[i];
                sumPrice += [commodModel.commodityPrice doubleValue] * commodModel.commCount;
            }
        }
    }
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合计:¥%.2f",sumPrice]];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} range:NSMakeRange(3, att.length - 3)];
    self.sumLabel.attributedText = att;
    
    
    self.selectCount = sumCount;
    
    NSString * accountBtnTitle = sumCount > 0 ? [NSString stringWithFormat:@"去结算(%ld)",sumCount]:@"去结算";
    
    [self.accountBtn setTitle:accountBtnTitle forState:UIControlStateNormal];
}

/** 去结算按钮点击了 */
- (void)accountBtnDidPress:(UIButton*)button{
    if (self.selectCount > 0) {
        NSLog(@"进入结算页面");
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"至少选择一件商品" message:@"" delegate:nil cancelButtonTitle:@"去选择" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)setIsAllSelected:(BOOL)isAllSelected{
    _isAllSelected = isAllSelected;
    if (!isAllSelected) {
        [self.selectAllBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        self.isSelectAll = NO;
    }else{
        [self.selectAllBtn setImage:XQQImageName(@"GameCenterNewAppTag") forState:UIControlStateNormal];
        self.isSelectAll = YES;
    }
}

/** 全选按钮点击了 */
- (void)leftSelectAllBtnDidPress:(UIButton*)button{
    if (self.isSelectAll) {
        [self.selectAllBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        self.isSelectAll = NO;
    }else{
        [self.selectAllBtn setImage:XQQImageName(@"GameCenterNewAppTag") forState:UIControlStateNormal];
        self.isSelectAll = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedAllBtnDidPress:isSel:)]) {
        [self.delegate selectedAllBtnDidPress:button isSel:self.isSelectAll];
    }
}

@end
