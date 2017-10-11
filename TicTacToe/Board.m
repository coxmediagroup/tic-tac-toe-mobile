//
//  Board.m
//  TicTacToe
//
//  Created by Alan on 10/9/17.
//  Copyright © 2017 CMG. All rights reserved.
//

#import "Board.h"

@interface Board ()

@property (strong, nonatomic) NSArray *board;

@end

@implementation Board

-(id)init
{
    self = [super init];
    if (self) {
        self.board = [[NSArray alloc] initWithObjects:@"X",@"1",@"X",@"X",@"O","O","O","7","O",nil];
        
    }
    return self;
}

-(void)getNextMove
{
    
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

@end
