//
//  XLZoomingScrollView.m
//  XLPhotoBrowserDemo
//
//  Created by Liushannoon on 16/7/15.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "XL_ZoomingScrollView.h"
//#import "XLProgressView.h"

@interface XL_ZoomingScrollView () <UIScrollViewDelegate>

@property (nonatomic , strong) UIImageView  *photoImageSubView;
@property (nonatomic , strong) UIImageView  *photoImageView;
//@property (nonatomic , strong) XLProgressView *progressView;
@property(nonatomic, strong) UILabel *stateLabel;


@property(nonatomic,assign) CGFloat  imageX_W_Ratio;

@end

@implementation XL_ZoomingScrollView

#pragma mark    -   set / get

- (void)setProgress:(CGFloat)progress
{
//    _progress = progress;
//    self.progressView.progress = progress;
//    if ([self.zoomingScrollViewdelegate respondsToSelector:@selector(zoomingScrollView:imageLoadProgress:)]) {
//        [self.zoomingScrollViewdelegate zoomingScrollView:self imageLoadProgress:progress];
//    }
}

- (UIImageView *)imageView
{
    return self.photoImageView;
}

- (UIImage *)currentImage
{
    return self.photoImageView.image;
}

- (UIImageView *)photoImageView
{
    if (_photoImageView == nil) {
        _photoImageView = [[UIImageView alloc] init];
    }
    
    return _photoImageView;
}


- (UIImageView *)photoImageSubView
{
    if (_photoImageSubView == nil) {
        _photoImageSubView = [[UIImageView alloc] init];
        [self.photoImageView addSubview:_photoImageSubView];
    }
    return _photoImageSubView;
}


- (UILabel *)stateLabel
{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
//        _stateLabel.text = XLPhotoBrowserLoadNetworkImageFail;
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _stateLabel.layer.cornerRadius = 5;
        _stateLabel.clipsToBounds = YES;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

//- (XLProgressView *)progressView
//{
//    if (_progressView == nil) {
//        _progressView = [[XLProgressView alloc] init];
//    }
//    return _progressView;
//}

#pragma mark    -   initial UI

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initial];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initial
{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.delegate = self;
    self.backgroundColor = [UIColor blackColor];
    self.photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.photoImageView];

//    UITapGestureRecognizer *singleTapBackgroundView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapBackgroundView:)];
//    UITapGestureRecognizer *doubleTapBackgroundView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapBackgroundView:)];
//    doubleTapBackgroundView.numberOfTapsRequired = 2;
//    [singleTapBackgroundView requireGestureRecognizerToFail:doubleTapBackgroundView];
//    [self addGestureRecognizer:singleTapBackgroundView];
//    [self addGestureRecognizer:doubleTapBackgroundView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.photoImageView.frame;
    if (self.photoImageView.xl__width > self.photoImageView.xl__height) {
        NSLog(@"xxxx %f",self.contentInset.top);
//        if (frameToCenter.size.height < boundsSize.height) { // 长图才会出现这种情况
//            frameToCenter.origin.y = floor((boundsSize.height - frameToCenter.size.height) / 2.0);
//        } else {
//            frameToCenter.origin.y = 0;
//        }
//        
//        if (frameToCenter.size.width < boundsSize.width) {
//            frameToCenter.origin.x = floor((boundsSize.height - frameToCenter.size.height) / 2.0);
//        } else {
//            frameToCenter.origin.x = 0;
//        }
//
    }
    else
    {
    
//    if (frameToCenter.size.width < boundsSize.width) { // 长图才会出现这种情况
//        frameToCenter.origin.x = floor((boundsSize.width - frameToCenter.size.width) / 2.0);
//    } else {
//        frameToCenter.origin.x = 0;
//    }
//    
//    if (frameToCenter.size.height < boundsSize.height) {
////        frameToCenter.origin.y = floor((boundsSize.height - frameToCenter.size.height) / 2.0);
//        frameToCenter.origin.y = 0;
//    } else {
//        frameToCenter.origin.y = 0;
//    }
    
        
    }
    // Center
    if (!CGRectEqualToRect(self.photoImageView.frame, frameToCenter)){
        self.photoImageView.frame = frameToCenter;
    }
    
//    self.stateLabel.bounds = CGRectMake(0, 0, 160, 30);
//    self.stateLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
//    self.progressView.bounds = CGRectMake(0, 0, 100, 100);
//    self.progressView.xl_centerX = self.xl_width * 0.5;
//    self.progressView.xl_centerY = self.xl_height * 0.5;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"the y of scroll %f",scrollView.contentOffset.y,);
}


