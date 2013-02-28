//
//  TileView.h
//  Anagrams
//
//  Created by Marin Todorov on 28/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@protocol TileDragDelegateProtocol
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt;
@end

@interface TileView : UIImageView

@property (strong, nonatomic, readonly) NSString* letter;
@property (assign, nonatomic) BOOL isMatched;

@property (unsafe_unretained, nonatomic) id dragDelegate;

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;
-(void)randomize;

@end
