//
//  SHGame.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGame.h"
#import "SHGameBoard.h"

@interface SHGame ()

@property (nonatomic,strong) SHGameBoard *gameBoard;

@end

@implementation SHGame

- (instancetype)init
{
    self = [super init];
    if (self) {
        struct SHBoardSize size;
        size.width = 100;
        size.height = 200;
        self.gameBoard = [[SHGameBoard alloc] initWithSize:size];
    }
    return self;
}


-(void)nuclearBomb
{
    
}

@end