#pragma mark    -   UIScrollViewDelegate
    
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    if (self.didZooming) self.didZooming(scrollView);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.didEndDragging) self.didEndDragging(scrollView, decelerate);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.didEndDecelerating) self.didEndDecelerating(scrollView);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.didEndScrollingAnimation) self.didEndScrollingAnimation(scrollView);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.photoImageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    self.scrollEnabled = YES;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.userInteractionEnabled = YES;
    if (_isExtrendsZoom) {
        [self reloadContentInsetWith:scale];
    }
    NSLog(@"%f %f",self.imageView.frame.size.width,self.imageView.frame.origin.x);
    if (self.didEndZooming) self.didEndZooming(scrollView);
}

#pragma mark    -   private method - 手势处理,缩放图片

- (void)singleTap:(UITapGestureRecognizer *)singleTap
{
    if (self.zoomingScrollViewdelegate && [self.zoomingScrollViewdelegate respondsToSelector:@selector(zoomingScrollView:singleTapDetected:)]) {
        [self.zoomingScrollViewdelegate zoomingScrollView:self singleTapDetected:singleTap];
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)doubleTap
{
    [self handleDoubleTap:[doubleTap locationInView:doubleTap.view]];
}

- (void)handleDoubleTap:(CGPoint)point
{
    self.userInteractionEnabled = NO;
    CGRect zoomRect = [self zoomRectForScale:[self willBecomeZoomScale] withCenter:point];
    [self zoomToRect:zoomRect animated:YES];
}

/**
 *  计算要伸缩到的目的比例
 */
- (CGFloat)willBecomeZoomScale
{
    if (self.zoomScale > self.minimumZoomScale) {
        return self.minimumZoomScale;
    } else {
        return self.maximumZoomScale;
    }
}


-(void)zoomToScale:(CGFloat)scale withCenterRatio:(CGPoint)center animated:(BOOL)isAnimated {
    
    // 延时0.5秒以执行动画
    __weak typeof(self)weakSelf = self;
    CGFloat duration = 0.0;
    if (isAnimated) {
        duration = 0.5;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf setZoomScale:scale animated:isAnimated];
        [weakSelf setContentOffsetFromPoint:center  animated:isAnimated];
    });
}


-(void)setContentOffsetFromPoint:(CGPoint)ratio animated:(BOOL)isAnimated{
    
    CGFloat offsetAdd_Y = (XL_ScreenH - self.cropSize.height) / 2 ;
    CGFloat offsetAdd_X = (XL_ScreenW - self.cropSize.width) / 2 ;
    CGFloat offsetX = (_photoImageView.frame.size.width * ratio.x)- self.cropSize.width / 2;
    CGFloat offsetY = (_photoImageView.frame.size.height * ratio.y)- self.cropSize.height / 2;
    
    [self setContentOffset:CGPointMake(-offsetAdd_X + offsetX,  -offsetAdd_Y + offsetY) animated:isAnimated];
}


- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center
{
    CGFloat height = self.frame.size.height / scale;
    CGFloat width  = self.frame.size.width  / scale;
    CGFloat x = center.x - width * 0.5;
    CGFloat y = center.y - height * 0.5;
    return CGRectMake(x, y, width, height);
}

- (void)singleTapBackgroundView:(UITapGestureRecognizer *)singleTap
{
    if (self.zoomingScrollViewdelegate && [self.zoomingScrollViewdelegate respondsToSelector:@selector(zoomingScrollView:singleTapDetected:)]) {
        [self.zoomingScrollViewdelegate zoomingScrollView:self singleTapDetected:singleTap];
    }
}

- (void)doubleTapBackgroundView:(UITapGestureRecognizer *)doubleTap
{
#warning TODO 需要再优化这里的算法

    self.userInteractionEnabled = NO;
    CGPoint point = [doubleTap locationInView:doubleTap.view];
    CGFloat touchX = point.x;
    CGFloat touchY = point.y;
    touchX *= 1/self.zoomScale;
    touchY *= 1/self.zoomScale;
    touchX += self.contentOffset.x;
    touchY += self.contentOffset.y;
    [self handleDoubleTap:CGPointMake(touchX, touchY)];
}

- (void)resetZoomScale
{
    self.maximumZoomScale = 1.0;
    self.minimumZoomScale = 1.0;
}

#pragma mark    -   public method

/**
 *  显示图片
 *
 *  @param image 图片
 */
- (void)setShowImage:(UIImage *)image
{
    if (_isExtrendsZoom) {
         self.photoImageSubView.image = image;
    }else{
      self.photoImageView.image = image;
    }
    [self setMaxAndMinZoomScales];
    self.photoImageView.tag = 101;
}


