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
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UILabel *farkleLabel;
@property (weak, nonatomic) IBOutlet UIButton *bankButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerOneTurn = YES;
    self.rollButtonPressed = YES;
    self.bankButton.enabled = NO;
    self.multiplierArray = @[@1000, @200, @300, @400, @500, @600];
    for(DieLabel *label in self.labelCollection){
        label.delegate = self;
        label.backgroundColor = [UIColor greenColor];
        label.pressedOnce = NO;
        label.heldMoreThanOnce = NO;
        label.userInteractionEnabled = NO;
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
- (IBAction)onRollButtonPressed:(UIButton *)sender {

    for(DieLabel *label in self.labelCollection){
        label.userInteractionEnabled = YES;
    }


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
    sender.enabled = NO;
    self.bankButton.enabled = YES;
}

- (IBAction)bankScoreButton:(UIButton *)sender {
    self.rollButton.enabled = YES;
    self.bankButton.enabled = NO;
    for(DieLabel *label in self.labelCollection){
        label.userInteractionEnabled = NO;
    }
    BOOL allRed = NO;
    //How to score after Bank Score Button has been pressed.
    self.countArray = [@[] mutableCopy];
    for(int i=0; i<6; i++)
        [self.countArray addObject:[NSNumber numberWithInteger:0]];
    //if there are 3 1's
    for(DieLabel *label in self.labelCollection){
        if(label.backgroundColor == [UIColor greenColor]){
            allRed = NO;
            break;
        }
        else{allRed = YES;}
    }
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
    
    self.playerTurn.text = [NSString stringWithFormat:@"Player 1 Score: %d",self.playerScore];
    self.userScore.text = [NSString stringWithFormat:@"Turn Score: %d", finalValue];
    self.userScore2.text = [NSString stringWithFormat:@"Player 2 Score: %d", self.playerTwoScore];
    
    
    if(finalValue == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FARKLEEEEEEE" message:@"Your move is over." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        self.farkleLabel.text = @"FARKLEEEEED";
        NSLog(@"FARKLEEEE!"); //TURN OVER
        [self resetAllValues];
        self.playerOneTurn = !self.playerOneTurn;
    }
    if(checkValue == 2){
        NSLog(@"Hot streak!");
        [self resetAllValues];
    }//RESTART TURN
    NSLog(@"hi");
    for(NSNumber *number in self.countArray){
        NSLog(@"%d", [number intValue]);
        NSLog(@"%@", self.countArray);
    }

    if(allRed && finalValue != 0){        [self resetAllValues];
        self.playerOneTurn = !self.playerOneTurn;
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
    self.bankButton.enabled = NO;
    self.rollButton.enabled = YES;
    self.farkleLabel.text =@"::::::::::::";
    for(DieLabel *label in self.labelCollection){
//        int random = arc4random_uniform(6)+1;
        [self rollButtonPressed];
        label.userInteractionEnabled = NO;
        label.backgroundColor = [UIColor greenColor];
        label.pressedOnce = NO;
        label.heldMoreThanOnce = NO;
        label.text = [NSString stringWithFormat:@"-"];
    }

}









@end
