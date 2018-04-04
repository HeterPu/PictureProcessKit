//
//  SJGPoint.h
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PPPointType) {
    PPOD_TT_PRIM_NONE        = 0,
    PPOD_TT_PRIM_LINE        = 1,		// line to
    PPOD_TT_PRIM_QSPLINE     = 2,		// qudratic bezier to
    PPOD_TT_PRIM_CSPLINE     = 3,		// cubic bezier to
    PPOD_TT_PRIM_MOVE        = 8,		// move to
    PPOD_TT_PRIM_CLOSE       = 9,        // close path, equal to fisrt point of path
};

@interface PPPoint : NSObject

@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *type;

// 获取缩放偏移后的点
- (CGPoint)pointWithScale:(CGFloat)scale offset:(CGSize)offset;


/**
 获取缩放后的点(可不等比)

 @param scale 缩放比例, x, y 方向
 @param offset 偏移量 x, y 方向
 @return  缩放后的点
 */
- (CGPoint)scalePoint:(CGPoint)scale offset:(CGPoint)offset;



/**
 快速初始化一个点

 @param x  x 坐标
 @param y  y 坐标
 @param type 点类型
 @return 对应的坐标点
 */
+ (instancetype)pointWithX:(NSNumber *)x y:(NSNumber *)y type:(NSNumber *)type;

@end
