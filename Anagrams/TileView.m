//
//  TileView.m
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "TileView.h"
#import "config.h"
#import "QuartzCore/QuartzCore.h"

//1
@implementation TileView
{
    
}

//2
- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

//3 create new tile for a given letter
-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength
{
    //the back of the tile
    UIImage* img = [UIImage imageNamed:@"tile.png"];
    
    //create a new object
    self = [super initWithImage:img];
    
    if (self != nil) {
        
        //resize the tile
        float scale = sideLength/img.size.width;
        self.frame = CGRectMake(0,0,img.size.width*scale, img.size.height*scale);
        
        //more innitialization
    }
    
    return self;
}

//4
-(void)randomize
{
    
}

@end