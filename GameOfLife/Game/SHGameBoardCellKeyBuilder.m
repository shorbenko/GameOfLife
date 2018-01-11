//
//  SHGameBoardCellKeyBuilder.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/11/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGameBoardCellKeyBuilder.h"

@implementation SHGameBoardCellKeyBuilder

+(NSString *)keyForX:(NSUInteger) x andY:(NSUInteger) y
{
    return [NSString stringWithFormat:@"%lu_%lu",x,y];
}

@end
