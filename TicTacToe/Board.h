//
//  Board.h
//  TicTacToe
//
//  Created by Alan on 10/9/17.
//  Copyright © 2017 CMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Board : NSObject

-(NSArray *)getEmptySpaces:(NSArray *)board;
-(BOOL)winningMove:(NSArray *)board value:(NSString *)value;

@end
