
//
//  Created by Peter Hu on 2018/3/21.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "UIImage+PPK_Help.h"

#define K_ppk_image_default_size  CGSizeMake(100, 100)

@implementation UIImage (PPK_Help)

+ (UIImage *)ppk_updateImageOrientation:(UIImage *)chosenImage
{
    if (chosenImage) {
        // No-op if the orientation is already correct
        if (chosenImage.imageOrientation == UIImageOrientationUp){
            return chosenImage;
        }
        else{
            
            // We need to calculate the proper transformation to make the image upright.
            // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
            CGAffineTransform transform = CGAffineTransformIdentity;
            UIImageOrientation orientation=chosenImage.imageOrientation;
            int orientation_=orientation;
            switch (orientation_) {
                case UIImageOrientationDown:
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.width, chosenImage.size.height);
                    transform = CGAffineTransformRotate(transform, M_PI);
                    break;
                    
                case UIImageOrientationLeft:
                case UIImageOrientationLeftMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.width, 0);
                    transform = CGAffineTransformRotate(transform, M_PI_2);
                    break;
                    
                case UIImageOrientationRight:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, 0, chosenImage.size.height);
                    transform = CGAffineTransformRotate(transform, -M_PI_2);
                    break;
            }
            
            switch (orientation_) {
                case UIImageOrientationUpMirrored:{
                    
                }
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.width, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
                    
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, chosenImage.size.height, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
            }
            
            // Now we draw the underlying CGImage into a new context, applying the transform
            // calculated above.
            CGContextRef ctx = CGBitmapContextCreate(NULL, chosenImage.size.width, chosenImage.size.height,
                                                     CGImageGetBitsPerComponent(chosenImage.CGImage), 0,
                                                     CGImageGetColorSpace(chosenImage.CGImage),
                                                     CGImageGetBitmapInfo(chosenImage.CGImage));
            CGContextConcatCTM(ctx, transform);
            switch (chosenImage.imageOrientation) {
                case UIImageOrientationLeft:
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRight:
                case UIImageOrientationRightMirrored:
                    // Grr...
                    CGContextDrawImage(ctx, CGRectMake(0,0,chosenImage.size.height,chosenImage.size.width), chosenImage.CGImage);
                    break;
                    
                default:
                    CGContextDrawImage(ctx, CGRectMake(0,0,chosenImage.size.width,chosenImage.size.height), chosenImage.CGImage);
                    break;
            }
            // And now we just create a new UIImage from the drawing context
            CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
            UIImage *img = [UIImage imageWithCGImage:cgimg];
            CGContextRelease(ctx);
            CGImageRelease(cgimg);
            return img;
        }
    }
    return nil;
}

+ (UIImage*)ppk_shrinkImage:(UIImage*)original size:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale,
                                                 size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context,
                       CGRectMake(0, 0, size.width * scale, size.height * scale),
                       original.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return final;
}



//指定宽度按比例缩放
+(UIImage *)ppk_image:(UIImage *)sourceImage targetScale:(CGFloat)scale{
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = width * scale;
    
    CGFloat targetHeight = height / (width / targetWidth);
    
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    
    
    if(CGSizeEqualToSize(imageSize, size) ==NO){
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        
        
        if(widthFactor > heightFactor){
            
            scaleFactor = widthFactor;
            
        }else{
            
            scaleFactor = heightFactor;
            
        }
        
        scaledWidth = width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
            
        }
        
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
        
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}



#pragma mark - 创建mainBundle目录下不带缓存的图片
+ (UIImage *)ppk_imageNoCache:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], name]];
}

#pragma mark - 可拉伸的图片
+ (UIImage *)ppk_stretchableImage:(UIImage *)img edgeInsets:(UIEdgeInsets)edgeInsets{
    edgeInsets.top < 1 ? edgeInsets.top = 12 : 0;
    edgeInsets.left  < 1 ? edgeInsets.left = 12 : 0;
    edgeInsets.bottom < 1 ? edgeInsets.bottom = 12 : 0;
    edgeInsets.right  < 1 ? edgeInsets.right = 12 : 0;
#if defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
    return [img resizableImageWithCapInsets:edgeInsets];
#else
    return [img stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];
#endif
}

+ (UIImage *)ppk_imageFromBundle:(NSString *)bundleName path:(NSString *)path imageName:(NSString *)imageName
{
    NSMutableString *fullName = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]];
    if (path && path.length > 0)
    {
        [fullName appendString:@"/"];
        [fullName appendString:path];
    }
    if (imageName && imageName.length > 0)
    {
        [fullName appendString:@"/"];
        [fullName appendString:imageName];
    }
    NSLog(@"xxxxxx %@",fullName);
    return [UIImage imageWithContentsOfFile:fullName];
}

#pragma mark - UIColor转UIImage
+ (UIImage*)ppk_imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, K_ppk_image_default_size.width, K_ppk_image_default_size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)ppk_imageCropFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}


