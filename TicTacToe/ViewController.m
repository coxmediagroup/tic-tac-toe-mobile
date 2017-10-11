//
//  ViewController.m
//  TicTacToe
//
//  Created by Alan on 10/9/17.
//  Copyright © 2017 CMG. All rights reserved.
//
//  Note:  I could have created this view using Interface Builder, but for this project I chose to do it all programmatically.  Either option is fine with me.

#import "ViewController.h"
#import "SettingsView.h"

@interface ViewController ()

@property (assign, nonatomic) int gameState;
@property (strong, nonatomic) NSString *humanPlayer;
@property (strong, nonatomic) NSString *aiPlayer;
@property (strong, nonatomic) NSMutableArray *board;
@property (assign, nonatomic) int bestScore;
@property (assign, nonatomic) int bestMove;
@property (strong, nonatomic) SettingsView *settings;
@property (strong, nonatomic) NSMutableArray *selectionButtonsArray;
@property (strong, nonatomic) UIButton *repeatButton;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIColor *humanColor;
@property (strong, nonatomic) UIColor *aiColor;
@property (assign, nonatomic) BOOL playerTurn;
@property (strong, nonatomic) UILabel *endOfGameLabel;
@property (strong, nonatomic) UIImageView *winLineImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectionButtonsArray = [[NSMutableArray alloc] init];
    self.humanColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    self.aiColor = [UIColor blackColor];
    self.playerTurn = YES;
    self.gameState = 1; // Active
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startGame)
                                                 name:@"startGame"
                                               object:nil];

    [self preparePlayBoard];
    
    [self displaySettings];
}

- (void)startGame
{
    self.playerTurn = YES;
    self.gameState = 1; // Active
    self.humanPlayer = self.settings.letterSelection;
    self.endOfGameLabel.text = @"";
    if ([self.humanPlayer isEqualToString:@"X"]) self.aiPlayer = @"O";
    else self.aiPlayer = @"X";
    
    // Display user letter selections at top
    self.board = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",nil];
    
    // Reset board values
    for (UIButton *button in self.selectionButtonsArray) {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    
    // Remove line
    [self.winLineImageView removeFromSuperview];
}

- (void)displaySettings
{
    if (self.gameState == 0) return;
    
    // Initialize the window
    self.gameState = 0;
    int width = 300;
    int height = 300;
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-width/2, [UIScreen mainScreen].bounds.size.height+height, width, height);
    self.settings = [[SettingsView alloc] initWithFrame:frame];
    [self.view addSubview:self.settings];
    
    // Animate the window from the bottom
    [UIView animateWithDuration:0.5f animations:^{
        self.settings.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-width/2, [UIScreen mainScreen].bounds.size.height/2-height/2-10, width, height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            self.settings.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-width/2, [UIScreen mainScreen].bounds.size.height/2-height/2+10, width, height);
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)preparePlayBoard
{
    // Add the board background
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    CGRect backgroundFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    backgroundImageView.frame = backgroundFrame;
    [backgroundImageView setImage:backgroundImage];
    [self.view addSubview:backgroundImageView];

    // Add the background image
    UIImage *boardBackgroundImage = [UIImage imageNamed:@"boardBackground"];
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, [UIScreen mainScreen].bounds.size.height/2-140, 300, 300);
    imageView.frame = frame;
    [imageView setImage:boardBackgroundImage];
    [self.view addSubview:imageView];

    // Add play buttons
    float x = [UIScreen mainScreen].bounds.size.width/2 - 130;
    float y = [UIScreen mainScreen].bounds.size.height/2 - 115;
    for (int i=0; i<9; i++) {
        if ((i==3) || (i==6)) {
            x = [UIScreen mainScreen].bounds.size.width/2 - 130;
            y += 90;
        }
        [self addButton:self.selectionButtonsArray selector:@selector(playerSelection:) x:x y:y title:@"" tag:i];
        x += 90;
    }
    
    // Add control buttons
    
    // Add Back button
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton addTarget:self action:@selector(displaySettings) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:40];
    self.backButton.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height-100, 80, 80);
    [self.view addSubview:self.backButton];

    UIImage *backButtonImage = [UIImage imageNamed:@"backButton"];
    [self.backButton setImage:backButtonImage forState:UIControlStateNormal];
    
    // Add Repeat button
    self.repeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.repeatButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    self.repeatButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-110, [UIScreen mainScreen].bounds.size.height-100, 80, 80);
    [self.view addSubview:self.repeatButton];
    
    UIImage *repeatButtonImage = [UIImage imageNamed:@"repeatButton"];
    [self.repeatButton setImage:repeatButtonImage forState:UIControlStateNormal];
    
    
    // Add end of game label
    self.endOfGameLabel = [[UILabel alloc] init];
    self.endOfGameLabel.textAlignment = NSTextAlignmentCenter;
    self.endOfGameLabel.textColor = [UIColor colorWithRed:250.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.endOfGameLabel.text = @"";
    self.endOfGameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:50];
    self.endOfGameLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, [UIScreen mainScreen].bounds.size.height/2-200, 300, 40);
    [self.view addSubview:self.endOfGameLabel];
}

