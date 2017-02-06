//
//  XQQFrameTool.m
//  MA
//
//  Created by XQQ on 2017/1/29.
//  Copyright © 2017年 UIPower. All rights reserved.
//

#import "XQQFrameTool.h"


#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height


@interface XQQFrameTool ()
{
    //以下尺寸默认是手机竖屏的状态
    //3.5寸屏幕尺寸(估计没人用了吧)   320x480
    //4.0寸屏幕尺寸(5 se 系列)      320x568
    //4.7寸屏幕尺寸(6 6s 7 7s)     375x667
    //5.5寸屏幕尺寸(6p 7p)         414x736
    //给我们的标注一般都是基于4.7寸的 6或者6s上的，所以要把4.7寸的单独出来
    float _width;
    float _height;
    float _screenWidth;
    float _screenHeight;
}

@property (nonatomic, assign) float autoSizeScaleX;

@property (nonatomic, assign) float autoSizeScaleY;

@end

@implementation XQQFrameTool


+ (instancetype)sharedTool{
    static XQQFrameTool * frameTool = nil;
    @synchronized (self) {
        if (frameTool == nil) {
            frameTool = [[XQQFrameTool alloc]init];
        }
    }
    return frameTool;
}

- (instancetype)init{
    if (self = [super init]) {
        //默认切图是4.7机型
        _width = 375;
        _height = 667;
        _screenWidth = iphoneWidth;
        _screenHeight = iphoneHeight;
        [self adaptation];
    }
    return self;
}

/** 获取 Y 比例 */
+ (CGFloat)getScaleY{
    return [XQQFrameTool sharedTool].autoSizeScaleY;
}

/** 获取 X 比例 */
+ (CGFloat)getScaleX{
    return [XQQFrameTool sharedTool].autoSizeScaleX;
}
/** 适应 */
- (void)adaptation{
    switch ([self currentOrientation]) {
        case UIInterfaceOrientationPortrait:
        {
            _screenWidth  = iphoneHeight;
            _screenHeight = iphoneWidth;
        }
            break;
        default:
            break;
    }
    if ([self isIpad]) {
        self.autoSizeScaleY = 1.0;
        self.autoSizeScaleX = 1.0;
    }else{
        if (600 < _screenWidth && _screenWidth < 700) {
            self.autoSizeScaleY = 1.0;
            self.autoSizeScaleX = 1.0;
        }else{
            self.autoSizeScaleX = _screenWidth / _height;
            self.autoSizeScaleY = _screenHeight / _width;
        }
    }
}


/** 旋转状态 */
- (UIInterfaceOrientation)currentOrientation{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

/** 是否是ipad */
- (BOOL)isIpad{
    
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO;
}

@end

CGRect xqq_CGRectMake(CGFloat x,CGFloat y,CGFloat width,CGFloat height){
    CGRect rect;
    rect.origin.x = x * [XQQFrameTool getScaleX];
    rect.origin.y = y * [XQQFrameTool getScaleY];
    rect.size.width = width * [XQQFrameTool getScaleX];
    rect.size.height = height * [XQQFrameTool getScaleY];
    return rect;
}


