//
//  Tile.h
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import <Foundation/Foundation.h>

@interface Tile : NSObject

@property(nonatomic) uint value;
@property(nonatomic, getter = isChosen) BOOL chosen;

- (instancetype) initWithValue:(uint) value;

@end
