//
//  SHPattern.h
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/11/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHGameConstants.h"

@interface SHPattern : NSObject

@property (nonatomic,strong) NSArray <NSArray <NSNumber *> *> *cells;

@end
