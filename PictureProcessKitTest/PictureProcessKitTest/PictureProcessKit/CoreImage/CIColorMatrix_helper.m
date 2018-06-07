//
//  CIColorMatrix_helper.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/6/7.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "CIColorMatrix_helper.h"

@implementation CIColorMatrix_helper


+(CIImage *)revertImage:(CIImage *)inputImage{
    return [CIFilter filterWithName:@"CIColorMatrix" withInputParameters:
  @{kCIInputImageKey:inputImage,
    @"inputRVector":[CIVector vectorWithX:-1 Y:0 Z:0],
    @"inputGVector":[CIVector vectorWithX:0 Y:-1 Z:0],
    @"inputBVector":[CIVector vectorWithX:0 Y:0 Z:-1],
    @"inputBiasVector":[CIVector vectorWithX:1 Y:1 Z:1]}].outputImage;
}


+(CIImage *)filterWithImage:(CIImage *)inputImage r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a bias:(CIVector *)vector{
    NSMutableDictionary *dict;
    if (a == 1) {
        dict = [NSMutableDictionary dictionaryWithDictionary: @{kCIInputImageKey:inputImage,
                                                                @"inputRVector":[CIVector vectorWithX:r Y:0 Z:0],
                                                                @"inputGVector":[CIVector vectorWithX:0 Y:g Z:0],
                                                                @"inputBVector":[CIVector vectorWithX:0 Y:0 Z:b]}];
    }else{
        dict = [NSMutableDictionary dictionaryWithDictionary: @{kCIInputImageKey:inputImage,
                                                                @"inputRVector":[CIVector vectorWithX:r Y:0 Z:0 W:0],
                                                                @"inputGVector":[CIVector vectorWithX:0 Y:g Z:0 W:0],
                                                                @"inputBVector":[CIVector vectorWithX:0 Y:0 Z:b W:0],
                                                                @"inputAVector":[CIVector vectorWithX:0 Y:0 Z:0 W:a]}];
    }
    
    if (vector) {
        [dict setObject:vector forKey:@"inputBiasVector"];
    }
    return [CIFilter filterWithName:@"CIColorMatrix" withInputParameters:dict].outputImage;
}






@end
