//
//  XQQFrameTool.h
//  MA
//
//  Created by XQQ on 2017/1/29.
//  Copyright © 2017年 UIPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


FOUNDATION_EXPORT CGRect xqq_CGRectMake(CGFloat x,CGFloat y,CGFloat width,CGFloat height);

@interface XQQFrameTool : NSObject

+ (instancetype)sharedTool;

/** 获取 Y 比例 */
+ (CGFloat)getScaleY;
/** 获取 X 比例 */
+ (CGFloat)getScaleX;

@end
