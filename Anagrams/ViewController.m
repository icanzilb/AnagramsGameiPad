//
//  ViewController.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "config.h"
#import "ViewController.h"
#import "Level.h"
#import "GameController.h"

@interface ViewController ()
@property (strong, nonatomic) GameController* controller;
@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self != nil) {
        //create the game controller
        self.controller = [[GameController alloc] init];
    }
    return self;
}

//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Level* level1 = [Level levelWithNum:1];
    
    //add one layer for all game elements
    UIView* gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview: gameLayer];
    
    self.controller.gameView = gameLayer;
    
}

//show tha game menu on app start
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

@end
