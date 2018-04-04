//
//  SJGPoint.m
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import "PPPoint.h"

@implementation PPPoint

/**
 快速初始化一个点
 
 @param x  x 坐标
 @param y  y 坐标
 @param type 点类型
 @return 对应的坐标点
 */
+ (instancetype)pointWithX:(NSNumber *)x y:(NSNumber *)y type:(NSNumber *)type
{
    PPPoint *point = [[PPPoint alloc] init];
    point.x = x;
    point.y = y;
    point.type = type;
    return point;
}

- (CGPoint)pointWithScale:(CGFloat)scale offset:(CGSize)offset
{
    return CGPointMake(self.x.floatValue * scale + offset.width,
                       self.y.floatValue * scale + offset.height);
}


/**
 获取缩放后的点(不等比)
 
 @param scale 缩放比例, x, y 方向
 @param offset 偏移量 x, y 方向
 @return  缩放后的点
 */
- (CGPoint)scalePoint:(CGPoint)scale offset:(CGPoint)offset
{
    return CGPointMake(self.x.floatValue * scale.x + offset.x,
                       self.y.floatValue * scale.y + offset.y);
}


@end
