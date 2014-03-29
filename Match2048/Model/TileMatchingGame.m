//
//  TileMatchingGame.m
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import "TileMatchingGame.h"
#import "Tile.h"

@interface TileMatchingGame()
@property(nonatomic, readwrite) uint numChosen;
@property(nonatomic, strong) NSDictionary *backgroundColors;
@property(nonatomic, strong, readwrite) UIColor *defaultColor;
@end

int const MIN_COLORED_VALUE = 8;
int const MAX_COLORED_VALUE = 4096;

@implementation TileMatchingGame
- (UIColor *) defaultColor {
   if (!_defaultColor)
      _defaultColor = [[UIColor alloc] initWithRed:204/255.0 green:192/255.0 blue:179/255.0 alpha:1.0];
   return _defaultColor;
}

- (NSDictionary *) backgroundColors {
   if (!_backgroundColors) {
      _backgroundColors = @{
         @2:[[UIColor alloc] initWithRed:238/255.0 green:228/255.0 blue:218/255.0 alpha:1],
         @4:[[UIColor alloc] initWithRed:237/255.0 green:224/255.0 blue:200/255.0 alpha:1],
         @8:[[UIColor alloc] initWithRed:242/255.0 green:177/255.0 blue:121/255.0 alpha:1],
         @16:[[UIColor alloc] initWithRed:245/255.0 green:148/255.0 blue:98/255.0 alpha:1],
         @32:[[UIColor alloc] initWithRed:246/255.0 green:124/255.0 blue:95/255.0 alpha:1],
         @64:[[UIColor alloc] initWithRed:246/255.0 green:94/255.0 blue:59/255.0 alpha:1],
         @128:[[UIColor alloc] initWithRed:237/255.0 green:207/255.0 blue:114/255.0 alpha:1],
         @512:[[UIColor alloc] initWithRed:237/255.0 green:200/255.0 blue:80/255.0 alpha:1],
         @256:[[UIColor alloc] initWithRed:237/255.0 green:204/255.0 blue:97/255.0 alpha:1],
         @1024:[[UIColor alloc] initWithRed:237/255.0 green:197/255.0 blue:63/255.0 alpha:1],
         @2048:[[UIColor alloc] initWithRed:237/255.0 green:194/255.0 blue:46/255.0 alpha:1],
         @4096:[[UIColor alloc] initWithRed:60/255.0 green:58/255.0 blue:50/255.0 alpha:1],};
   }
   return _backgroundColors;
}

/**
 * Creates an array of tiles from an array of integers.
 */
- (NSMutableArray*) tilesWithValues:(NSArray*) values {
   NSMutableArray *data = [[NSMutableArray alloc] init];
   int id = 0;
   for (NSNumber *value in values) {
      [data addObject:[[Tile alloc] initWithId:id value:value.intValue]];
   }
   return data;
}

- (NSArray *) shuffleArray:(NSArray *)array {
   NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
   
   for(NSUInteger i = [array count]; i > 1; i--) {
      NSUInteger j = arc4random_uniform(i);
      [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
   }
   
   return [NSArray arrayWithArray:temp];
}

- (NSMutableArray *) tiles {
   if (!_tiles) { // Default board.
      NSArray *values = @[@1024, @2, @4, @8,
                          @16, @32, @64, @128,
                          @256, @512, @2, @2,
                          @2, @2, @16, @32];
      _tiles = [self tilesWithValues:[self shuffleArray:values]];
   }
   return _tiles;
}

- (void) newGame {
   self.tiles = nil;
   self.numChosen = 0;
}

- (void) chooseTileAtIndex:(uint)index {
   Tile *tile = [self.tiles objectAtIndex:index];
   if (self.numChosen == 2) {  // Ensures both tiles are displayed before clearing
      self.numChosen = 0;
      for (Tile *other in self.tiles)
         if (other.isChosen) other.chosen = false;
   }
   
   self.numChosen++;
   
   if (tile.isChosen) {
      tile.chosen = false;
   } else if (self.numChosen < 2) {
      tile.chosen = true;
   } else {
      for (Tile *other in self.tiles) {
         if (other.isChosen && other.value == tile.value) {
            tile.value = tile.value * 2;
            other.value = 2;
            break;
         }
      }
      tile.chosen = true;
   }
}

- (Tile *) tileAtIndex:(uint) index {
   return self.tiles[index];
}

- (UIColor *) getBackgroundColorForValue:(uint) value {
   if (value > MAX_COLORED_VALUE)
      value = MAX_COLORED_VALUE;
   UIColor *color = [self.backgroundColors objectForKey:[[NSNumber alloc] initWithInt:value]];
   if (!color)
      color =  [[UIColor alloc] initWithRed:238/255.0 green:228/255.0 blue:218/255.0 alpha:1];
   return color;
}

- (UIColor *) getTitleColorForValue:(uint) value {
   if (value >= MIN_COLORED_VALUE)
      return [UIColor whiteColor];
   return [[UIColor alloc] initWithRed:119/255.0 green:110/255.0 blue:101/255.0 alpha:1.0];
}
@end
