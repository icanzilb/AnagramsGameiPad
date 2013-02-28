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

@interface ViewController ()
@end

@implementation ViewController

//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Level* level1 = [Level levelWithNum:1];
    NSLog(@"anagrams: %@", level1.anagrams);
}

//show tha game menu on app start
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

@end
