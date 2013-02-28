//
//  GameData.m
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "GameData.h"

@implementation GameData

//always start blank
-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        //initialize
        self.points = 0;
    }
    return self;
}

//custom setter - keep the score positive
-(void)setPoints:(int)points
{
    _points = MAX(points, 0);
}

@end
