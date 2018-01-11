//
//  SHGameBoard.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGameBoard.h"
#import "SHGameBoardCellKeyBuilder.h"

@interface SHGameBoard ()

@property (nonatomic,strong) NSMutableDictionary <NSString *, NSNumber *> *cells; // current state
@property (nonatomic,strong) NSArray <NSArray <NSString *> *> *cellKeys; // optimization

@end

@implementation SHGameBoard

- (instancetype)initWithSize:(struct SHSize) size
{
    self = [super init];
    if (self) {
        self.size = size;
        [self createCells];
        [self createCellKeys];
    }
    return self;
}

-(void)createCellKeys
{
    NSMutableArray *cellKeys = [NSMutableArray arrayWithCapacity:self.size.width];
    for (NSUInteger x =0; x<self.size.width; x++) {
        NSMutableArray *columnKeys = [NSMutableArray arrayWithCapacity:self.size.height];
        for (NSUInteger y =0; y<self.size.height; y++) {
            NSString *key = [SHGameBoardCellKeyBuilder keyForX:x andY:y];
            [columnKeys addObject:key];
        }
        [cellKeys addObject:columnKeys];
    }
    self.cellKeys = cellKeys;
}

-(void)addPattern:(SHPattern *)pattern
{
    for (NSUInteger x =0; x<pattern.size.width; x++) {
        for (NSUInteger y =0; y<pattern.size.height; y++) {
            NSString *key = [self keyForX:x andY:y];
            SHCellState state = [pattern.cells[key] integerValue];
            [self setState:state forKey:key inCells:self.cells];
        }
    }
}

-(void)clear
{
    [self createCells];
}

-(void)createCells
{
    self.cells = [NSMutableDictionary dictionary];
}

-(void)nextStep
{
    @autoreleasepool {
        [self runNextStep];
    }
}

-(void)runNextStep
{
    NSMutableDictionary *nextCells = [NSMutableDictionary dictionary];
    for (NSUInteger x =0; x<self.size.width; x++) {
        for (NSUInteger y =0; y<self.size.height; y++) {
            NSString *key = [self keyForX:x andY:y];
            SHCellState state = [self futureStateForX:x andY:y];
            [self setState:state forKey:key inCells:nextCells];
        }
    }
    self.cells = nextCells;
}

-(void)setState:(SHCellState) state forKey:(NSString *)key inCells:(NSMutableDictionary *) cells
{
    NSNumber *storedValue = nil;
    // do not waste memory to store dead states as nil will be transformed to 0 same as SHCellStateDead
    if (state!=SHCellStateDead) {
        storedValue = @(state);
    }
    cells[key] = storedValue;
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

-(NSUInteger)neighborCountForX:(NSInteger)x andY:(NSInteger)y
{
    NSUInteger neighborCount = 0;
    for (NSInteger i=x-1; i<=x+1; i++) {
        for (NSInteger j=y-1; j<=y+1; j++) {
            // skip the dot itself
            if (x==i && j==y)
                continue;
            // out of bounds checks
            NSInteger finalX = i;
            if (i<0)
                finalX = self.size.width - 1;
            else if (i==self.size.width) {
                finalX = 0;
            }
            NSInteger finalY = j;
            if (j<0)
                finalY = self.size.height - 1;
            else if (j==self.size.height) {
                finalY = 0;
            }
            NSString *key = [self keyForX:finalX andY:finalY];
            if ([self.cells[key] integerValue]==SHCellStateAlive)
                neighborCount++;
        }
    }
    return neighborCount;
}

#pragma mark - Printing

-(NSString *)stringRepresentation
{
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:self.size.width*self.size.height];
    
    for (NSUInteger y=0; y<self.size.height; y++) {
        for (NSUInteger x =0; x<self.size.width; x++) {
            NSString *key = [self keyForX:x andY:y];
            SHCellState state = [self.cells[key] integerValue];
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

#pragma mark - Helpers

-(NSString *)keyForX:(NSUInteger) x andY:(NSUInteger) y
{
    return self.cellKeys[x][y];
}
@end
