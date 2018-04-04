//
//  PPCompoundPath_sub.m
//  PictureProcessKitTest
//
//  Created by Peter Hu on 2018/4/3.
//  Copyright © 2018年 PeterHu. All rights reserved.
//

#import "PPCompoundPath_sub.h"

@implementation PPCompoundPath_sub


#pragma mark =============== json ===============
- (NSMutableDictionary *)mj_keyValues
{
    NSMutableDictionary *dict = [super mj_keyValues];
    [dict removeObjectForKey:@"paths"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.paths.count; i++) {
        PPPointPath *path = self.paths[i];
        [array addObject:path.mj_keyValues];
    }
    [dict setValue:array.mj_keyValues forKey:@"paths"];
    return dict;
}


+ (PPCompoundPath_sub *)getDefaultSquareCompounPath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"squareMask.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *squareMask = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return [PPCompoundPath_sub mj_objectWithKeyValues:squareMask];
}


+ (NSDictionary *)mj_objectClassInArray
{
    return @{ @"paths": [PPPointPath_sub class]};
}

@end
