//
//  Tile.m
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import "Tile.h"

@implementation Tile

- (instancetype) initWithId:(uint)id value:(uint)value {
   self = [super init];
   self.id = id;
   self.value = value;
   self.chosen = false;
   return self;
}

@end
