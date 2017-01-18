//
//  XQQShopTableViewCell.m
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "XQQShopTableViewCell.h"
#import "XQQShopModel.h"
#import "XQQCommodityModel.h"

#define cellHeight 100//整体的高度

#define backHeight 90//背景内容的高度
#define backWidth  iphoneWidth - boardWidth //内容的宽


#define smallBtnWH 25 //右下角按钮尺寸

#define boardWidth 10

#define leftSelBtnWH  30




@interface XQQShopTableViewCell ()
/** 背景View */
@property(nonatomic, strong)  UIView  *  backView;
/** 左侧选择的按钮 */
@property(nonatomic, strong)  UIButton  *  leftSelBtn;
/** 商品的图片 */
@property(nonatomic, strong)  UIImageView  *  commodityImageView;
/** 商品名字 */
@property(nonatomic, strong)  UILabel  *  commodityNameLabel;
/** 商品详情label */
@property(nonatomic, strong)  UILabel  *  commodityDetailLabel;
/** 价格label */
@property(nonatomic, strong)  UILabel  *  priceLabel;
/** 减号按钮 */
@property(nonatomic, strong)  UIButton  *  minusBtn;
/** 数量label */
@property(nonatomic, strong)  UILabel  *  countLabel;
/** 加号按钮 */
@property(nonatomic, strong)  UIButton  *  addBtn;


/** 左侧按钮 */
@property(nonatomic, assign)  BOOL   isLeftBtnSel;



@end

@implementation XQQShopTableViewCell

