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

#import "HUDView.h"
#import "GameData.h"

//just under the imports at the top
typedef void (^CallbackBlock)();

@interface GameController : NSObject<TileDragDelegateProtocol>

//the view to add game elements to
@property (weak, nonatomic) UIView* gameView;
@property (weak, nonatomic) HUDView* hud;

//the current level
@property (strong, nonatomic) Level* level;
//keep the score
@property (strong, nonatomic) GameData* data;

@property (strong, nonatomic) AudioController* audioController;

@property (strong, nonatomic) CallbackBlock onAnagramSolved;

//display a new anagram on the screen
-(void)dealRandomAnagram;

@end
