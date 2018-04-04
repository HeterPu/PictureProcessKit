//
//  SJGCropImageView.m
//  CropTest
//
//  Created by SJG on 16/2/17.
//  Copyright © 2016年 SJG. All rights reserved.
//

#import "PPCropView.h"
#import <ImageIO/ImageIO.h>
#import "UIImage+PPK_Help.h"


#define kCuttedImageTag     101

#define kValidMessage       @"当前分辨率适合印刷"
#define kUnValidMessage     @"当前分辨率下印刷, 可能会模糊, 请调整"

#define kValidColor         [UIColor greenColor]
#define kUnValidColor       [UIColor redColor]

#define kVaidImage          [UIImage imageNamed:@"app_crop_image_icon_valid"]
#define kUnvalidImage       [UIImage imageNamed:@"app_crop_image_icon_unvalid"]


@interface PPCropView () <UIScrollViewDelegate>
@property (nonatomic, strong) PPCompoundPath *compoundPath; ///< 蒙版路径
@property (nonatomic, strong) XL_ZoomingScrollView    *imageScroll;  ///< 盛放imageView的容器
@property (nonatomic, strong) CALayer         *maskLayer;    ///< 背景蒙版层
@property (nonatomic, strong) CALayer         *cropLayer;    ///< 裁剪区域
@property (nonatomic, strong) UIImage         *sourceImage;  ///< 需要裁剪的图片
@property (nonatomic, assign) CGSize          cropSize;      ///< 裁剪大小(宽高)
@property (nonatomic, assign) CGFloat         scale;         ///< 蒙版层缩放倍数

@property (nonatomic, assign) CGSize          expectPixSize;
@property (nonatomic, strong) UIView          *infoView;
@property (nonatomic, strong) UILabel         *expectLabel;
@property (nonatomic, strong) UILabel         *currentLabel;
@property (nonatomic, strong) UIImageView     *alertIcon;
@property (nonatomic, strong) UILabel         *alertLabel;

@property(nonatomic,assign) PPCropType  cropType;

@end

@implementation PPCropView

#pragma mark - life cycle

// 初始化
- (instancetype)initCropViewWithFrame:(CGRect)frame
                         compoundPath:(PPCompoundPath *)path
                          sourceImage:(UIImage *)image
                             cropType:(PPCropType)cropType
{
    if (self = [super initWithFrame:frame]) {
        self.compoundPath = path;
        self.sourceImage = image;
        self.cropType = cropType;
        [self normalizedImage];
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

// 初始界面
- (void)setupUI
{
    // 添加要裁剪的图片
    UIImageView *cuttedImage = [[UIImageView alloc] init];
    cuttedImage.frame = CGRectMake(0, 0, self.imageScroll.frame.size.width,
                                   self.imageScroll.frame.size.height);
    self.imageScroll.cropSize = self.cropSize;
    self.imageScroll.isExtrendsZoom = self.cropType==PPCropTypeEdgeExtends;
    cuttedImage.image = self.sourceImage;
    cuttedImage.tag = kCuttedImageTag;
    cuttedImage.userInteractionEnabled = YES;
    cuttedImage.multipleTouchEnabled = YES;
    [self.imageScroll setShowImage:self.sourceImage];
    
    
    // 设置蒙版
    self.imageScroll.scrollEnabled = YES;
    self.maskLayer = [[CALayer alloc] init];
    self.maskLayer.frame = self.bounds;
    self.maskLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    [self.layer addSublayer:self.maskLayer];
    
    // 设置裁剪区域
    //裁减区域,大小根据计算得到
    self.cropLayer = [[CALayer alloc] init];
    self.cropLayer.masksToBounds = YES;
    self.cropLayer.bounds = CGRectMake(0, 0, self.cropSize.width, self.cropSize.height);
    self.cropLayer.position = self.layer.position;
    self.cropLayer.borderColor = [UIColor whiteColor].CGColor;
    self.cropLayer.borderWidth = 1;
    
    [self.layer addSublayer:self.cropLayer];
    
    // 逆时针描外边
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, 0)];
    [bezier addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [bezier closePath];
    bezier.usesEvenOddFillRule = YES;
    // 拼接需要路径
    [self appendBezierPath:bezier];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.path = bezier.CGPath;
    self.maskLayer.mask = maskLayer;
    
    [self setupButtonMenu];
    
    // 有透明通道, 背景调为白色
    /**
     kCGImageAlphaLast：                 alpha 分量存储在每个像素中的低位，如RGBA。
     kCGImageAlphaFirst：                alpha 分量存储在每个像素中的高位，如ARGB。
     kCGImageAlphaPremultipliedLast：    alpha 分量存储在每个像素中的低位，同时颜色分量已经乘以了 alpha 值。
     kCGImageAlphaPremultipliedFirst：   alpha 分量存储在每个像素中的高位，同时颜色分量已经乘以了 alpha 值。
     kCGImageAlphaNoneSkipLast：         没有 alpha 分量。如果像素的总大小大于颜色空间中颜色分量数目所需要的空间，则低位将被忽略。
     kCGImageAlphaNoneSkipFirst：        没有 alpha 分量。如果像素的总大小大于颜色空间中颜色分量数目所需要的空间，则高位将被忽略。
     kCGImageAlphaNone：                 等于kCGImageAlphaNoneSkipLast。
     
     PNG 是一种 RGBA 格式的图片, alpha 通道存在低位
     iPhone 拍照, 也带有 alpha 通道, 且存在高位
     */
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.sourceImage.CGImage);
    if (alpha == kCGImageAlphaNone ||
        alpha == kCGImageAlphaNoneSkipLast ||
        alpha == kCGImageAlphaNoneSkipFirst ||
        alpha == kCGImageAlphaPremultipliedFirst ||
        alpha == kCGImageAlphaFirst)
    {
        self.imageScroll.backgroundColor = [UIColor blackColor];
    } else {
        self.imageScroll.backgroundColor = [UIColor whiteColor];
    }
    
    [self configuration];
}



