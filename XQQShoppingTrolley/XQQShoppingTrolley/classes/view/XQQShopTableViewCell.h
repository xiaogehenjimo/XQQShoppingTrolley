//
//  XQQShopTableViewCell.h
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQQShopModel;
@class XQQShopTableViewCell;
@class XQQCommodityModel;

@protocol shopCellPressDelegate <NSObject>
/**cell点击了*/
- (void)shopCellDidPress:(XQQCommodityModel*)commodModel cell:(XQQShopTableViewCell*)Cell;
/**加号按钮点击了*/
- (void)addBtnDidPress:(XQQCommodityModel*)commodModel cell:(XQQShopTableViewCell*)Cell;
/**减号按钮点击了*/
- (void)minusBtnDidPress:(XQQCommodityModel*)commodModel cell:(XQQShopTableViewCell*)Cell;
/**左侧选择按钮点击了*/
- (void)leftSelBtnDidPress:(XQQCommodityModel*)commodModel cell:(XQQShopTableViewCell*)cell isSel:(BOOL)isSel;
@end


@interface XQQShopTableViewCell : UITableViewCell


+ (instancetype)cellForTableView:(UITableView*)tableView
                       indexPath:(NSIndexPath*)indexPath;

/** 模型 */
@property(nonatomic, strong)  XQQCommodityModel  *  dataModel;
/** 代理 */
@property(nonatomic, weak)  id<shopCellPressDelegate>   delegate;
@end
