//
//  SHGameConstants.h
//  GameOfLife
//
//  Created by Serhii Horbenko on 1/11/18.
//  Copyright © 2018 Serhii Horbenko. All rights reserved.
//

struct SHSize {
    int width;
    int height;
};

typedef NS_ENUM(int, SHCellState) {
    SHCellStateDead = 0,
    SHCellStateAlive = 1
};