- (void)addButton:(NSMutableArray *)buttonArray
         selector:(SEL)selector
                x:(int)x
                y:(int)y
            title:(NSString *)title
              tag:(int)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:92];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(x, y, 80.0, 80.0);
    [self.view addSubview:button];
    [buttonArray addObject:button];
    button.tag = tag;
}

- (void)playerSelection:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!self.playerTurn) return;
    
    // First, check whether it is eligible
    BOOL eligible = [self elegibleMove:(int)button.tag];
    if (eligible) {
        [button setTitleColor:self.humanColor forState:UIControlStateNormal];
        [button setTitle:self.humanPlayer forState:UIControlStateNormal];
        [self.board replaceObjectAtIndex:button.tag withObject:self.humanPlayer];
    }
    else {
        NSLog(@"Not eligible");
        return;
    }
    
    // After each user selection, check for a win or tie
    if ([self winningMove:self.board value:self.humanPlayer displayLine:YES]) {
        NSLog(@"Player won.  Though technically it's not possible against the AI");
        [self displayEndOfGame:@"You Won!"];
    }
    
    else if ([self getEmptySpaces:self.board].count > 0) {
    
        // Make AI move (retrieve button and update display value and array) - Delay it by a little so that it doesn't feel so creepy
        self.playerTurn = NO;
        double delayInSeconds = .5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            int bestAIMove = [self findBestMove];
            UIButton *aiButton = [self.selectionButtonsArray objectAtIndex:bestAIMove];
            [aiButton setTitleColor:self.aiColor forState:UIControlStateNormal];
            [aiButton setTitle:self.aiPlayer forState:UIControlStateNormal];
            [self.board replaceObjectAtIndex:bestAIMove withObject:self.aiPlayer];
            NSLog(@"Board after move:%@",self.board);
            
            if ([self winningMove:self.board value:self.aiPlayer displayLine:YES]) {
                NSLog(@"AI won!");
                [self displayEndOfGame:@"You Lost!"];
            }
            else {
                self.playerTurn = YES;
            }
        });
    }
    else {
        NSLog(@"It's a tie");
        [self displayEndOfGame:@"It's a tie!"];
    }
}

- (void)displayEndOfGame:(NSString *)str
{
    self.endOfGameLabel.text = str;
}

- (int)findBestMove
{
    int bestMove = -1;
    int bestScore = -10000;
    NSArray *emptySpaces = [self getEmptySpaces:self.board];
    for (int i=0; i<emptySpaces.count; i++) {
        NSNumber *index = [emptySpaces objectAtIndex:i];
        self.board[index.integerValue] = self.aiPlayer;
        
        int score = [self miniMax:self.board maximizingPlayer:NO];
        if (score > bestScore) {
            bestMove = (int)index.integerValue;
            bestScore = score;
        }
        
        // Undo move
        self.board[index.integerValue] = [NSString stringWithFormat:@"%ld",(long)index.integerValue];
    }
    NSLog(@"Board before move:%@",self.board);
    return bestMove;
}

- (int)miniMax:(NSMutableArray *)board maximizingPlayer:(BOOL)maximizingPlayer
{
    // Using MiniMax algorithm
    
    int score = 0;
    
    // First, retrieve all empty spaces
    NSArray *emptySpaces = [self getEmptySpaces:board];
    
    // See if it is a winning move
    if ([self winningMove:board value:self.aiPlayer displayLine:NO]) {
        return score = 100;
    }
    // See if it is a losing move
    else if ([self winningMove:board value:self.humanPlayer displayLine:NO]) {
        return score = -100;
    }
    // If no empty spaces, there are no moves left and game is over (it is a draw)
    else if (emptySpaces.count == 0) {
        return score = 0;
    }
    
    // Alternate player turns
    if (maximizingPlayer) {
        
        int bestScore = -10000;
        
        // Loop through all empty spaces testing every option
        for (int i=0; i<emptySpaces.count; i++) {
            NSNumber *index = [emptySpaces objectAtIndex:i];
            board[index.integerValue] = self.aiPlayer;

            int score = [self miniMax:board maximizingPlayer:!maximizingPlayer];
            bestScore = MAX(bestScore,score);
            
            // Undo move
            board[index.integerValue] = [NSString stringWithFormat:@"%ld",(long)index.integerValue];
        }
        return bestScore;
    }
    else {
        
        int bestScore = 10000;
        
        // Loop through all empty spaces testing every option
        for (int i=0; i<emptySpaces.count; i++) {
            NSNumber *index = [emptySpaces objectAtIndex:i];
            board[index.integerValue] = self.humanPlayer;

            int score = [self miniMax:board maximizingPlayer:!maximizingPlayer];
            bestScore = MIN(bestScore,score);
            
            // Undo move
            board[index.integerValue] = [NSString stringWithFormat:@"%ld",(long)index.integerValue];
        }
        return bestScore;
    }

    return score;
}

