//
//  XQQShopModel.h
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XQQCommodityModel;
@interface XQQShopModel : NSObject
/** 店铺名字 */
@property (nonatomic, copy)  NSString  *  shopName;
/** 店铺商品 */
@property(nonatomic, strong)  NSArray<XQQCommodityModel*>  *  commodityArr;
/** 是否是全部选中状态 */
@property(nonatomic, assign)  BOOL   isAllSelected;

@end
