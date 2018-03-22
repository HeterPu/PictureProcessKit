//
//  Created by Peter Hu on 2018/3/21.
//  Copyright © 2018年 PeterHu. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PPK_Image_Position) {
    PPK_Image_PositionLeftTop = 0,
    PPK_Image_PositionLeftBottom,
    PPK_Image_PositionRightTop,
    PPK_Image_PositionRightBottom,
    PPK_Image_PositionCenter,
};


@interface UIImage (PPK_Help)

/**
 更新图片位置
 @param chosenImage 选择的图片
 @return 返回新的图片
 */
+ (UIImage *)updateImageOrientation:(UIImage *)chosenImage;
    
    
/**
 按照比例缩小图片
 @param original 原始图片
 @param size 尺寸
 @return 返回新图片
 */
+ (UIImage*)shrinkImage:(UIImage*)original size:(CGSize)size;


/**
 创建mainBundle目录下不带缓存的图片
 @param name 图片名字
 @return 返回新图片
 */
+ (UIImage *)imageNoCache:(NSString *)name;
    
    
/**
 拉伸图片，扩充图片
 @param img 原始图片
 @param edgeInsets 边界距离
 @return 返回图片
 */
+ (UIImage *)stretchableImage:(UIImage *)img edgeInsets:(UIEdgeInsets)edgeInsets;
    

/**
 按照bundle名称来获取图片

 @param bundleName bundle
 @param path path
 @param imageName 图片名称
 @return 返回图片
 */
+ (UIImage *)imageFromBundle:(NSString *)bundleName path:(NSString *)path imageName:(NSString *)imageName;
    

/**
 根据颜色生成图片
 @param color 颜色值
 @return 返回图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color;
    

/**
根据颜色，尺寸生成图片
 @param color 颜色值
 @param size 尺寸
 @return 返回图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;
    
    
/**
 根据view来生成图片
 @param view 要生成图片的view
 @param rect view的尺寸
 @return 返回图片
 */
+ (UIImage *)imageWithView:(UIView *)view rect:(CGRect)rect;
    

/**
 按照window来生成图片
 @param rect 裁剪的尺寸
 @return 返回图片
 */
+ (UIImage *)imageWithWindowRect:(CGRect)rect;
    

/**
 缩放图片
 @param image 原始图片
 @param newSize 新的尺寸
 @return 返回图片
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
    

/**
缩放图片
@param image 原始图片
@param newSize 新的尺寸
@return 返回图片
*/
+ (UIImage *)imageWithImageCenterSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
缩放图片
@param image 原始图片
@param newSize 新的尺寸
@return 返回图片
*/
+ (UIImage *) croppedImageCenterSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
    

/**
缩放图片
@param image 原始图片
@param sideMax 新的尺寸
@return 返回图片
*/
+ (CGSize)scaleImage:(UIImage *)image sideMax:(float)sideMax;


/**
 在某点绘制文字
 @param text 文字
 @param image 图片
 @param point 绘制的点
 @return 返回图片
 */
+ (UIImage*) drawText:(NSString*)text inImage:(UIImage*)image atPoint:(CGPoint)point;


/**
 图片合成
 @param addImage 要添加的图片
 @param backImage 背景图片
 @param position 位置
 @return 返回的图片
 */
+(UIImage *)ppk_imageAddImage:(UIImage *)addImage toImage:(UIImage *)backImage position:(PPK_Image_Position)position;
    

/**
图片合成
 @param addImage 要添加的图片
 @param backImage 背景图片
 @param ratio 左上角的坐标比例
 @return 返回的图片
 */
+(UIImage *)ppk_imageAddImage:(UIImage *)addImage toImage:(UIImage *)backImage positionXYRatio:(CGPoint)ratio;
@end
