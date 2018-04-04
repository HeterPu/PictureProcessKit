//
//  SJGCommonPath.m
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import "PPPointPath.h"

@implementation PPPointPath
/**
 根据尺寸创建一条路径
 
 @param rect 尺寸大小
 @return 对应路径
 */
+ (instancetype)pathWithRect:(CGRect)rect
{
    PPPointPath *path = [[PPPointPath alloc] init];
    path.w = @(CGRectGetWidth(rect));
    path.h = @(CGRectGetHeight(rect));
    path.points = [NSMutableArray arrayWithCapacity:5];
    
    NSNumber *minx   = @(CGRectGetMinX(rect));
    NSNumber *minY   = @(CGRectGetMinY(rect));
    NSNumber *width  = @(CGRectGetWidth(rect));
    NSNumber *height = @(CGRectGetHeight(rect));
    
    // 左上
    PPPoint *lt = [PPPoint pointWithX:minx y:minY type:@(PPOD_TT_PRIM_MOVE)];
    [path.points addObject:lt];
    // 右上
    PPPoint *rt = [PPPoint pointWithX:width y:minY type:@(PPOD_TT_PRIM_LINE)];
    [path.points addObject:rt];
    // 右下
    PPPoint *rb = [PPPoint pointWithX:width y:height type:@(PPOD_TT_PRIM_LINE)];
    [path.points addObject:rb];
    // 左下
    PPPoint *lb = [PPPoint pointWithX:minx y:height type:@(PPOD_TT_PRIM_LINE)];
    [path.points addObject:lb];
    // 闭合(左上)
    PPPoint *close = [PPPoint pointWithX:minx y:minY type:@(PPOD_TT_PRIM_CLOSE)];
    [path.points addObject:close];
    return path;
}

- (UIBezierPath *)bezierPathWithScale:(CGFloat)scale offset:(CGSize)offset
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.points.count; i ++) {
        // 取点
        PPPoint *pointM = self.points[i];
        CGPoint point = [pointM pointWithScale:scale offset:offset];  // 对应坐标点
        
        switch (pointM.type.integerValue) {
            case PPOD_TT_PRIM_MOVE:      // 移动到起始点
            {
                [path moveToPoint:point];
            }
                break;
            case PPOD_TT_PRIM_LINE:
            {
                [path addLineToPoint:point];
            }
                break;
            case PPOD_TT_PRIM_QSPLINE:   // 二次贝塞尔
            {
                // point 为控制点
                // 绘制点
                PPPoint *endPointM = self.points[i + 1];
                CGPoint endPoint = [endPointM pointWithScale:scale offset:offset];
                [path addQuadCurveToPoint:endPoint controlPoint:point];
                i++;
            }
                
                break;
            case PPOD_TT_PRIM_CSPLINE:   // 三次贝塞尔
            {
                // point 为控制点一
                // 控制点二
                PPPoint *controlPointM = self.points[i + 1];
                CGPoint controlPoint = [controlPointM pointWithScale:scale offset:offset];
                
                // 绘制点
                PPPoint *endPointM = self.points[i + 2];
                CGPoint endPoint = [endPointM pointWithScale:scale offset:offset];
                [path addCurveToPoint:endPoint controlPoint1:point controlPoint2:controlPoint];
                
                i += 2;
            }
                break;
            case PPOD_TT_PRIM_CLOSE:     //  闭合
                [path closePath];
                break;
            default:
                break;
        }
    }
    return path;
}

/**
 获取点集合缩放路径
 
 @param scale 缩放比例, x,y 方向
 @param offset 偏移量, x, y 方向
 @return 对应的路径
 */
- (UIBezierPath *)scalePath:(CGPoint)scale offset:(CGPoint)offset
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.points.count; i ++) {
        // 取点
        PPPoint *pointM = self.points[i];
        CGPoint point = [pointM scalePoint:scale offset:offset];  // 对应坐标点
        
        switch (pointM.type.integerValue) {
            case PPOD_TT_PRIM_MOVE:      // 移动到起始点
            {
                [path moveToPoint:point];
            }
                break;
            case PPOD_TT_PRIM_LINE:
            {
                [path addLineToPoint:point];
            }
                break;
            case PPOD_TT_PRIM_QSPLINE:   // 二次贝塞尔
            {
                // point 为控制点
                // 绘制点
                PPPoint *endPointM = self.points[i + 1];
                CGPoint endPoint = [endPointM scalePoint:scale offset:offset];
                [path addQuadCurveToPoint:endPoint controlPoint:point];
                i++;
            }
                
                break;
            case PPOD_TT_PRIM_CSPLINE:   // 三次贝塞尔
            {
                // point 为控制点一
                // 控制点二
                PPPoint *controlPointM = self.points[i + 1];
                CGPoint controlPoint = [controlPointM scalePoint:scale offset:offset];
                
                // 绘制点
                PPPoint *endPointM = self.points[i + 2];
                CGPoint endPoint = [endPointM scalePoint:scale offset:offset];
                [path addCurveToPoint:endPoint controlPoint1:point controlPoint2:controlPoint];
                
                i += 2;
            }
                break;
            case PPOD_TT_PRIM_CLOSE:     //  闭合
                [path closePath];
                break;
            default:
                break;
        }
    }
    return path;
}



#pragma mark =============== json ===============

@end
