//
//  PictureComposition.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/3/22.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PictureComposition.h"
#import "PictureProcessKit.h"

@interface PictureComposition ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *back;
@property (weak, nonatomic) IBOutlet UIImageView *front;

@property (weak, nonatomic) IBOutlet UIImageView *result;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (strong,nonatomic) NSArray *data;

@property(nonatomic,assign) NSInteger index;

@end

@implementation PictureComposition


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _index = row;
}

- (IBAction)compose:(id)sender {
    
    
        UIImage *backgroundImage = [UIImage ppk_imageWithColor:[UIColor colorWithRed:254.0/255 green:250.0/255 blue:144.0 / 255  alpha:1.0] size:CGSizeMake(1500, 1500)];
        UIImage *frontImage = [UIImage imageNamed:@"front"];
    
        UIImage *result = [UIImage  ppk_imageAddImage:frontImage toImage:backgroundImage position:_index];
        _result.image = result;
    
        NSData *data;
        if (UIImagePNGRepresentation(result) == nil){
            data = UIImageJPEGRepresentation(result, 1);
        } else {
            data = UIImagePNGRepresentation(result);
        }
}



-(NSArray *)data{
    if (!_data) {
        _data = @[@"PositionLeftTop",@"PositionLeftBottom",@"PositionRightTop",@"PositionRightBottom",@"PositionCenter"];
    }
    return _data;
}



-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.data[row];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
