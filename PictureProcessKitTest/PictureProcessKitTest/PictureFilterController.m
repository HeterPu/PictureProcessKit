//
//  PictureFilterController.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/6/7.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PictureFilterController.h"
#import "CIColorMatrix_helper.h"

@interface PictureFilterController ()
@property (weak, nonatomic) IBOutlet UIImageView *picview;

@property(nonatomic,strong) CIContext  *context;
@property (weak, nonatomic) IBOutlet UISlider *rs;
@property (weak, nonatomic) IBOutlet UISlider *gs;
@property (weak, nonatomic) IBOutlet UISlider *bs;
@property (weak, nonatomic) IBOutlet UISlider *as;
@property (weak, nonatomic) IBOutlet UIView *colorPad;

@end

@implementation PictureFilterController




-(CIContext *)context{
    if (!_context) {
        EAGLContext *eaglContext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
        NSDictionary *dictOp = [NSDictionary  dictionaryWithObject:[[NSNull alloc]init] forKey:kCIContextWorkingColorSpace];
        _context = [CIContext contextWithEAGLContext:eaglContext options:dictOp];
    }
    return _context;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)revertClick:(id)sender {
    CIImage *inputI = [CIImage imageWithCGImage:_picview.image.CGImage];
    CIImage *outPut = [CIColorMatrix_helper revertImage:inputI];
    CGImageRef ref = [self.context createCGImage:outPut fromRect:outPut.extent];
    //    self.ciImage = outputImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.picview.image = [UIImage imageWithCGImage:ref];
        CGImageRelease(ref);
    });
}


- (IBAction)rsC:(id)sender {
    
    CGFloat value1 = _rs.value;
    CGFloat value2 = _gs.value;
    CGFloat value3 = _bs.value;
    CGFloat value4 = _as.value;
    _colorPad.backgroundColor = [UIColor colorWithRed:value1 green:value2 blue:value3 alpha:value4];
    dispatch_queue_t qCreate=dispatch_queue_create("", nil);
    dispatch_async(qCreate, ^{
        CIImage *inputI = [CIImage imageWithCGImage:[UIImage imageNamed:@"front"].CGImage];
        CIImage *outPut = [CIColorMatrix_helper filterWithImage:inputI r:value1 g:value2 b:value3 a:value4 bias:nil];
         CGImageRef ref = [self.context createCGImage:outPut fromRect:outPut.extent];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.picview.image = [UIImage imageWithCGImage:ref];
            CGImageRelease(ref);
        });
    });
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