-(UIImageView *)getCropImageView{
    if (_isExtrendsZoom) {
       return  self.photoImageSubView;
    }else{
       return  self.photoImageView;
    }
}

/**
 *  显示图片
 *
 *  @param url         图片的高清大图链接
 *  @param placeholder 占位的缩略图 / 或者是高清大图都可以
 */
- (void)setShowHighQualityImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
//{
//    if (!url) {
//        [self setShowImage:placeholder];
//        self.progress = 1.0f;
//        return;
//    }
//
//    UIImage *showImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[url absoluteString]];
//    if (showImage) {
////        XLFormatLog(@"已经下载过图片,直接从缓存中获取");
//        self.photoImageView.image = showImage;
//        [self setMaxAndMinZoomScales];
//        self.progress = 1.0f;
//        return;
//    }
//
//    self.photoImageView.image = placeholder;
//    [self setMaxAndMinZoomScales];
//
//    __weak typeof(self) weakSelf = self;
//    //初始化进度条
//    self.progress = 0.01;
////    [self addSubview:self.progressView];;
////    self.progressView.mode = XLProgressViewProgressMode;
//
//    [weakSelf.photoImageView sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed| SDWebImageLowPriority| SDWebImageHandleCookies  progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        if (expectedSize>0) {
//            // 修改进度
//            weakSelf.progress = (CGFloat)receivedSize / expectedSize ;
//        }
//        [self resetZoomScale];
//    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error) {
//            [self setMaxAndMinZoomScales];
//            [weakSelf addSubview:weakSelf.stateLabel];
//            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //                [weakSelf.stateLabel removeFromSuperview];
//            //            });
//            //            XLFormatLog(@"加载图片失败 , 图片链接imageURL = %@ , 检查是否开启允许HTTP请求",imageURL);
//        } else {
//            [weakSelf.stateLabel removeFromSuperview];
//            weakSelf.photoImageView.image = image;
//            [weakSelf.photoImageView setNeedsDisplay];
//            [UIView animateWithDuration:0.25 animations:^{
//                [weakSelf setMaxAndMinZoomScales];
//            }];
//        }
//
//    }];
}

/**
 *  根据图片和屏幕比例关系,调整最大和最小伸缩比例
 */