+(UIImage *)ppk_imageCropFromImage:(UIImage *)image inRatioRect:(CGRect)rect{
    CGFloat  originX = rect.origin.x * image.size.width;
    CGFloat  originY = rect.origin.y * image.size.height;
    CGFloat  width = rect.size.width * image.size.width;
    CGFloat  height = rect.size.height * image.size.height;
    CGFloat scale = image.scale;
    return [UIImage ppk_imageCropFromImage:image inRect:CGRectMake(originX * scale, originY * scale, width * scale, height *scale)];
}


#pragma mark - UIColor转UIImage
+ (UIImage*)ppk_imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)ppk_imageWithView:(UIView *)view rect:(CGRect)rect
{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    if (rect.origin.x != 0 && rect.origin.x != 0) {
//        CGImageRef imageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
//        img = [UIImage imageWithCGImage:imageRef];
//    }
    
    return img;
}

+ (UIImage *)ppk_imageWithWindowRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    NSLog(@"%@", NSStringFromCGSize(window.bounds.size));
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, imageView.opaque, 0.0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}




#pragma mark - 将图片大小转换成新尺寸

+ (CGSize)ppk_scaleImage:(UIImage *)image sideMax:(float)sideMax
{
    if (!image)
        return CGSizeZero;
    CGSize size ;
    if (image.size.height > image.size.width)
    {
        size.height = sideMax;
        size.width = image.size.width/image.size.height*sideMax;
    }
    else
    {
        size.width = sideMax;
        size.height = image.size.height/image.size.width*sideMax;
    }
    return size;
}

// Add text to UIImage
+ (UIImage*) ppk_drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    UIFont *font = [UIFont boldSystemFontOfSize:56];
    if([text respondsToSelector:@selector(drawInRect:withAttributes:)])
    {
        //iOS 7
        NSDictionary *att = @{NSFontAttributeName:font, NSForegroundColorAttributeName: [UIColor whiteColor]};
        
        [text drawInRect:rect withAttributes:att];
    }
    else
    {
        NSDictionary *att = @{ NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor whiteColor]};
        //legacy support
        [text drawInRect:CGRectIntegral(rect) withAttributes:att];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
    
    
    
+(UIImage *)ppk_imageAddImage:(UIImage *)addImage toImage:(UIImage *)backImage position:(PPK_Image_Position)position{
    switch (position) {
        case PPK_Image_PositionLeftTop:
        {
            return [UIImage ppk_imageAddImage:addImage toImage:backImage positionXYRatio:CGPointZero];
        }
        break;
        case PPK_Image_PositionLeftBottom:
        {
            CGFloat heightR = (backImage.size.height - addImage.size.height) / backImage.size.height;
             if(heightR < 0)heightR = 0;
             return [UIImage ppk_imageAddImage:addImage toImage:backImage positionXYRatio:CGPointMake(0, heightR)];
        }
        break;
        case PPK_Image_PositionRightTop:
        {
            CGFloat widthR = (backImage.size.width - addImage.size.width) / backImage.size.width;
            if(widthR < 0)widthR = 0;
             return [UIImage ppk_imageAddImage:addImage toImage:backImage positionXYRatio:CGPointMake(widthR, 0)];
        }
        break;
        case PPK_Image_PositionRightBottom:
        {
            
            CGFloat widthR = (backImage.size.width - addImage.size.width) / backImage.size.width;
            CGFloat heightR = (backImage.size.height - addImage.size.height) / backImage.size.height;
            if(heightR < 0)heightR = 0;
            if(widthR < 0)widthR = 0;
            return [UIImage ppk_imageAddImage:addImage toImage:backImage positionXYRatio:CGPointMake(widthR, heightR)];
        }
        break;
        case PPK_Image_PositionCenter:
        {
            CGFloat widthR = (backImage.size.width - addImage.size.width) / 2 / backImage.size.width;
            CGFloat heightR = (backImage.size.height - addImage.size.height) / 2 /backImage.size.height;
            if(heightR < 0)heightR = 0;
            if(widthR < 0)widthR = 0;
             return [UIImage ppk_imageAddImage:addImage toImage:backImage positionXYRatio:CGPointMake(widthR, heightR)];
        }
        break;
        default:
        return nil;
        break;
    }
}
    
    
+(UIImage *)ppk_imageAddImage:(UIImage *)addImage toImage:(UIImage *)backImage positionXYRatio:(CGPoint)ratio
{
        
        CGFloat width = backImage.size.width;
        CGFloat height = backImage.size.height;
    
        // 如果不除以scale则生成的图片会大scale倍
        CGFloat scale = [UIScreen mainScreen].scale;
        width = width / scale;
        height = height / scale;
    
        if((ratio.x < 0)||(ratio.x > 1.0)) width = 0;
        if((ratio.y < 0)||(ratio.y > 1.0)) height = 0;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height) ,NO, 0.0);
        [backImage drawInRect:CGRectMake(0, 0, width, height)];
    
        //四个参数为水印图片的位置
        [addImage drawInRect:CGRectMake(ratio.x * width, ratio.y * height, addImage.size.width / scale, addImage.size.height / scale)];
        //如果要多个位置显示，继续drawInRect就行
//        [backImage drawInRect:CGRectMake(0, addImage.size.height/2, addImage.size.width, addImage.size.height/2)];
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultingImage;
    }

@end
