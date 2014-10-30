//
//  ViewController.m
//  Farkle
//
//  Created by May Yang on 10/29/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>
@property int dieValueReturned;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property NSMutableArray *countArray;
@property NSArray *multiplierArray;
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labelCollection;
@property BOOL rollButtonPressed;
@property (weak, nonatomic) IBOutlet UILabel *playerTurn;
@property (weak, nonatomic) IBOutlet UILabel *userScore2;
@property int playerScore;
@property int playerTwoScore;
@property BOOL playerOneTurn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerOneTurn = YES;
    self.rollButtonPressed = YES;
    self.multiplierArray = @[@1000, @200, @300, @400, @500, @600];
    for(DieLabel *label in self.labelCollection){
        label.delegate = self;
        label.backgroundColor = [UIColor greenColor];
        label.pressedOnce = NO;
        label.heldMoreThanOnce = NO;
    }
    //    [self.myDie roll];
    //    int randomNumber = arc4random_uniform(6)+1;
    //    for(DieLabel *label in self.labelCollection){
    //
    //        label.text = [NSString stringWithFormat:@"%d", randomNumber];
    //    }
    
    
}

- (void)dieValueRolled:(int)value{
    
    self.dieValueReturned = value;
    
}
- (IBAction)onRollButtonPressed:(id)sender {
    if(self.rollButtonPressed){
        for(DieLabel *label in self.labelCollection)
        {
            [label roll];
            label.text = [NSString stringWithFormat:@"%d", self.dieValueReturned];
        }
        
        self.rollButtonPressed = NO;
    }
    
    for(DieLabel *label in self.labelCollection){
        
        if(label.backgroundColor == [UIColor greenColor]){
            [label roll];
            label.text = [NSString stringWithFormat:@"%d", self.dieValueReturned];
            label.pressedOnce = YES;
        }
    }
}

- (IBAction)bankScoreButton:(UIButton *)sender {
    //How to score after Bank Score Button has been pressed.
    self.countArray = [@[] mutableCopy];
    for(int i=0; i<6; i++)
        [self.countArray addObject:[NSNumber numberWithInteger:0]];
    //if there are 3 1's
    for(DieLabel *label in self.labelCollection)
    {
        if(label.backgroundColor == [UIColor redColor] && label.heldMoreThanOnce == NO){
            if([label.text isEqualToString: @"1"]){
                [self increaseValue:0];
            }
            if([label.text isEqualToString: @"2"]){
                [self increaseValue:1];
            }
            if([label.text isEqualToString: @"3"]){
                [self increaseValue:2];
            }
            if([label.text isEqualToString: @"4"]){
                [self increaseValue:3];
            }
            if([label.text isEqualToString: @"5"]){
                [self increaseValue:4];
            }
            if([label.text isEqualToString: @"6"]){
                [self increaseValue:5];
            }
            label.heldMoreThanOnce = YES;
        }
        //now divide everything by three and multiply it by its value
        
    }
    int finalValue = 0;
    int checkValue = 0;
    
    
    
    for(int i=0; i<6; i++){
        
        int initialValue = [self.countArray[i] intValue];
        int multiplierValue = [self.multiplierArray[i] intValue];
        int valuePerNumber = initialValue / 3 * multiplierValue;
        if(initialValue/3 > 0)
            checkValue++;
        if(initialValue/6 > 0)
            checkValue++;
        if(i==0 || i==4){
            if(initialValue/6 != 1 && initialValue%3 != 0){
                int individualValue = initialValue % 3;
                if(i==0)
                    finalValue = finalValue + individualValue * 100;
                if(i==4)
                    finalValue = finalValue + individualValue * 50;
            }
            
        }
        finalValue = valuePerNumber + finalValue;
        
        
        if([self.countArray isEqualToArray: @[@1, @1, @1 , @1, @1 ,@1]])
            finalValue = 1000;
        
        
    }
    
    if(self.playerOneTurn)
        self.playerScore = self.playerScore + finalValue;
    
    if(!self.playerOneTurn)
        self.playerTwoScore = self.playerTwoScore + finalValue;
    
    self.playerTurn.text = [NSString stringWithFormat:@"%d",self.playerScore];
    self.userScore.text = [NSString stringWithFormat:@"%d", finalValue];
    if(finalValue == 0){
        NSLog(@"FARKLEEEE!"); //TURN OVER
//        [self resetAllValues];
//        self.playerOneTurn = NO;
//    }
//    if(checkValue == 2){
        NSLog(@"Hot streak!");
//        [self resetAllValues];
//    }//RESTART TURN
    //    NSLog(@"hi");
    //    for(NSNumber *number in self.countArray){
    //        NSLog(@"%d", [number intValue]);
    NSLog(@"%@", self.countArray);
}
}

- (void)increaseValue:(int)value{
    
    int initialNumber = [self.countArray[value] intValue];
    initialNumber++;
    NSNumber *newNumber = [NSNumber numberWithInteger:initialNumber];
    self.countArray[value] = newNumber;
    //    NSLog(@"%@", newNumber);
    
    
}

- (void)resetAllValues{

    for(DieLabel *label in self.labelCollection){
    
        label.backgroundColor = [UIColor greenColor];
        label.pressedOnce = NO;
        label.heldMoreThanOnce = NO;
    }

}









@end