- (void)setMaxAndMinZoomScales
{
    if(!_isExtrendsZoom){
    // 正常边界裁切的逻辑
        
    // self.photoImageView的初始位置
    UIImage *image = self.photoImageView.image;
    if (image == nil || image.size.height==0) {
        return;
    }
    CGFloat imageWidthHeightRatio = image.size.width / image.size.height;
    
    CGFloat cropRatio = (XL_ScreenW - 2 * self.contentInset.left)/(XL_ScreenH - 2 * self.contentInset.top);
    
    if (imageWidthHeightRatio > cropRatio) {
        self.photoImageView.xl__height = XL_ScreenH - 2 * self.contentInset.top;
        self.photoImageView.xl__width =(XL_ScreenH - 2 * self.contentInset.top)* imageWidthHeightRatio;
        NSLog(@"the width is %f, height is %f",self.photoImageView.xl__width,self.photoImageView.xl__height);
        self.contentOffset = CGPointMake((self.photoImageView.xl__width - XL_ScreenW) / 2, 0);
    }
    else
    {
        @try{
        self.photoImageView.xl__width = XL_ScreenW - 2 * self.contentInset.left ;
        self.photoImageView.xl__height = (XL_ScreenW - 2 * self.contentInset.left) / imageWidthHeightRatio;
        self.photoImageView.xl__x = 0;
        if (self.photoImageView.xl__height > XL_ScreenH) {
            self.photoImageView.xl__y = 0;
            self.scrollEnabled = YES;
            self.contentOffset = CGPointMake(0, 0);
        } else {
            self.photoImageView.xl__y = 0;
            CGFloat fl = self.contentInset.top - (XL_ScreenH - self.photoImageView.xl__height) / 2;
            self.contentOffset = CGPointMake(0, - self.contentInset.top + fl);
        }
        }
        @catch(NSException *e){
            
        }
    }
    
       self.maximumZoomScale = MAX(XL_ScreenH / self.photoImageView.xl__height, 6.0);
    self.minimumZoomScale = 1.0;
    self.zoomScale = 1.0;
    
    if (image.size.width > image.size.height) {
       self.contentSize = CGSizeMake(MAX(self.photoImageView.xl__width, XL_ScreenW),self.photoImageView.xl__height);
    }
    else
    {
       self.contentSize = CGSizeMake(self.photoImageView.xl__width, MAX(self.photoImageView.xl__height, self.photoImageView.xl__height));
    }
}else{
    

    CGFloat topPadding = (XL_ScreenH -  self.cropSize.height) / 2;
    CGFloat leftPadding = (XL_ScreenW -  self.cropSize.width) / 2;
    
    // self.photoImageView的初始位置
    UIImage *image = self.photoImageSubView.image;
    if (image == nil || image.size.height==0) {
        return;
    }
    CGFloat imageWidthHeightRatio = image.size.width / image.size.height;
    
    CGFloat cropRatio = (XL_ScreenW - 2 * leftPadding)/(XL_ScreenH - 2 * topPadding);
    self.photoImageView.frame = CGRectMake(0,0,(XL_ScreenW - 2 * leftPadding), (XL_ScreenH - 2 * self.contentInset.top));
    
    if (imageWidthHeightRatio > cropRatio) {
        self.photoImageSubView.xl__height = (XL_ScreenW - 2 * leftPadding) / imageWidthHeightRatio;
        self.photoImageSubView.xl__width =(XL_ScreenW - 2 * leftPadding);
        NSLog(@"the width is %f, height is %f",self.photoImageView.xl__width,self.photoImageView.xl__height);
        self.photoImageSubView.xl__y = (self.cropSize.height - self.photoImageSubView.xl__height) / 2 ;
        
        self.photoImageView.xl__y = 0;
        UIEdgeInsets inset =  self.contentInset;
        inset.top = topPadding + self.cropSize.height -  self.photoImageSubView.xl__y;
        inset.bottom = inset.top;
        self.contentInset = inset;
        self.contentOffset = CGPointMake(self.photoImageView.xl__x , -topPadding);
    }
    else
    {
        @try{
            self.photoImageSubView.xl__width = (XL_ScreenH - 2 * topPadding) * imageWidthHeightRatio;
            self.photoImageSubView.xl__height = (XL_ScreenH - 2 * topPadding);
            self.photoImageSubView.xl__x = (XL_ScreenW - self.photoImageSubView.xl__width) / 2;

             self.photoImageView.xl__y = 0;
            
            UIEdgeInsets inset =  self.contentInset;
            inset.left = self.cropSize.width -  self.photoImageSubView.xl__x;
            inset.right = inset.left;
            self.contentInset = inset;
            self.contentOffset = CGPointMake(self.photoImageView.xl__x , - (XL_ScreenH - self.cropSize.height) / 2 );
        }
        @catch(NSException *e){
            
        }
    }
    
    self.maximumZoomScale = MAX(XL_ScreenH / self.photoImageView.xl__height, 6.0);
    self.minimumZoomScale = 1.0;
    self.zoomScale = 1.0;
    
    
    if (image.size.width > image.size.height) {
        self.contentSize = CGSizeMake(MAX(self.photoImageView.xl__width, XL_ScreenW),self.photoImageView.xl__height);
    }
    else
    {
        self.contentSize = CGSizeMake(self.photoImageView.xl__width, MAX(self.photoImageView.xl__height, self.photoImageView.xl__height));
    }
        
    }
}




-(void)reloadContentInsetWith:(CGFloat)scale{
    CGFloat topPadding = (XL_ScreenH -  self.cropSize.height) / 2;
    UIEdgeInsets inset =  self.contentInset;
    inset.left = self.cropSize.width -  self.photoImageSubView.xl__x * scale;
    inset.right = inset.left;
    inset.top = topPadding + self.cropSize.height -  self.photoImageSubView.xl__y *scale;
    inset.bottom = inset.top;
    self.contentInset = inset;
}


-(void)setIsExtrendsZoom:(BOOL)isExtrendsZoom{
    _isExtrendsZoom = isExtrendsZoom;
    if (!isExtrendsZoom) {
        CGFloat verticalPadding = (XL_ScreenH - self.cropSize.height) / 2;
        CGFloat horizonPadding = (XL_ScreenW - self.cropSize.width) / 2;
        self.contentInset = UIEdgeInsetsMake(verticalPadding, horizonPadding, verticalPadding, horizonPadding);
    }
    else{
        CGFloat verticalPadding = (XL_ScreenH - self.cropSize.height) / 2 + self.cropSize.height;
        CGFloat horizonPadding = (XL_ScreenW - self.cropSize.width) / 2 + self.cropSize.width;
        self.contentInset = UIEdgeInsetsMake(verticalPadding, horizonPadding, verticalPadding, horizonPadding);
    }
}

/**
 *  重用，清理资源
 */
- (void)prepareForReuse
{
    [self setMaxAndMinZoomScales];
    self.progress = 0;
    self.photoImageView.image = nil;
    self.hasLoadedImage = NO;
    [self.stateLabel removeFromSuperview];
//    [self.progressView removeFromSuperview];
}

@end
