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
- (IBAction)onTileClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tileContainer;
@end
