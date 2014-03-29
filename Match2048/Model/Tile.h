//
//  Tile.h
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import <Foundation/Foundation.h>

@interface Tile : NSObject

@property(nonatomic) uint id; // TODO: Deprecate 
@property(nonatomic) uint value;
@property(nonatomic, getter = isChosen) BOOL chosen;

- (instancetype) initWithId:(uint)id value:(uint) value;

@end
