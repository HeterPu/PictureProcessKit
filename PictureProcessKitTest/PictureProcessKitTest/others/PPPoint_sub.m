//
//  PPPoint_sub.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/4/3.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PPPoint_sub.h"

@implementation PPPoint_sub

- (instancetype)mj_setKeyValues:(id)keyValues
{
    NSArray *pointKeyValues = keyValues;
    
    self.x = pointKeyValues[0];
    self.y = pointKeyValues[1];
    self.type = pointKeyValues[2];
    return self;
}

- (NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary *keyValues = [super mj_keyValues];
    keyValues = (NSMutableDictionary *)@[@(self.x.floatValue), @(self.y.floatValue), @(self.type.floatValue)];
    return keyValues;
}

@end
