//
//  SJGCompoundPath.h
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

//@import UIKit;
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PPPointPath.h"

@interface PPCompoundPath : NSObject

@property (nonatomic, strong) NSMutableArray <PPPointPath *>*paths;    ///< 需要绘制的路径, 多条简单路径
@property (nonatomic, strong) NSNumber       *w;
@property (nonatomic, strong) NSNumber       *h;
@property (nonatomic, strong) NSNumber       *x;
@property (nonatomic, strong) NSNumber       *y;


/**
 创建矩形蒙版
 
 @param rect 蒙版区域
 @return 对应的蒙版数组
 */
+ (instancetype)compoundPathWithRect:(CGRect)rect;

/**
 *  获取此复合路径模型对应的复合路径
 *
 *  @param scale   缩放倍数(保持宽高比)
 *  @param offset  偏移量
 *
 *  @return 转化后的 beizerPath
 */
- (UIBezierPath *)getBeizerPathWithScale:(CGFloat)scale offset:(CGSize)offset;


/**
 获取此复合路径的缩放符合路径
 
 @param scale 缩放倍数, x,y 方向
 @param offset 偏移量, x,y 方向
 @return 转化后的 beizerPath
 */
- (UIBezierPath *)scaleBeizerPath:(CGPoint)scale offset:(CGPoint)offset;


@end
