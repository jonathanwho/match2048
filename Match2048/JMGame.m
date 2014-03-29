//
//  JMGame.m
//  Match2048
//
//  Created by Jonathan Rodrigo Miranda on March 28, 2014 1:58 PM.
//
//

#import "JMGame.h"

@implementation JMGame

- (NSMutableArray *) tiles {
   if (!_tiles) {
      NSArray *data = @[@2, @2, @2, @2,
                 @4, @4, @4, @4,
                 @8, @8, @8, @8,
                 @16, @16, @16, @16];
      _tiles = [[NSMutableArray alloc] initWithArray:data];
   }
   return _tiles;
}

@end
