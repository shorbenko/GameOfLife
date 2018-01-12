//
//  SHGameBoard.h
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHGameConstants.h"
#import "SHPattern.h"

@interface SHGameBoard : NSObject

@property (nonatomic,assign) struct SHSize size;

- (instancetype)initWithSize:(struct SHSize) size;

-(void)addPattern:(SHPattern *)pattern;// adds to the top right corner
-(void)nextStep;
-(NSString *)stringRepresentation;
-(void)clear;

@end
