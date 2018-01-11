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
        struct SHSize size;
        size.width = 3;
        size.height = 3;
        self.size = size;
        self.cells = @{[SHGameBoardCellKeyBuilder keyForX:2 andY:0]: @(SHCellStateAlive),
                       [SHGameBoardCellKeyBuilder keyForX:0 andY:1]: @(SHCellStateAlive),
                       [SHGameBoardCellKeyBuilder keyForX:2 andY:1]: @(SHCellStateAlive),
                       [SHGameBoardCellKeyBuilder keyForX:1 andY:2]: @(SHCellStateAlive),
                       [SHGameBoardCellKeyBuilder keyForX:2 andY:2]: @(SHCellStateAlive)
                       };
    }
    return self;
}

@end
