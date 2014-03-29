//
//  TileMatchingGame.h
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import <Foundation/Foundation.h>
@class Tile;
@interface TileMatchingGame : NSObject

@property(strong, nonatomic) NSMutableArray *tiles;
@property(nonatomic, readonly) uint numChosen;
@property(nonatomic, strong, readonly) UIColor *defaultColor;
@property(nonatomic, readonly) uint score;
@property(nonatomic, getter = isOver) BOOL over;

- (void) chooseTileAtIndex:(uint) index;
- (Tile *) tileAtIndex:(uint) index;
- (UIColor *) getBackgroundColorForValue:(uint) value;
- (UIColor *) getTitleColorForValue:(uint) value;
- (void) newGame;
@end
