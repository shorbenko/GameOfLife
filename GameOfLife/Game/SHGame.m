//
//  SHGame.m
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/10/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import "SHGame.h"
#import "SHGameBoard.h"
#import "SHGliderPattern.h"

@interface SHGame ()

@property (nonatomic,strong) SHGameBoard *gameBoard;
@property (nonatomic,assign) NSUInteger currentLifeCycleStep;
@property (nonatomic,strong) dispatch_queue_t printQueue;
@property (nonatomic,strong) NSFileHandle *fileHandle;

@end

@implementation SHGame

- (instancetype)init
{
    self = [super init];
    if (self) {
        struct SHSize size;
        size.width = 100;
        size.height = 200;
        self.gameBoard = [[SHGameBoard alloc] initWithSize:size];
        [self setUpGameOutput];
    }
    return self;
}

-(void)setUpGameOutput
{
    self.printQueue = dispatch_queue_create("SHGamePrintQueue", NULL);
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documents stringByAppendingPathComponent:@"Game.log"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if([fileManager fileExistsAtPath:filePath ]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
}

-(void)runGame
{
    NSDate *methodStart = [NSDate date];
    
    [self.gameBoard addPattern:[SHGliderPattern new]];
    NSString *delimiter = @"\n\n\n";
    NSString *log =[self.gameBoard stringRepresentation];
    [self appendStringToFile:[log stringByAppendingString:delimiter]];
    
    for (NSUInteger i = 0; i < self.lifeCycleStepsCount; i++) {
        @autoreleasepool {
            NSLog(@"Calculating step %lu of %lu",i, self.lifeCycleStepsCount);
            [self.gameBoard nextStep];
            log = [[self.gameBoard stringRepresentation] stringByAppendingString:delimiter];
            [self appendStringToFile:log];
        }
    }
    [self endGame];
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"Execution time = %f seconds, Sppend = %f count/s", executionTime,self.lifeCycleStepsCount/executionTime);
}

-(void)endGame
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(_printQueue , ^ {
        [weakSelf.fileHandle closeFile];
        weakSelf.fileHandle = nil;
        weakSelf.printQueue = nil;
    });
}

-(void)nuclearBomb
{
    [self.gameBoard clear];
}

-(void)appendStringToFile:(NSString *)string
{
    [self appendDataToFile:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

// execute asynchronously
-(void)appendDataToFile:(NSData *)data
{
    NSFileHandle *fileHandle = self.fileHandle;
    dispatch_async(self.printQueue , ^ {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
    });
}

@end
