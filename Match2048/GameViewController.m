//
//  JMViewController.m
//  Match2048
//
//  Created by Jonathan Miranda on 3/28/14.
//
//

#import "GameViewController.h"
#import "TileMatchingGame.h"
#import "Tile.h"

#define LARGE_CORNER_RADIUS 5.0
#define SMALL_CORNER_RADIUS 2.0
#define COLOR_ANIMATION_SPEED 0.75

@interface GameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tileButtons;
@property (nonatomic, strong) TileMatchingGame *game;
@property (weak, nonatomic) IBOutlet UIButton *startNewGameButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation GameViewController

- (IBAction)startNewGame:(UIButton *)sender {
  [self.game newGame];
  [self updateUI];
}


- (TileMatchingGame *) game {
  if (!_game) _game = [[TileMatchingGame alloc] init];
  return _game;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tileContainer.layer.cornerRadius = LARGE_CORNER_RADIUS;
  self.tileContainer.layer.masksToBounds = YES;
  self.startNewGameButton.layer.cornerRadius = LARGE_CORNER_RADIUS;
  self.startNewGameButton.layer.masksToBounds = YES;
  
  for (UIButton *button in self.tileButtons) {
    button.layer.cornerRadius = SMALL_CORNER_RADIUS;
    button.layer.masksToBounds = YES;
    button.titleLabel.numberOfLines = 1;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning]; // Dispose of any resources that can be recreated.
}

- (IBAction)onTileClick:(UIButton *)sender {
  int index = [self.tileButtons indexOfObject:sender];
  [self.game chooseTileAtIndex:index];
  [self updateUI];
}

- (void) updateUI {
  float animationSpeed;
  for (UIButton *button in self.tileButtons) {
    int index = [self.tileButtons indexOfObject:button];
    Tile *tile = [self.game tileAtIndex:index];
    NSString *title = @"";
    animationSpeed = COLOR_ANIMATION_SPEED;
    
    if (self.game.numChosen <= 2 && tile.isChosen)
      title = [NSString stringWithFormat:@"%d", tile.value];
    
    UIColor *backgroundColor = self.game.defaultColor;
    if (tile.isChosen) {
      backgroundColor = [self.game getBackgroundColorForValue:tile.value];
      animationSpeed = 0;
    }
    [button setTitleColor:[self.game getTitleColorForValue:tile.value] forState:UIControlStateNormal];
    [UIView animateWithDuration:animationSpeed animations:^{
      button.backgroundColor = backgroundColor;
    }];
    [button setTitle:title forState:UIControlStateNormal];
    self.scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", self.game.score];
  }
}
@end
