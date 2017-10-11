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
@property (strong, nonatomic) NSString *currentPlayer;
@property (strong, nonatomic) NSMutableArray *board;
@property (assign, nonatomic) int bestScore;
@property (assign, nonatomic) int bestMove;
@property (strong, nonatomic) SettingsView *settings;
@property (strong, nonatomic) NSMutableArray *selectionButtonsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectionButtonsArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startGame)
                                                 name:@"startGame"
                                               object:nil];

    [self preparePlayBoard];
    
    [self displaySettings];
    /*
    self.currentPlayer = @"X";

    self.aiPlayer = @"O";
    self.humanPlayer = @"O";
    self.board = [[NSMutableArray alloc] initWithObjects:@"X",@"X",@"O",@"O",@"O",@"X",@"X",@"7",@"8",nil];
    self.bestScore = -1;
    self.bestMove = -1;
    
    self.bestMove = [self findBestMove];
    NSLog(@"Best Move:%d",self.bestMove);
     */
}

- (void)startGame
{
    // Display user letter selections at top
}

- (void)displaySettings
{
    // Initialize the window
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
    for (int i=0; i<9; i++) {
        [self addButton:self.selectionButtonsArray selector:@selector(selectCategoryButton:) x:100 y:100 title:@"X" tag:i];
    }
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
    button.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    button.frame = CGRectMake(x, y, 50.0, 50.0);
    [button setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:button];
    [buttonArray addObject:button];
    button.tag = tag;
}

- (int)findBestMove
{
    int bestScore = -10000;
    NSArray *emptySpaces = [self getEmptySpaces:self.board];
    for (int i=0; i<emptySpaces.count; i++) {
        NSNumber *index = [emptySpaces objectAtIndex:i];
        self.board[index.integerValue] = self.aiPlayer;
        
        int score = [self miniMax:self.board maximizingPlayer:NO];
        if (score > bestScore) {
            self.bestMove = (int)index.integerValue;
            bestScore = score;
        }
        
        // Undo move
        self.board[index.integerValue] = [NSString stringWithFormat:@"%ld",(long)index.integerValue];
    }
    
    //    int score = [self miniMax:self.board currentPlayer:self.aiPlayer];
    
    NSLog(@"Board before move:%@",self.board);
    //    [self applyMove:self.bestMove currentPlayer:self.aiPlayer];
    return self.bestMove;
}

- (int)miniMax:(NSMutableArray *)board maximizingPlayer:(BOOL)maximizingPlayer
{
    // Using MiniMax algorithm
    
    int score = 0;
    
    // First, retrieve all empty spaces
    NSArray *emptySpaces = [self getEmptySpaces:board];
    
    // If no empty spaces, there are no moves left and game is over (it is a draw)
    if (emptySpaces.count == 0) {
        return score = 0;
    }
    // See if it is a winning move
    else if ([self winningMove:board value:self.aiPlayer]) {
        return score = 100;
    }
    // See if it is a losing move
    else if ([self winningMove:board value:self.humanPlayer]) {
        return score = -100;
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

- (BOOL)winningMove:(NSArray *)board value:(NSString *)value
{
    if (([board[0] isEqualToString:value]) && ([board[1] isEqualToString:value]) && ([board[2] isEqualToString:value])) return YES;
    else if (([board[3] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[5] isEqualToString:value])) return YES;
    else if (([board[6] isEqualToString:value]) && ([board[7] isEqualToString:value]) && ([board[8] isEqualToString:value])) return YES;
    else if (([board[0] isEqualToString:value]) && ([board[3] isEqualToString:value]) && ([board[6] isEqualToString:value])) return YES;
    else if (([board[1] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[7] isEqualToString:value])) return YES;
    else if (([board[2] isEqualToString:value]) && ([board[5] isEqualToString:value]) && ([board[8] isEqualToString:value])) return YES;
    else if (([board[0] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[8] isEqualToString:value])) return YES;
    else if (([board[2] isEqualToString:value]) && ([board[4] isEqualToString:value]) && ([board[6] isEqualToString:value])) return YES;
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
