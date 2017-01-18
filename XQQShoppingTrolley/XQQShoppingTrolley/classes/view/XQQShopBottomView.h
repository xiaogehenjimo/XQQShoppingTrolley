//
//  XQQShopBottomView.h
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol xqq_shopBottomViewDelegate <NSObject>

- (void)selectedAllBtnDidPress:(UIButton*)button isSel:(BOOL)isSel;

@end

@interface XQQShopBottomView : UIView
/** 代理 */
@property(nonatomic, assign)  id<xqq_shopBottomViewDelegate>  delegate;

- (void)updateArr:(NSArray*)selectedArr;
/** 是否是全选 */
@property(nonatomic, assign)  BOOL   isAllSelected;

@end
