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
    int _xOffset, _yOffset;
    CGAffineTransform tempTransform;    
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
        
        //add a letter on top
        UILabel* lblChar = [[UILabel alloc] initWithFrame:self.bounds];
        lblChar.textAlignment = NSTextAlignmentCenter;
        lblChar.textColor = [UIColor whiteColor];
        lblChar.backgroundColor = [UIColor clearColor];
        lblChar.text = [letter uppercaseString];
        lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:78.0*scale];
        [self addSubview: lblChar];
        
        //enable user interaction
        self.userInteractionEnabled = YES;
        self.isMatched = NO;
        
        //save the letter
        _letter = letter;
        
        //create the tile shadow
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0;
        self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
        self.layer.shadowRadius = 15.0f;
        self.layer.masksToBounds = NO;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath = path.CGPath;
        
        
    }
    
    return self;
}

//4
-(void)randomize
{
    //set random rotation of the tile
    //anywhere between -0.2 and 0.3 radians
    float rotation = randomf(0,50) / (float)100 - 0.2;
    self.transform = CGAffineTransformMakeRotation( rotation );
    
    //move randomly upwards
    int yOffset = (arc4random() % 10) - 10;
    self.center = CGPointMake(self.center.x, self.center.y + yOffset);
}

#pragma mark - draggin the tile
//store the initial offset of the user finger from the tile center
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    _xOffset = pt.x - self.frame.size.width/2;
    _yOffset = pt.y - self.frame.size.height/2;
    
    //save the current transform
    tempTransform = self.transform;
    
    //enlarge the tile
    self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    
    //show the drop shadow
    self.layer.shadowOpacity = 0.8;
}

//move the tile under the user finger
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
}

//reset the view transoform in case drag is cancelled
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = tempTransform;
        self.layer.shadowOpacity = 0.0;
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = tempTransform;
        self.layer.shadowOpacity = 0.0;
    }];
    
    if (self.dragDelegate) {
        [self.dragDelegate tileView:self didDragToPoint:self.center];
    }
}



@end