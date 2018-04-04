//
//  PPPointPath_sub.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/4/3.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PPPointPath_sub.h"

@implementation PPPointPath_sub


#pragma mark =============== json ===============

- (instancetype)mj_setKeyValues:(id)keyValues
{
    NSDictionary *dict = keyValues;
    
    NSArray *points = [dict valueForKey:@"points"];
    self.points = [NSMutableArray arrayWithCapacity:points.count];
    
    for (NSInteger i = 0; i < points.count; i ++) {
        PPPoint_sub *point = [[PPPoint_sub alloc] init];
        [point mj_setKeyValues:points[i]];
        [self.points addObject:point];
    }
    
    self.w = [dict valueForKey:@"w"];
    self.h = [dict valueForKey:@"h"];
    
    return self;
}

- (NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary *dict = [super mj_keyValues];
    
    [dict removeObjectForKey:@"points"];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0 ; i < self.points.count; i ++) {
        PPPoint *point = self.points[i];
        [array addObject:point.mj_keyValues];
    }
    
    [dict setObject:array.mj_keyValues forKey:@"points"];
    return dict;
}


+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"points" : [PPPoint_sub class]};
}

@end
