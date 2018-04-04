//
//  PictureSelectViewController.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/4/3.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PictureSelectViewController.h"
#import "PPCompoundPath_sub.h"
#import "PPCropController.h"

@interface PictureSelectViewController ()<PPCropImageControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end

@implementation PictureSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)selectedClick:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    UIImagePickerController *picker = kImagePicker;
    //    if (!picker) {
    //        return;
    //    }
    // 打开图库
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        return;
    }
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}





// 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGRect rect = CGRectMake(0, 0, 300, 200);
    PPCompoundPath *compoundPath = [PPCompoundPath compoundPathWithRect:rect];
    PPCropController *crop = [[PPCropController alloc] init];
    crop.cropType = PPCropTypeEdgeExtends;
    crop.sourceImage = image;
    crop.delegate = self;
    crop.compoundPath = compoundPath;
    crop.hidesBottomBarWhenPushed = YES;
    [picker pushViewController:crop animated:YES];
}


// 取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [ picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - crop view controller delegate

// 选择图片
- (void)cropController:(PPCropController *)crop clipImage:(UIImage *)image
{
    _imageV.image = image;
    // 设置图片, 配置宽高
    [crop.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 取消选择
- (void)cropControllerClipCancel:(PPCropController *)crop
{
    [crop.navigationController dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
