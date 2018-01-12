//
//  ViewController.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHViewController.h"
#import "SHGame.h"

@interface SHViewController ()

@property (nonatomic,strong) SHGame *game;

@end

@implementation SHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelectorInBackground:@selector(runGame) withObject:nil];
}

-(void)runGame
{
    self.game = [SHGame new];
    self.game.lifeCycleStepsCount = 5000;
    [self.game runGame];
}

@end