+ (instancetype)cellForTableView:(UITableView*)tableView
                       indexPath:(NSIndexPath*)indexPath{
    static NSString * cellID = @"shopCellID";
    XQQShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[XQQShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = XQQSingleColor(242);
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景view
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, boardWidth * .5, iphoneWidth - boardWidth, cellHeight-boardWidth)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        self.backView = backView;
        
        //左侧选中的按钮
        UIButton * leftSelBtn = [[UIButton alloc]init];
//        [leftSelBtn setImage:XQQImageName(@"GameCenterNewWhite") forState:UIControlStateNormal];
        [leftSelBtn addTarget:self action:@selector(leftSelBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backView addSubview:leftSelBtn];
        
        self.leftSelBtn = leftSelBtn;
        
        //商品的imageView
        UIImageView * commodityImageView = [[UIImageView alloc]init];
        commodityImageView.image = XQQImageName(@"watch-tips-avatar");
        
        [self.backView addSubview:commodityImageView];
        self.commodityImageView = commodityImageView;
        
        
        //商品标题label
        UILabel * commodityNameLabel = [[UILabel alloc]init];
        //commodityNameLabel.text = @"[金秋爆款]羽绒服 男士款";
        commodityNameLabel.textColor = [UIColor blackColor];
        commodityNameLabel.font = [UIFont systemFontOfSize:18];
        [self.backView addSubview:commodityNameLabel];
        self.commodityNameLabel = commodityNameLabel;
        
        //商品详情描述label
        UILabel * commodicyDetailLabel = [[UILabel alloc]init];
        commodicyDetailLabel.text = @"fjehfehfeiofheiohfhehfehfoehfoehfehfiohfiiefihefhiehfiei";
        commodicyDetailLabel.font = [UIFont systemFontOfSize:15];
        commodicyDetailLabel.textColor = [UIColor blackColor];
        commodicyDetailLabel.numberOfLines = 0;
        [self.backView addSubview:commodicyDetailLabel];
        self.commodityDetailLabel = commodicyDetailLabel;
        
        //价格label
        UILabel * priceLabel = [[UILabel alloc]init];
        //priceLabel.text = @"998.55";//245  61  28
        priceLabel.textColor = XQQColor(245, 61, 28);
        priceLabel.font = [UIFont boldSystemFontOfSize:18];
        priceLabel.textAlignment = NSTextAlignmentRight;
        [self.backView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        //减号按钮
        UIButton * minusBtn = [[UIButton alloc]init];
        [minusBtn setImage:XQQImageName(@"RemoveGroupMemberBtn") forState:UIControlStateNormal];
        [minusBtn setImage:XQQImageName(@"RemoveGroupMemberBtnHL") forState:UIControlStateHighlighted];
        [minusBtn addTarget:self action:@selector(minusBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:minusBtn];
        self.minusBtn = minusBtn;
        
        //中间数量label
        UILabel * countLabel = [[UILabel alloc]init];
        //countLabel.text = @"1";
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.textColor = [UIColor blackColor];
        countLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.backView addSubview:countLabel];
        self.countLabel = countLabel;
        //加号按钮
        UIButton * addBtn = [[UIButton alloc]init];
        [addBtn setImage:XQQImageName(@"AlbumAddBtn") forState:UIControlStateNormal];
        [addBtn setImage:XQQImageName(@"AlbumAddBtnHL") forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(addBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:addBtn];
        self.addBtn = addBtn;
        //点击手势
        UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellDidPress:)];
        [self addGestureRecognizer:sigleTap];
        [self setNeedsDisplay];
 
        //测试颜色
        //addBtn.backgroundColor = [UIColor greenColor];
        //countLabel.backgroundColor = [UIColor orangeColor];
        //minusBtn.backgroundColor = [UIColor purpleColor];
        //priceLabel.backgroundColor = [UIColor blueColor];
        //commodicyDetailLabel.backgroundColor = [UIColor yellowColor];
        //commodityNameLabel.backgroundColor = [UIColor orangeColor];
        //commodityImageView.backgroundColor = [UIColor redColor];
        //leftSelBtn.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

//100
- (void)layoutSubviews{
    [super layoutSubviews];
    //左侧按钮
     self.leftSelBtn.frame = CGRectMake(boardWidth, (backHeight - leftSelBtnWH)*.5, leftSelBtnWH, leftSelBtnWH);
    
     self.commodityImageView.frame = CGRectMake(self.leftSelBtn.xqq_right + boardWidth, boardWidth*.5, backHeight - boardWidth, backHeight - boardWidth);
    
     self.priceLabel.frame = CGRectMake(backWidth - 80 - boardWidth, boardWidth, 80, 30);
    
     self.commodityNameLabel.frame = CGRectMake(self.commodityImageView.xqq_right + boardWidth, boardWidth, backWidth - 5*boardWidth - self.leftSelBtn.xqq_width - self.commodityImageView.xqq_width - self.priceLabel.xqq_width, 25);

     self.addBtn.frame = CGRectMake(backWidth - boardWidth - smallBtnWH, self.backView.xqq_bottom - boardWidth - smallBtnWH, smallBtnWH, smallBtnWH);
    
    
     self.countLabel.frame = CGRectMake(self.addBtn.xqq_x - boardWidth*.5-smallBtnWH, self.addBtn.xqq_y, smallBtnWH, smallBtnWH);
    
     self.minusBtn.frame = CGRectMake(self.countLabel.xqq_x - boardWidth*.5 - smallBtnWH, self.addBtn.xqq_y, smallBtnWH, smallBtnWH);
    
     self.commodityDetailLabel.frame = CGRectMake(self.commodityImageView.xqq_right + boardWidth, self.commodityNameLabel.xqq_bottom + boardWidth*.5,backWidth - 5.5 * boardWidth - self.leftSelBtn.xqq_width - self.commodityImageView.xqq_width - smallBtnWH*3, backHeight - boardWidth * 2 - self.commodityNameLabel.xqq_height);
    
}


#pragma mark - activity

/** 左侧选择的按钮点击了 */
- (void)leftSelBtnDidPress:(UIButton*)button{
    if (self.isLeftBtnSel) {
        [self.leftSelBtn setImage:XQQImageName(@"sight_moments_mute_select") forState:UIControlStateNormal];
        self.isLeftBtnSel = NO;
    }else{//245  61  28
        [self.leftSelBtn setImage:XQQImageName(@"sight_moments_mute_selected") forState:UIControlStateNormal];
        self.isLeftBtnSel = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftSelBtnDidPress:cell:isSel:)]) {
        [self.delegate leftSelBtnDidPress:self.dataModel cell:self isSel:self.isLeftBtnSel];
    }
}
/** 减号按钮点击 */
- (void)minusBtnDidPress:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(minusBtnDidPress:cell:)]) {
        [self.delegate minusBtnDidPress:self.dataModel cell:self];
    }
}
/** 加号按钮点击 */
- (void)addBtnDidPress:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addBtnDidPress:cell:)]) {
        [self.delegate addBtnDidPress:self.dataModel cell:self];
    }
}

/** cell点击 */
- (void)cellDidPress:(UITapGestureRecognizer*)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shopCellDidPress:cell:)]) {
        [self.delegate shopCellDidPress:self.dataModel cell:self];
    }
}

#pragma mark - setter&getter

- (void)setDataModel:(XQQCommodityModel *)dataModel{
    _dataModel = dataModel;
    if (dataModel.isSelected) {
        [self.leftSelBtn setImage:XQQImageName(@"sight_moments_mute_selected") forState:UIControlStateNormal];
        self.isLeftBtnSel = YES;
    }else{
        [self.leftSelBtn setImage:XQQImageName(@"sight_moments_mute_select") forState:UIControlStateNormal];
        self.isLeftBtnSel = NO;
    }
    self.commodityNameLabel.text = dataModel.commodityName;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",dataModel.commCount];
    self.priceLabel.text = dataModel.commodityPrice;
    self.commodityDetailLabel.text = dataModel.commodityDescription;
}

@end
