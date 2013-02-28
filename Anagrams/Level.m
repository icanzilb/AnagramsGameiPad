//
//  Level.m
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "Level.h"

@implementation Level

+(instancetype)levelWithNum:(int)levelNum;
{
    //1 load .plist file
    NSString* fileName = [NSString stringWithFormat:@"level%i.plist", levelNum];
    NSString* levelPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    NSDictionary* levelDict = [NSDictionary dictionaryWithContentsOfFile:levelPath];
    
    //2 validation
    NSAssert(levelDict, @"level config file not found");
    
    //3 create instance
    Level* l = [[Level alloc] init];
    
    //4 initialize the object from the dictionary
    l.pointsPerTile = [levelDict[@"pointsPerTile"] intValue];
    l.anagrams = levelDict[@"anagrams"];
    l.timeToSolve = [levelDict[@"timeToSolve"] intValue];
    
    return l;
}

@end
