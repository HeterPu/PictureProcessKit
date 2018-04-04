//
//  UIView+XLExtension.h
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XL_ScreenBounds [UIScreen mainScreen].bounds
#define XL_ScreenSize [UIScreen mainScreen].bounds.size
#define XL_ScreenW [UIScreen mainScreen].bounds.size.width
#define XL_ScreenH [UIScreen mainScreen].bounds.size.height
#define xl__autoSizeScaleX ([UIScreen mainScreen].bounds.size.width / 375)
#define xl__autoSizeScaleY ([UIScreen mainScreen].bounds.size.height / 667)

#define XL_Deprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
#define XL_KeyWindow [UIApplication sharedApplication].windows.firstObject

/**
 *  动画类型
 */
typedef NS_ENUM(NSUInteger, XL_AnimationType){
    /**
     *  弹性动画放大
     */
    XL_AnimationTypeToBigger = 1,
    /**
     *  缩小的弹性动画
     */
    XL_AnimationTypeToSmaller = 2
};

@interface UIView (XL_Extension)

@property (nonatomic, assign) CGFloat height XL_Deprecated("请使用xl_height");
@property (nonatomic, assign) CGFloat width XL_Deprecated("请使用xl_width");
@property (nonatomic, assign) CGFloat x  XL_Deprecated("请使用xl_x");
@property (nonatomic, assign) CGFloat y XL_Deprecated("请使用xl_y");
@property (nonatomic, assign) CGFloat centerX XL_Deprecated("请使用xl_centerX");
@property (nonatomic, assign) CGFloat centerY XL_Deprecated("请使用xl_centerY");

@property (nonatomic, assign) CGFloat xl__height;
@property (nonatomic, assign) CGFloat xl__width;
@property (nonatomic, assign) CGFloat xl__x;
@property (nonatomic, assign) CGFloat xl__y;
@property (nonatomic, assign) CGSize xl__size;
@property (nonatomic, assign) CGFloat xl__centerX;
@property (nonatomic, assign) CGFloat xl__centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)xl__isShowingOnKeyWindow;

/**
 *  加载xibview
 */
+ (instancetype)xl__viewFromXib ;

/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 */
- (void)xl__showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY XL_Deprecated("请使用其他同类方法");
/**
 *  在view上面绘制一个指定width宽度的红色提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 宽度
 */
- (void)xl__showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width ;
/**
 *  在view上面绘制一个指定width宽度的 指定颜色的提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 圆点的直径
 *  @param color 圆点的颜色
 */
- (void)xl__showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor;
/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 *  @param numberCount 展示的数字
 */
- (void)xl__showRedTipViewWithNumberCountInRedX:(CGFloat)redX redY:(CGFloat)redY numberCount:(NSInteger)numberCount;

/**
 *  隐藏红色提醒圆点
 */
- (void)xl_hideRedTipView;

/**
 *  类方法,对指定的layer进行弹性动画
 *
 *  @param layer 进行动画的图层
 *  @param type  动画类型
 */
+ (void)xl__showOscillatoryAnimationWithLayer:(CALayer *)layer type:(XL_AnimationType)type;
/**
 *  给视图添加虚线边框
 *
 *  @param lineWidth  线宽
 *  @param lineMargin 每条虚线之间的间距
 *  @param lineLength 每条虚线的长度
 *  @param lineColor 每条虚线的颜色
 */
- (void)xl__addDottedLineBorderWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor;

@end
