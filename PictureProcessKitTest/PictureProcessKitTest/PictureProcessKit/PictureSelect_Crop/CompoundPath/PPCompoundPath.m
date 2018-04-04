//
//  SJGCompoundPath.m
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import "PPCompoundPath.h"

@implementation PPCompoundPath


- (UIBezierPath *)getBeizerPathWithScale:(CGFloat)scale offset:(CGSize)offset;
{
    UIBezierPath *bigPath = [UIBezierPath bezierPath];
    // 外层循环, 遍历 Path
    for (NSInteger i = 0; i < self.paths.count; i ++) {
        // 取出路径
        PPPointPath *pointPath = self.paths[i];
        UIBezierPath *path = [pointPath bezierPathWithScale:scale offset:offset];
        path.usesEvenOddFillRule = YES;
        [bigPath appendPath:path];
    }
    return bigPath;
}


/**
 获取此复合路径的缩放符合路径
 
 @param scale 缩放倍数, x,y 方向
 @param offset 偏移量, x,y 方向
 @return 转化后的 beizerPath
 */
- (UIBezierPath *)scaleBeizerPath:(CGPoint)scale offset:(CGPoint)offset
{
    UIBezierPath *bigPath = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.paths.count; i++) {
        
        PPPointPath *pointPath = self.paths[i];
        UIBezierPath *path = [pointPath scalePath:scale offset:offset];
        path.usesEvenOddFillRule = YES;
        [bigPath appendPath:path];;
    }
    return bigPath;
}


/**
 创建矩形蒙版
 
 @param rect 蒙版区域
 @return 对应的蒙版数组
 */
+ (instancetype)compoundPathWithRect:(CGRect)rect
{
    PPCompoundPath *path = [[PPCompoundPath alloc] init];
    path.w = @(CGRectGetWidth(rect));
    path.h = @(CGRectGetHeight(rect));
    path.x = @(CGRectGetMinX(rect));
    path.y = @(CGRectGetMinY(rect));
    PPPointPath *pointPath = [PPPointPath pathWithRect:rect];
    path.paths = [NSMutableArray arrayWithObject:pointPath];
    return path;
}


@end

