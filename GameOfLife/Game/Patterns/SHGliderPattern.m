//
//  SHGliderPattern.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/11/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGliderPattern.h"
#import "SHGameBoardCellKeyBuilder.h"

@interface SHGliderPattern ()

@end

@implementation SHGliderPattern

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cells = @[@[@(SHCellStateDead),@(SHCellStateAlive),@(SHCellStateDead)],
                       @[@(SHCellStateDead),@(SHCellStateDead),@(SHCellStateAlive)],
                       @[@(SHCellStateAlive),@(SHCellStateAlive),@(SHCellStateAlive)],
                       ];
    }
    return self;
}

@end
