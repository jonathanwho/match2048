//
//  JMViewController.h
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import <UIKit/UIKit.h>
@class TileMatchingGame;
@interface GameViewController : UIViewController

// Selects tile and then updates UI.
- (IBAction)onTileClick:(id)sender;
@end
