//
//  CounterLabelView.m
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "CounterLabelView.h"

@implementation CounterLabelView
{
    int endValue;
    double delta;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//create an instance of the counter label
+(instancetype)labelWithFont:(UIFont*)font frame:(CGRect)r andValue:(int)v
{
    CounterLabelView* label = [[CounterLabelView alloc] initWithFrame:r];
    if (label!=nil) {
        //initialization
        label.backgroundColor = [UIColor clearColor];
        label.font = font;
        label.value = v;
    }
    return label;
}

//update the label's text
-(void)setValue:(int)value
{
    _value = value;
    self.text = [NSString stringWithFormat:@" %i", self.value];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