-(void)configuration{
    
}


- (void)dealloc
{
    [self.imageScroll removeFromSuperview];
    self.delegate = nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidZoom: %lf", scrollView.zoomScale);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark - actions

// 剪切响应
- (void)clipButtonClick:(UIButton *)sender
{
    return [self confirmClipImage];
}

// 确认裁剪
- (void)confirmClipImage
{
    UIImage *image = [self clipCropSizeImage];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cropView:clipImage:)]) {
        [self.delegate cropView:self clipImage:image];
    }
}

// 取消裁剪
- (void)cancelButtonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cropViewClipCancel:)]) {
        [self.delegate cropViewClipCancel:self];
    }
}



#pragma mark - private

/**
 初始化像素识别结果提示区
 */
- (void)setupInfoView
{
    if (CGSizeEqualToSize(self.expectPixSize, CGSizeZero)) return;
    if (self.infoView) return;
    
    // container view
    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 150, 80)];
    [self addSubview:self.infoView];
    self.infoView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    // current label
    self.currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 130, 20)];
    [self.infoView addSubview:self.currentLabel];
    self.currentLabel.textColor = [UIColor whiteColor];
    self.currentLabel.font = [UIFont systemFontOfSize:12];
    self.currentLabel.text = [NSString stringWithFormat:@"当前像素: %ld x %ld", (long)ceil(self.expectPixSize.width), (long)ceil(self.expectPixSize.height)];
    
    // expected label
    self.expectLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 130, 20)];
    [self.infoView addSubview:self.expectLabel];
    self.expectLabel.textColor = [UIColor whiteColor];
    self.expectLabel.font = [UIFont systemFontOfSize:12];
    self.expectLabel.text = [NSString stringWithFormat:@"建议像素: %ld x %ld", (long)ceil(self.expectPixSize.width), (long)ceil(self.expectPixSize.height)];
    
    // alert icon
    self.alertIcon = [[UIImageView alloc] initWithFrame:CGRectMake(4, 55, 12, 12)];
    [self.infoView addSubview:self.alertIcon];
    self.alertIcon.image = kVaidImage;
    
    // alert label
    self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, 120, 12)];
    [self.infoView addSubview:self.alertLabel];
    self.alertLabel.textColor = kValidColor;
    self.alertLabel.font = [UIFont systemFontOfSize:12];
    self.alertLabel.text = kValidMessage;
    self.alertLabel.numberOfLines = 0;
    self.alertLabel.baselineAdjustment = UIBaselineAdjustmentNone;
}


