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

// The number of chosen/displayed tiles.
@property(nonatomic, readonly) uint numChosen;

// The default tile color.
@property(nonatomic, strong, readonly) UIColor *defaultColor;

// The current score of the game.
@property(nonatomic, readonly) uint score;

// True if a "2048" tile was made, False otherwise.
@property(nonatomic, getter = isOver) BOOL over;

// Includes all the game logic.
- (void) chooseTileAtIndex:(uint) index;

// Returns the tile at |index|.
- (Tile *) tileAtIndex:(uint) index;

// Gets background color based on tile value.
- (UIColor *) getBackgroundColorForValue:(uint) value;

// Gets text color based on tile value.
- (UIColor *) getTitleColorForValue:(uint) value;

// Resets the game
- (void) newGame;
@end
