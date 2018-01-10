//
//  SHGameBoard.h
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import <UIKit/UIKit.h>

struct SHBoardSize {
    NSUInteger width;
    NSUInteger height;
};

typedef NS_ENUM(NSUInteger, SHCellState) {
    SHCellStateDead,
    SHCellStateAlive
};


@interface SHGameBoard : NSObject

@property (nonatomic,assign) struct SHBoardSize size;

- (instancetype)initWithSize:(struct SHBoardSize) size;

-(void)clear;
-(void)nextStep;

@end