// 初始化底部裁剪, 取消按钮
- (void)setupButtonMenu
{
    CGRect rect = CGRectMake(0, XL_ScreenH - 50, XL_ScreenW, 50);
    UIView *bar = [[UIButton alloc] initWithFrame:rect];
    bar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:bar];
    
    
    // 添加确定裁剪按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(XL_ScreenW - 20 - 50, 10, 50, 30);
    [button setTitle:@"选择" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [bar addSubview:button];
    [button addTarget:self action:@selector(clipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加取消按钮
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame = CGRectMake(20, 10, 50, 30);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel setBackgroundColor:[UIColor whiteColor]];
    cancel.layer.cornerRadius = 5;
    cancel.layer.masksToBounds = YES;
    [bar addSubview:cancel];
    [cancel addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded@@@@@@@");
}

/**
 获取裁剪区域图片

 @return 裁剪区域内的图片
 */
- (UIImage *)clipCropSizeImage
{
    @autoreleasepool {
        UIImageView *imageView=(UIImageView *)[self.imageScroll getCropImageView];
        CGRect myImageRect = [imageView.layer convertRect:self.cropLayer.frame
                                                fromLayer:self.cropLayer.superlayer];
        CGFloat multipier;
        if (_cropType == PPCropTypeAspectFit) {
        CGFloat picRatio = self.sourceImage.size.width / self.sourceImage.size.height;
        CGFloat cropRatio = self.cropSize.width / self.cropSize.height;
        if (picRatio > cropRatio) {
            multipier = imageView.image.size.height / self.cropSize.height;
        }
        else
        {
            multipier  = imageView.image.size.width / self.cropSize.width;
        }
        myImageRect = CGRectMake(myImageRect.origin.x * multipier, myImageRect.origin.y * multipier, myImageRect.size.width * multipier, myImageRect.size.height * multipier);
        CGImageRef imageRef =self.sourceImage.CGImage;
        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
        UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
        CGImageRelease(subImageRef);
        return smallImage;
        }else{
            multipier = self.sourceImage.size.width /  imageView.xl__width;
            myImageRect = CGRectMake(multipier * myImageRect.origin.x, multipier * myImageRect.origin.y, multipier * myImageRect.size.width, multipier * myImageRect.size.height);
            NSLog(@"kakak");
             UIImage *image = [UIImage ppk_imageCropFromImage:self.sourceImage inRect:myImageRect];
            UIImage *imageBack = [UIImage ppk_imageWithColor:[UIColor clearColor] size:CGSizeMake(myImageRect.size.width, myImageRect.size.height)];
            CGPoint ratioR = CGPointZero;
            if (myImageRect.origin.x > 0) {
                ratioR.x = 0;
            }else{
                ratioR.x =  - myImageRect.origin.x /(myImageRect.size.width) ;
            }
            
            if (myImageRect.origin.y > 0) {
                ratioR.y = 0;
            }else{
                ratioR.y =  - myImageRect.origin.y / (myImageRect.size.height);
            }
            
            UIImage *comPoseImage = [UIImage ppk_imageAddImage:image toImage:imageBack positionXYRatio:ratioR];
            return comPoseImage;
        }
    }
}



/**
 拼接图片裁剪区域蒙版路径

 @param father 原路径
 */
- (void)appendBezierPath:(UIBezierPath *)father
{
    // 蒙版路径不存在
    if (!self.compoundPath) {
        return;
    }
    
    CGFloat scalew = XL_ScreenW / self.compoundPath.w.floatValue;
    CGFloat scaleh = XL_ScreenH / self.compoundPath.h.floatValue;
    
    CGFloat scale = scalew < scaleh ? scalew : scaleh;
    self.scale = scale;
    // 计算 xy 偏移, 确保蒙版处于视图中间
    CGFloat offx = 0.5 * (CGRectGetWidth(self.frame) - self.compoundPath.w.floatValue * self.scale);
    CGFloat offy = 0.5 * (CGRectGetHeight(self.frame) - self.compoundPath.h.floatValue * self.scale);
    [father appendPath:[self.compoundPath getBeizerPathWithScale:scale offset:CGSizeMake(offx, offy)]];
}

/**
 修正图片方向
 */
- (void)normalizedImage {
    if (self.sourceImage.imageOrientation != UIImageOrientationUp){
        UIGraphicsBeginImageContextWithOptions(self.sourceImage.size, NO, self.sourceImage.scale);
        [self.sourceImage drawInRect:(CGRect){0, 0, self.sourceImage.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.sourceImage=normalizedImage;
    }
}

#pragma mark - getter && setter
- (XL_ZoomingScrollView *)imageScroll
{
    if (!_imageScroll) {
        //图片载体
        _imageScroll=[[XL_ZoomingScrollView alloc] initWithFrame:CGRectMake(0,0, XL_ScreenW, XL_ScreenH)];
        [self addSubview:_imageScroll];
    }
    return _imageScroll;
}

- (CGSize)cropSize
{
    if (CGSizeEqualToSize(_cropSize, CGSizeZero))
    {
        CGFloat scalew = XL_ScreenW / self.compoundPath.w.floatValue;
        CGFloat scaleh = XL_ScreenH / self.compoundPath.h.floatValue;
        CGFloat scale = scalew < scaleh ? scalew : scaleh;
        self.scale = scale;
        _cropSize = CGSizeMake(self.compoundPath.w.floatValue * scale,
                               self.compoundPath.h.floatValue * scale);
    }
    return _cropSize;
}



@end
