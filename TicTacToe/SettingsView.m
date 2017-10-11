//
//  SettingsView.m
//  TicTacToe
//
//  Created by Alan on 10/10/17.
//  Copyright © 2017 CMG. All rights reserved.
//
//
//  Note:  I could have created this view using Interface Builder, but for this project I chose to do it all programmatically.  Either option is fine with me.

#import "SettingsView.h"

@interface SettingsView ()

@property (nonatomic, strong) UIButton *xButton;
@property (nonatomic, strong) UIButton *oButton;

@end

@implementation SettingsView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        /*
        self.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
         */
        
        // Add background image
        UIImage *boardBackgroundImage = [UIImage imageNamed:@"settingsBackground"];
        UIImageView *imageView = [[UIImageView alloc] init];
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        imageView.frame = frame;
        [imageView setImage:boardBackgroundImage];
        [self addSubview:imageView];

        self.letterSelection = @"X";  // Default to X
        [self addOptions];
    }
    return self;
}

-(void)addOptions
{
    // Add X Select button
    self.xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.xButton addTarget:self action:@selector(selectX:) forControlEvents:UIControlEventTouchUpInside];
    [self.xButton setTitle:@"X" forState:UIControlStateNormal];
    self.xButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:40];
    self.xButton.frame = CGRectMake(self.frame.size.width/2-90, 70, 80, 80);
    self.xButton.layer.cornerRadius = 10;
    self.xButton.clipsToBounds = YES;
    self.xButton.layer.borderWidth = 7;
    [self.xButton setBackgroundColor:[UIColor darkGrayColor]];
    self.xButton.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor;
    [self addSubview:self.xButton];
    
    // Add O Select button
    self.oButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.oButton addTarget:self action:@selector(selectO:) forControlEvents:UIControlEventTouchUpInside];
    [self.oButton setTitle:@"O" forState:UIControlStateNormal];
    self.oButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:40];
    self.oButton.frame = CGRectMake(self.frame.size.width/2+10, 70, 80, 80);
    self.oButton.layer.cornerRadius = 10;
    self.oButton.layer.borderWidth = 7;
    self.oButton.clipsToBounds = YES;
    [self.oButton setBackgroundColor:[UIColor darkGrayColor]];
    self.oButton.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0].CGColor;
    [self addSubview:self.oButton];
    
    // Add Start button
    UIButton *newGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newGameButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    newGameButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    newGameButton.frame = CGRectMake(self.frame.size.width/2-75, 200, 150, 50);
    newGameButton.layer.cornerRadius = 20;
    newGameButton.clipsToBounds = YES;
    [newGameButton setBackgroundColor:[UIColor darkGrayColor]];
    [self addSubview:newGameButton];
   
    // Add labels
    UILabel *letterLabel = [[UILabel alloc] init];
    letterLabel.textAlignment = NSTextAlignmentCenter;
    letterLabel.textColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    letterLabel.text = @"First Move";
    letterLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    letterLabel.frame = CGRectMake(self.frame.size.width/2-100, 35, 200, 20);
    [self addSubview:letterLabel];
}

- (void)selectX:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor;
    self.oButton.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0].CGColor;
    self.letterSelection = @"X";
}

- (void)selectO:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor;
    self.xButton.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0].CGColor;
    self.letterSelection = @"O";
}

- (void)start:(id)sender
{
    [UIView animateWithDuration:0.25f animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height*2, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startGame" object:nil];
        [self removeFromSuperview];
    }];

}

@end
