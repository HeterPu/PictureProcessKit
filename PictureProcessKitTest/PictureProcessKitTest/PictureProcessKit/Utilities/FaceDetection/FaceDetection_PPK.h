//
//  Created by Peter Hu on 2018/3/21.
//  Copyright © 2018年 PeterHu. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface Face_PPK : NSObject

@property(nonatomic, assign) CGRect bounds;
@property(nonatomic, assign) CGPoint leftEyePosition;
@property(nonatomic, assign) CGPoint rightEyePosition;
@property(nonatomic, assign) CGPoint mouthPosition;
@property(nonatomic, assign) CGFloat rotationAngle;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImageView *imageView;

@end


@interface FaceDetection_PPK : NSObject

+ (instancetype)sharedInstance;

- (NSMutableArray*)faceDetector:(UIImage*)originalImage;

@end
