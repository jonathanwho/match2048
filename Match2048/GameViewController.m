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
#define HIGHSCORE_KEY @"High Score Key"
#define SCORE_FORMAT @"SCORE: %d"
#define HIGHSCORE_FORMAT @"HIGHSCORE: %d"

@interface GameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tileButtons;
@property (weak, nonatomic) IBOutlet UIButton *startNewGameButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; 
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UIView *tileContainer;

// Game model.
@property (nonatomic, strong) TileMatchingGame *game;

// The device highscore.
@property (nonatomic) int highScore;

@end

@implementation GameViewController
- (IBAction)showHint {
  [self.game showHint];
  for (UIButton *button in self.tileButtons) {
    Tile *tile = [self.game tileAtIndex:[self.tileButtons indexOfObject:button]];
    UIColor *backgroundColor = [self.game getBackgroundColorForValue:tile.value];
    [UIView animateWithDuration:COLOR_ANIMATION_SPEED animations:^{
      button.backgroundColor = backgroundColor;
      if (!tile.isChosen)
        button.backgroundColor = self.game.defaultColor;
    }];
  }
  [self updateUI];
}

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
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  self.highScore = [defaults integerForKey:HIGHSCORE_KEY];
  [self.highScoreLabel setText:[NSString stringWithFormat:HIGHSCORE_FORMAT, self.highScore]];
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
  }
  
  self.scoreLabel.text = [NSString stringWithFormat:SCORE_FORMAT, self.game.score];
  if (self.game.isOver && (!self.highScore || self.game.score > self.highScore)) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.game.score forKey:HIGHSCORE_KEY];
    self.highScore = self.game.score;
    [self.highScoreLabel setText:[NSString stringWithFormat:HIGHSCORE_FORMAT, self.game.score]];
  }
}
@end
