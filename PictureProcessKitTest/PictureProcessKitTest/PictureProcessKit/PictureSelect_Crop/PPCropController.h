//
//  PPCropController.h
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/4/3.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPCompoundPath.h"
#import "PPCropView.h"


@protocol PPCropImageControllerDelegate;


@interface PPCropController : UIViewController

@property (nonatomic, assign) id<PPCropImageControllerDelegate> delegate;  ///< 代理
@property (nonatomic, strong) UIImage *sourceImage;                         ///< 待裁图片
@property (nonatomic, strong) PPCompoundPath *compoundPath;                //蒙版路径
@property (nonatomic,assign) PPCropType cropType;

@end



@protocol  PPCropImageControllerDelegate<NSObject>
@optional
/// 选择了裁剪
- (void)cropController:(PPCropController *)crop
             clipImage:(UIImage *)image;
/// 取消裁剪
- (void)cropControllerClipCancel:(PPCropController *)crop;

@end
