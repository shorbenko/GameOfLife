//
//  SHGame.h
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHGame : NSObject

@property (nonatomic,assign) NSUInteger lifeCycleStepsCount;

-(void)runGame;
-(void)nuclearBomb;

@end
