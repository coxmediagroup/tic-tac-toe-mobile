//
//  ViewController.m
//  TicTacToe
//
//  Created by Alan on 10/9/17.
//  Copyright © 2017 CMG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) int gameState;
@property (strong, nonatomic) NSString *humanPlayer;
@property (strong, nonatomic) NSString *aiPlayer;
@property (strong, nonatomic) NSString *currentPlayer;
@property (strong, nonatomic) NSMutableArray *board;
@property (assign, nonatomic) int bestScore;
@property (assign, nonatomic) int bestMove;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPlayer = @"X";

    self.aiPlayer = @"O";
    self.humanPlayer = @"O";
    self.board = [[NSMutableArray alloc] initWithObjects:@"X",@"X",@"O",@"O",@"O",@"X",@"X",@"7",@"8",nil];
    self.bestScore = -1;
    self.bestMove = -1;
    
    self.bestMove = [self findBestMove];
    NSLog(@"Best Move:%d",self.bestMove);
}

-(int)findBestMove
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

-(int)miniMax:(NSMutableArray *)board maximizingPlayer:(BOOL)maximizingPlayer
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

-(NSArray *)getEmptySpaces:(NSArray *)board
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

-(BOOL)winningMove:(NSArray *)board value:(NSString *)value
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
