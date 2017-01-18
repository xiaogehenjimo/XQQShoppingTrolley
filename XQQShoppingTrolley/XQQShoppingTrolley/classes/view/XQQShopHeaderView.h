//
//  XQQShopHeaderView.h
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQQShopModel;

@protocol xqq_headerViewDelegate <NSObject>

/*分组头视图按钮被点击了*/
- (void)headerViewDidPress:(NSInteger)index shopModel:(XQQShopModel*)shopModel isSel:(BOOL)isSel;

@end


@interface XQQShopHeaderView : UIView
/** 数据 */
@property(nonatomic, strong)  XQQShopModel  *  shopModel;
/** 序号 */
@property(nonatomic, assign)  NSInteger   index;
/** 代理 */
@property(nonatomic, weak)  id<xqq_headerViewDelegate>   delegate;


@end
