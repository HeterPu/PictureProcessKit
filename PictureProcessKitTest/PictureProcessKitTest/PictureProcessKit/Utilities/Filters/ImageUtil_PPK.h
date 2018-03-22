//
//  Created by Peter Hu on 2018/3/21.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ImageUtil_PPK : NSObject 

//实现滤镜效果
+ (UIImage *)imageWithImage:(UIImage*)inImage withColorMatrix:(const float*)f;


@end
