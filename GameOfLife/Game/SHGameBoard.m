//
//  SHGameBoard.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGameBoard.h"

@interface SHGameBoard ()

@property (nonatomic,assign) int *cells; // current state, pointer to c array of width*height size

@end

@implementation SHGameBoard

- (instancetype)initWithSize:(struct SHSize) size
{
    self = [super init];
    if (self) {
        self.size = size;
        self.cells = [self createCells];
    }
    return self;
}

#pragma mark - Run

-(void)nextStep
{
    [self runNextStep];
}

-(void)runNextStep
{
    int *nextCells = [self createCells];
    int *cells = self.cells;
    
    for (int x = 0; x < self.size.width; x++) {
        for (int y = 0; y < self.size.height; y++) {
            SHCellState state = [self futureStateForX:x andY:y];
            [self setState:state atX:x andY:y inArray:nextCells];
        }
    }
    free(cells);
    cells = NULL;
    self.cells = nextCells;
}

-(SHCellState)futureStateForX:(int) x andY:(int)y
{
    NSUInteger neighborCount =  [self neighborCountForX:x andY:y];
    SHCellState state = [self stateAtX:x andY:y inArray:self.cells];
    if ((state == SHCellStateAlive && neighborCount ==2 ) ||
        neighborCount == 3) {
        return SHCellStateAlive;
    }
    return SHCellStateDead;
}

#pragma mark - Neighbors

-(NSUInteger)neighborCountForX:(int)x andY:(int)y
{
    __block NSUInteger neighborCount = 0;
    [self enumerateNeighborsForX:x
                            andY:y
                      usingBlock:^(int neighborX, int neighborY) {
                          if ([self stateAtX:neighborX andY:neighborY inArray:self.cells]==SHCellStateAlive)
                              neighborCount++;
                      }];
    return neighborCount;
}

-(void)enumerateNeighborsForX:(int)x
                         andY:(int)y
                   usingBlock:(void (^)(int neighborX, int neighborY))block
{
    for (int i = x-1; i <= x+1; i++) {
        for (int j = y-1; j <= y+1; j++) {
            // skip the dot itself
            if (x==i && j==y)
                continue;
            // skip the dot itself
            if (x==i && j==y)
                continue;
            // out of bounds checks
            int finalX = i;
            if (i < 0)
                finalX = self.size.width - 1;
            else if (i == self.size.width) {
                finalX = 0;
            }
            int finalY = j;
            if (j < 0)
                finalY = self.size.height - 1;
            else if (j == self.size.height) {
                finalY = 0;
            }
            block(finalX, finalY);
        }
    }
}

#pragma mark - Pattern insertion

-(void)addPattern:(SHPattern *)pattern
{
    for (int x = 0; x<pattern.cells.count; x++) {
        NSArray *col = pattern.cells[x];
        for (int y =0; y < col.count; y++) {
            SHCellState state = [col[y] intValue];
            [self setState:state atX:x andY:y inArray:self.cells];
        }
    }
}

#pragma mark - Get & Set operations

-(void)setState:(SHCellState) state
            atX:(int)x
           andY:(int)y
        inArray:(int *)array
{
    int n = self.size.height;
    array[x * n + y] = state;
}

-(SHCellState)stateAtX:(int)x
                  andY:(int)y
               inArray:(int *)array
{
    int n = self.size.height;
    return array[x * n + y];
}

#pragma mark - Clear and init cells

-(void)clear
{
    int *array = self.cells;
    int n = self.size.height;
    for (int x = 0; x < self.size.width; x++) {
        for (int y = 0; y < self.size.height; y++) {
            array[x * n + y] = SHCellStateDead;
        }
    }
}

-(int *)createCells
{
    NSUInteger rows = self.size.width;
    NSUInteger columns = self.size.height;
    int *array = calloc(rows * columns, sizeof(int));
    return array;
}

#pragma mark - Printing

-(NSString *)stringRepresentation
{
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:width*height];
    for (int y = 0; y < height; y++) {
        for (int x = 0; x <width; x++) {
            SHCellState state = [self stateAtX:x andY:y inArray:self.cells];
            NSString *symbol = nil;
            switch (state) {
                case SHCellStateDead:
                    symbol = @"0";
                    break;
                case SHCellStateAlive:
                    symbol = @"1";
                    break;
                default:
                    break;
            }
            [string appendString:symbol];
        }
        [string appendString:@"\n"];
    }
    return string;
}

@end
