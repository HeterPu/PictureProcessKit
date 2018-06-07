//
//  CIColorMatrix_helper.h
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/6/7.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface CIColorMatrix_helper : NSObject



/**
 反转颜色
 @param inputImage 输入image
 @return 返回image
 */
+(CIImage *)revertImage:(CIImage *)inputImage;



/**
 添加颜色滤镜
 @param inputImage 输入图片
 @param r  0 - 1.0
 @param g  0 - 1.0
 @param b  0 - 1.0
 @param a  0 - 1.0
 @param vector  CIVector可为空
 @return 返回处理后的图片
 */
+(CIImage *)filterWithImage:(CIImage *)inputImage
                          r:(CGFloat)r
                          g:(CGFloat)g
                          b:(CGFloat)b
                          a:(CGFloat)a
                       bias:(CIVector *)vector;


@end