- (BOOL)elegibleMove:(int)move
{
    NSString *moveLocation = [self.board objectAtIndex:move];
    if ((![moveLocation isEqualToString:@"X"]) && (![moveLocation isEqualToString:@"O"])) {
        return YES;
    }
    return NO;
}

- (NSArray *)getEmptySpaces:(NSArray *)board
{
    NSMutableArray *emptySpaces = [[NSMutableArray alloc] init];
    int cnt = 0;
    for (NSString *value in board) {
        if ((![value isEqualToString:@"X"]) && (![value isEqualToString:@"O"])) {
            [emptySpaces addObject:[NSNumber numberWithInt:cnt]];
        }
        cnt++;
    }
    return (NSArray *)emptySpaces;
}

- (BOOL)winningMove:(NSArray *)board value:(NSString *)value displayLine:(BOOL)displayLine
{
    if (([board[0] isEqualToString:value]) && ([board[1] isEqualToString:value]) && ([board[2] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:1 x:[UIScreen mainScreen].bounds.size.width/2 y:[UIScreen mainScreen].bounds.size.height/2-75];
        }
        return YES;
    }
    else if (([board[3] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[5] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:1 x:[UIScreen mainScreen].bounds.size.width/2 y:[UIScreen mainScreen].bounds.size.height/2+15];
        }
        return YES;
    }
    else if (([board[6] isEqualToString:value]) && ([board[7] isEqualToString:value]) && ([board[8] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:1 x:[UIScreen mainScreen].bounds.size.width/2 y:[UIScreen mainScreen].bounds.size.height/2+100];
        }
        return YES;
    }
    else if (([board[0] isEqualToString:value]) && ([board[3] isEqualToString:value]) && ([board[6] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:2 x:[UIScreen mainScreen].bounds.size.width/2-90 y:[UIScreen mainScreen].bounds.size.height/2+15];
        }
        return YES;
    }
    else if (([board[1] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[7] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:2 x:[UIScreen mainScreen].bounds.size.width/2 y:[UIScreen mainScreen].bounds.size.height/2+15];
        }
        return YES;
    }
    else if (([board[2] isEqualToString:value]) && ([board[5] isEqualToString:value]) && ([board[8] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:2 x:[UIScreen mainScreen].bounds.size.width/2+90 y:[UIScreen mainScreen].bounds.size.height/2+15];
        }
        return YES;
    }
    else if (([board[0] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[8] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:3 x:[UIScreen mainScreen].bounds.size.width/2 y:[UIScreen mainScreen].bounds.size.height/2+15];
        }
        return YES;
    }
    else if (([board[2] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[6] isEqualToString:value])) {
        if (displayLine) {
            [self displayWinLine:4 x:[UIScreen mainScreen].bounds.size.width/2 y:[UIScreen mainScreen].bounds.size.height/2+15];
        }
        return YES;
    }
    
    return NO;
}

- (void)displayWinLine:(int)type x:(int)x y:(int)y
{
    NSString *imageStr;
    switch (type)
    {
        case 1:
            imageStr = @"horizontalLine";
            break;
        case 2:
            imageStr = @"verticalLine";
            break;
        case 3:
            imageStr = @"slantLineDown";
            break;
        case 4:
            imageStr = @"slantLineUp";
            break;
        default:
            imageStr = @"horizontalLine";
            break;
    }

    UIImage *winLineImage = [UIImage imageNamed:imageStr];
    self.winLineImageView = [[UIImageView alloc] init];
    CGRect frame = CGRectMake(x-130, y-130, 260, 260);
    self.winLineImageView.frame = frame;
    [self.winLineImageView setImage:winLineImage];
    self.winLineImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.winLineImageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
