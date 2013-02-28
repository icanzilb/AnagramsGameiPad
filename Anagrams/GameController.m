//
//  GameController.m
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "GameController.h"

@implementation GameController

//fetches a random anagram, deals the letter tiles and creates the targets
-(void)dealRandomAnagram
{
    NSAssert(self.level.anagrams, @"no level loaded");
    
    //random anagram
    int randomIndex = arc4random()%[self.level.anagrams count];
    NSArray* anaPair = self.level.anagrams[ randomIndex ];
    
    NSString* anagram1 = anaPair[0];
    NSString* anagram2 = anaPair[1];
    
    int ana1len = [anagram1 length];
    int ana2len = [anagram2 length];
    
    NSLog(@"phrase1[%i]: %@", ana1len, anagram1);
    NSLog(@"phrase2[%i]: %@", ana2len, anagram2);
    
}

@end
