//
//  ViewController.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/3/21.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "ViewController.h"
#import "CubeMap_PK.h"
#import "UIImage+PPK_Help.h"
#import "BaseTableViewCell.h"
#import "PictureCreateViewController.h"
#import "PictureComposition.h"


@interface ViewController ()
    
@property(nonatomic,strong)NSArray *menuArra;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
//    _backV.image = [UIImage imageNamed:@"back"];
//    _frontv.image = [UIImage imageNamed:@"front"];
//    [self normalcrop];
    // Do any additional setup after loading the view, typically from a nib.
}


-(NSArray *)menuArra{
    if (!_menuArra) {
        _menuArra = @[@[@"Picture Create And Comosite",@"Create",@"Composite"],
                      @[@"CoreImage",@"Matting",@"Face detection"],
                      @[@"Others"]
                      ];
    }
    return _menuArra;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.menuArra.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arra = self.menuArra[section];
    return arra.count - 1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *header = [[UILabel alloc]init];
    header.text = self.menuArra[section][0];
    return header;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.menuArra[indexPath.section][indexPath.row + 1];

    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.textLabel.text = str;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PictureCreateViewController *con = [[PictureCreateViewController alloc]init];
            [self.navigationController pushViewController:con animated:true];
        }else if(indexPath.row == 1){
            PictureComposition *con = [PictureComposition new];
             [self.navigationController pushViewController:con animated:true];
        }else{
        }
    }
   
}



-(void)normalcrop{
//    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] size:CGSizeMake(1500, 1500)];
//    UIImage *frontImage = [UIImage imageNamed:@"front"];
//
//    UIImage *result = [UIImage  ppk_imageAddImage:frontImage toImage:backgroundImage positionXYRatio:CGPointMake(0.2, 0.4)];
//    _resultview.image = result;
//
//
//    NSData *data;
//    if (UIImagePNGRepresentation(result) == nil){
//        data = UIImageJPEGRepresentation(result, 1);
//    } else {
//        data = UIImagePNGRepresentation(result);
//    }
//
//    [self saveImage:data WithName:@"123.png"];
    
//    [self loadImageFinished:result];
}
    
    
- (void)saveImage:(NSData *)tempImage WithName:(NSString *)imageName
    
    {
        
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString * documentsDirectory = [paths objectAtIndex:0];
        
        // Now we get the full path to the file
        
        NSString * fullPathToFile = [documentsDirectory stringByAppendingString:imageName];
        
        // and then we write it out
        
        [tempImage writeToFile:fullPathToFile atomically:NO];
        
        //    NSLog(@"路径：%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents1.png"]);
        
        
        
        
        
        // 将存入到沙盒的图片再取出来，目的是为了进行上传
        
        NSLog(@"fullPathToFile:%@", fullPathToFile);
        
//        NSString * path = fullPathToFile;
//
//        // 二进制的数据就可以进行上传
//
//        NSData * data = [NSData dataWithContentsOfFile:path];
//
//        UIImage * image = [UIImage imageWithData:data];
        
//        self.postImage.image = image;/
        
    }
    


    
- (void)loadImageFinished:(UIImage *)image
{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
    
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
        NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}
    
    
    
-(void)cubmaptest{
    
    
     UIImage *backgroundImage = [UIImage imageNamed:@"front"];
     UIImage *frontImage = [UIImage imageNamed:@"back"];
    
    
    struct CubeMap   myCube = createCubeMap(255, 255);
    NSData *myData = [[NSData alloc]initWithBytesNoCopy:myCube.data length:myCube.length freeWhenDone:true];
    CIFilter *colorCubeFilter = [CIFilter filterWithName:@"CIColorCube"];
    [colorCubeFilter setValue:[NSNumber numberWithFloat:myCube.dimension] forKey:@"inputCubeDimension"];
    [colorCubeFilter setValue:myData forKey:@"inputCubeData"];
    [colorCubeFilter setValue:[CIImage imageWithCGImage:frontImage.CGImage] forKey:kCIInputImageKey];
    
    CIImage *outputImage = colorCubeFilter.outputImage;
    CIFilter *sourceOverCompositingFilter = [CIFilter filterWithName:@"CISourceOverCompositing"];
    [sourceOverCompositingFilter setValue:outputImage forKey:kCIInputImageKey];
    [sourceOverCompositingFilter setValue:[CIImage imageWithCGImage:backgroundImage.CGImage] forKey:kCIInputBackgroundImageKey];
    
    outputImage = sourceOverCompositingFilter.outputImage;
    struct CGImage *cgImage = [[CIContext contextWithOptions: nil]createCGImage:outputImage fromRect:outputImage.extent];
//    _resultview.image = [UIImage imageWithCGImage:cgImage];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
