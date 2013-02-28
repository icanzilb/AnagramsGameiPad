//
//  GameController.m
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "GameController.h"
#import "config.h"
#import "TileView.h"
#import "TargetView.h"
#import "ExplodeView.h"

@implementation GameController
{
    //tile lists
    NSMutableArray* _tiles;
    NSMutableArray* _targets;
    
    //stopwatch variables
    int _secondsLeft;
    NSTimer* _timer;
}

//iniitialize the game controller
-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        //initialize
        self.audioController = [[AudioController alloc] init];
        [self.audioController preloadAudioEffects: kAudioEffectFiles];
        
        //initialize the game data
        self.data = [[GameData alloc] init];
    }
    return self;
}

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
    
    //calculate the tile size
    float tileSide = ceilf( kScreenWidth*0.9 / (float)MAX(ana1len, ana2len) ) - kTileMargin;
    
    //get the left margin for first tile
    float xOffset = (kScreenWidth - MAX(ana1len, ana2len) * (tileSide + kTileMargin))/2;
    
    //adjust for tile center (instead the tile's origin)
    xOffset += tileSide/2;
    
    //initialize tile and target lists
    _tiles = [NSMutableArray arrayWithCapacity: ana2len];
    
    //create tiles
    for (int i=0;i<ana1len;i++) {
        NSString* letter = [anagram1 substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4*3);
            [tile randomize];

            tile.dragDelegate = self;
            
            [self.gameView addSubview:tile];
            [_tiles addObject: tile];
        }
    }
    
    //create the targets
    _targets = [NSMutableArray arrayWithCapacity: ana2len];
    for (int i=0;i<ana2len;i++) {
        NSString* letter = [anagram2 substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TargetView* target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
            target.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4);
            
            [self.gameView addSubview:target];
            [_targets addObject: target];
        }
    }
    
    //start the timer
    [self startStopwatch];
    
    
}

//a tile was dragged, check if matches a target
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt
{
    TargetView* targetView = nil;
    
    for (TargetView* tv in _targets) {
        if (CGRectContainsPoint(tv.frame, pt)) {
            targetView = tv;
            break;
        }
    }
    
    //check if target was found
    if (targetView!=nil) {
        
        //check if letter matches
        if ([targetView.letter isEqualToString: tileView.letter]) {
            
            //adjust view on spot
            [self placeTile:tileView atTarget:targetView];
            
            //more successful stuff to do
            [self.audioController playEffect: kSoundDing];
            
            //give points
            self.data.points += self.level.pointsPerTile;
            [self.hud.gamePoints countTo: self.data.points
                               totalTime: 3];
            
            //check for game end
            [self checkForSuccess];
            
        } else {
            
            //visualize the mistake
            [tileView randomize];
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20,20), tileView.center.y + randomf(20, 30));
                             } completion:nil];
            
            //more wrong stuff to do
            [self.audioController playEffect:kSoundWrong];
            
            //take out points
            self.data.points -= self.level.pointsPerTile/2;
            [self.hud.gamePoints countTo: self.data.points
                               totalTime: 1.5];
            
        }
    }
    
    
}

//place a tile on the place of a target with an explosion
-(void)placeTile:(TileView*)tileView atTarget:(TargetView*)targetView
{
    //1 hide the taget
    targetView.hidden = YES;
    targetView.isMatched = YES;
    
    //2 align the tile
    tileView.isMatched = YES;
    tileView.center = targetView.center;
    tileView.userInteractionEnabled = NO;
    
    //3 scale down to normal tile size
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tileView.transform = CGAffineTransformIdentity;
                     } completion:nil];
    
    ExplodeView* explode = [[ExplodeView alloc] initWithFrame:CGRectMake(tileView.center.x,tileView.center.y,10,10)];
    [tileView.superview addSubview: explode];
    [tileView.superview sendSubviewToBack:explode];
    
    
    
}

-(void)checkForSuccess
{
    for (TargetView* t in _targets) {
        //no success, bail out
        if (t.isMatched==NO) return;
    }
    
    //the game has finished, do more stuff
    
    //the anagram is completed!
    [self.audioController playEffect:kSoundWin];
    
    //stop the stopwatch
    [self stopStopwatch];
    
}

-(void)startStopwatch
{
    //initialize the timer HUD
    _secondsLeft = self.level.timeToSolve;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    //schedule a new timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(tick:)
                                            userInfo:nil
                                             repeats:YES];
}

//stop the watch
-(void)stopStopwatch
{
    [_timer invalidate];
    _timer = nil;
}

//stopwatch on tick
-(void)tick:(NSTimer*)timer
{
    _secondsLeft --;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    if (_secondsLeft==0) {
        [self stopStopwatch];
    }
}



@end
