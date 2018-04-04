//
//  PPCropController.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/4/3.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PPCropController.h"

@interface PPCropController ()<PPCropViewDelegate>
@property (nonatomic, strong) PPCropView *cropView;
@end

@implementation PPCropController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.cropView = [[PPCropView alloc] initCropViewWithFrame:CGRectMake(0, 0,XL_ScreenW, XL_ScreenH)
                                                 compoundPath:self.compoundPath
                                                  sourceImage:self.sourceImage cropType:self.cropType];
    [self.view addSubview:self.cropView];
    self.cropView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark - delegate
- (void)cropView:(PPCropView *)view clipImage:(UIImage *)clipImage
{
     if (self.delegate && [self.delegate respondsToSelector:@selector(cropController:clipImage:)]) {
    [self.delegate cropController:self clipImage:clipImage];
     }
}

- (void)cropViewClipCancel:(PPCropView *)view
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cropControllerClipCancel:)]) {
        [self.delegate cropControllerClipCancel:self];
    }
}
- (void)dealloc
{
    self.delegate = nil;
}

#pragma mark - private



@end
