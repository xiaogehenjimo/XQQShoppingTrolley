//
//  XQQShopModel.m
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "XQQShopModel.h"
#import "XQQCommodityModel.h"
@implementation XQQShopModel


- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"commoditys"]) {
        NSMutableArray * tempDataArr = @[].mutableCopy;
        NSArray * tempArr = (NSArray*)value;
        for (NSDictionary * dict in tempArr) {
            XQQCommodityModel * model = [[XQQCommodityModel alloc]init];
            //[model setValuesForKeysWithDictionary:dict];
            model.commodityPrice = dict[@"commodityPrice"];
            model.commodityDescription = dict[@"commodityDescription"];
            model.commodityName = dict[@"commodityName"];
            model.isSelected = NO;
            model.commCount = 1;
            [tempDataArr addObject:model];
        }
        self.commodityArr = tempDataArr;
    }else if ([key isEqualToString:@"shopName"]){
        self.shopName = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
