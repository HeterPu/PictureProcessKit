//
//  SJGCropImageView.h
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPCompoundPath.h"
#import "XL_ZoomingScrollView.h"


typedef NS_ENUM(NSInteger,PPCropType) {
    PPCropTypeAspectFit = 0,
    PPCropTypeEdgeExtends,
};


@protocol PPCropViewDelegate;
@interface PPCropView : UIView

@property (nonatomic, assign) id<PPCropViewDelegate> delegate;

/// 根据 frame, compoundPath , image 初始化
- (instancetype)initCropViewWithFrame:(CGRect)frame
                         compoundPath:(PPCompoundPath *)path
                          sourceImage:(UIImage *)image cropType:(PPCropType)cropType;

@end


@protocol PPCropViewDelegate <NSObject>
@optional
/// 点击裁剪按钮, 确定裁剪图片
- (void)cropView:(PPCropView *)view clipImage:(UIImage *)clipImage;

/// 点击取消, 取消裁剪图片
- (void)cropViewClipCancel:(PPCropView *)view;


#pragma mark - FOR PRIVATE

/**
 其它视图的配置
 */
-(void)configuration;


@end
