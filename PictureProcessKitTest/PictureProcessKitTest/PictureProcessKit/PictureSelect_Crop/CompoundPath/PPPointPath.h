//
//  SJGCommonPath.h
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPPoint.h"
@interface PPPointPath : NSObject

@property (nonatomic, strong) NSMutableArray <PPPoint *>*points;   ///< 本条路径所对应的点
@property (nonatomic, strong) NSNumber       *w;
@property (nonatomic, strong) NSNumber       *h;

// 获取点集合对应的路径
- (UIBezierPath *)bezierPathWithScale:(CGFloat)scale offset:(CGSize)offset;


/**
 获取点集合缩放路径

 @param scale 缩放比例, x,y 方向
 @param offset 偏移量, x, y 方向
 @return 对应的路径
 */
- (UIBezierPath *)scalePath:(CGPoint)scale offset:(CGPoint)offset;



/**
 根据尺寸创建一条路径

 @param rect 尺寸大小
 @return 对应路径
 */
+ (instancetype)pathWithRect:(CGRect)rect;

@end
