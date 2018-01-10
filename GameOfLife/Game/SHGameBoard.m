//
//  SHGameBoard.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGameBoard.h"

@interface SHGameBoard ()

@property (nonatomic,strong) NSMutableDictionary <NSString *, NSNumber *> *cells;

@end

@implementation SHGameBoard

- (instancetype)initWithSize:(struct SHBoardSize) size
{
    self = [super init];
    if (self) {
        self.size = size;
        [self createCells];
    }
    return self;
}

-(void)createCells
{
    NSMutableDictionary *cells = [NSMutableDictionary dictionary];
    for (NSUInteger x =0; x<self.size.width; x++) {
        for (NSUInteger y =0; y<self.size.height; y++) {
            NSString *key = [self keyForX:x andY:y];
            cells[key] = @(SHCellStateDead);
        }
    }
    self.cells = cells;
}

-(void)nextStep
{
    NSMutableDictionary *nextCells = [NSMutableDictionary dictionary];
    for (NSUInteger x =0; x<self.size.width; x++) {
        for (NSUInteger y =0; y<self.size.height; y++) {
            NSString *key = [self keyForX:x andY:y];
            nextCells[key] = @([self futureStateForX:x andY:y]);
        }
    }
    self.cells = nextCells;
}

-(SHCellState)futureStateForX:(NSUInteger) x andY:(NSUInteger)y
{
    NSString *key = [self keyForX:x andY:y];
    NSUInteger neighborCount =  [self neighborCountForX:x andY:y];
    if (([self.cells[key] integerValue] == SHCellStateAlive && neighborCount==2) ||
        neighborCount == 3) {
        return SHCellStateAlive;
    }
    return SHCellStateDead;
}

-(NSUInteger)neighborCountForX:(NSUInteger)x andY:(NSUInteger)y
{
    NSUInteger neighborCount = 0;
    NSString *centerCellKey = [self keyForX:1 andY:1];
    for (NSUInteger x =0; x<3; x++) {
        for (NSUInteger y =0; y<3; y++) {
            NSString *key = [self keyForX:x andY:y];
            if ([key isEqualToString:centerCellKey])
                continue;
            if ([self.cells[key] integerValue]==SHCellStateAlive)
                neighborCount++;
        }
    }
    return neighborCount;
}


-(void)print
{
    
}

-(void)clear
{
    [self createCells];
}

#pragma mark - Helpers

-(NSString *)keyForX:(NSUInteger) x andY:(NSUInteger) y
{
    return [NSString stringWithFormat:@"%lu_%lu",x,y];
}
@end
