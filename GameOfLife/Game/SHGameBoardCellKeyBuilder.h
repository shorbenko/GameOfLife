//
//  SHGameBoardCellKeyBuilder.h
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/11/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHGameBoardCellKeyBuilder : NSObject

+(NSString *)keyForX:(NSUInteger) x andY:(NSUInteger) y;

@end
