//
//  GameController.h
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

#import "TileView.h"
#import "AudioController.h"

@interface GameController : NSObject<TileDragDelegateProtocol>

//the view to add game elements to
@property (weak, nonatomic) UIView* gameView;

//the current level
@property (strong, nonatomic) Level* level;

@property (strong, nonatomic) AudioController* audioController;

//display a new anagram on the screen
-(void)dealRandomAnagram;

@end
