//
//  XLZoomingScrollView.h
//  XLPhotoBrowserDemo
//
//  Created by Liushannoon on 16/7/15.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XL_Extension.h"

@class XL_ZoomingScrollView;

@protocol XL_ZoomingScrollViewDelegate <NSObject>

/**
 *  单击图像时调用
 *
 *  @param zoomingScrollView 图片缩放视图
 *  @param touch             用户单击的UITouch对象
 */
- (void)zoomingScrollView:(XL_ZoomingScrollView *)zoomingScrollView singleTapDetected:(UITapGestureRecognizer *)singleTap;
/**
 *  图片加载进度
 *
 *  @param zoomingScrollView 图片缩放视图
 *  @param progress 加载进度 , 0 - 1.0
 */
- (void)zoomingScrollView:(XL_ZoomingScrollView *)zoomingScrollView imageLoadProgress:(CGFloat)progress;

@end


@interface XL_ZoomingScrollView : UIScrollView

/**
 *  zoomingScrollViewdelegate , 要和UIScrollView的delegate区分开
 */
@property (nonatomic , weak) id <XL_ZoomingScrollViewDelegate> zoomingScrollViewdelegate;
/**
 *  图片加载进度
 */
@property (nonatomic, assign) CGFloat progress;
/**
 *  是否已经加载过图片
 */
@property (nonatomic, assign) BOOL hasLoadedImage;
/**
 *  展示的图片
 */

@property(nonatomic,assign) BOOL isExtrendsZoom;

@property (nonatomic,assign) CGSize cropSize;

@property (nonatomic , strong , readonly) UIImage  *currentImage;
/**
 *  展示图片的UIImageView视图  ,  回缩的动画用
 */
@property (nonatomic , weak , readonly) UIImageView *imageView;


@property (nonatomic, copy) void(^didZooming)(UIScrollView *scroll);
@property (nonatomic, copy) void(^didEndDecelerating)(UIScrollView *scroll);
@property (nonatomic, copy) void(^didEndZooming)(UIScrollView *scroll);
@property (nonatomic, copy) void(^didEndScrollingAnimation)(UIScrollView *scroll);
@property (nonatomic, copy) void(^didEndDragging)(UIScrollView *scroll, BOOL willDecelerate);

/**
 *  显示图片
 *
 *  @param url         图片的高清大图链接
 *  @param placeholder 占位的缩略图 / 或者是高清大图都可以
 */
- (void)setShowHighQualityImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
/**
 *  显示图片
 *
 *  @param image 图片
 */
- (void)setShowImage:(UIImage *)image;
/**
 *  调整尺寸
 */
- (void)setMaxAndMinZoomScales;
/**
 *  重用，清理资源
 */
- (void)prepareForReuse;



/**
 获取待裁剪的imageview
 @return imageview
 */
-(UIImageView *)getCropImageView;


/**
 放大到固定比例

 @param scale 比例因子
 @param center 中心
 @return
 */
- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center;


/**

 @param scale 放大倍数
 @param center 中心比例,范围为 0 - 1
 @param isAnimated 是否带动画
 */
-(void)zoomToScale:(CGFloat)scale withCenterRatio:(CGPoint)center animated:(BOOL)isAnimated;

@end
