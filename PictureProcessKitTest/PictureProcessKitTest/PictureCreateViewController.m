//
//  PictureCreateViewController.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/3/22.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PictureCreateViewController.h"
#import "PictureProcessKit.h"


@interface PictureCreateViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sources;
@property (weak, nonatomic) IBOutlet UIImageView *resultv;

@end

@implementation PictureCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imagefromcolorclick:(id)sender {
   UIImage *image = [UIImage  ppk_imageWithColor:[UIColor redColor]];
    CGSize size = image.size;
    _resultv.image  = image;
    
}


- (IBAction)changeorientation:(id)sender {
    UIImage *image = [UIImage ppk_updateImageOrientation:self.sources.image];
    _resultv.image  = image;
}

- (IBAction)shrinkI:(id)sender {
    UIImage *image = [UIImage ppk_image:self.sources.image targetScale:0.5];
    _resultv.image  = image;
}


- (IBAction)stretchi:(id)sender {
    UIImage *image = [UIImage ppk_stretchableImage:self.sources.image edgeInsets:UIEdgeInsetsMake(100, 100, 100, 100)];
    _resultv.image  = image;
}


- (IBAction)pickfromview:(id)sender {
    UIImage *image = [UIImage ppk_imageWithView:self.sources rect:self.sources.bounds];
    _resultv.image  = image;
}


- (IBAction)cropc:(id)sender {
    UIImage *image =[UIImage ppk_imageCropFromImage:self.sources.image inRatioRect:CGRectMake(0.5, 0.0, 0.5, 0.5)];
    _resultv.image  = image;
}


- (IBAction)picfromWINDOW:(id)sender {
    UIImage *image = [UIImage  ppk_imageWithWindowRect:self.view.bounds];
    _resultv.image  = image;
}


- (IBAction)cropinrect:(id)sender {
    UIImage *image =[UIImage ppk_imageCropFromImage:self.sources.image inRect:CGRectMake(0.0, 0.0, 500, 500)];
    _resultv.image  = image;
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
