//
//  XQQCommodityModel.h
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQQCommodityModel : NSObject

/** 商品名字 */
@property (nonatomic, copy)  NSString  *  commodityName;
/** 商品价格 */
@property (nonatomic, copy)  NSString  *  commodityPrice;
/** 商品描述 */
@property (nonatomic, copy)  NSString  *  commodityDescription;
/** 是否是选中状态 */
@property(nonatomic, assign)  BOOL   isSelected;
/** 商品的个数 */
@property(nonatomic, assign)  NSInteger   commCount;



@end
