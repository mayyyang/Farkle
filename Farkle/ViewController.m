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
@property DieLabel *myDie;
@property int dieValueReturned;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property NSMutableArray *countArray;

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labelCollection;
@property BOOL rollButtonPressed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rollButtonPressed = YES;
    for(DieLabel *label in self.labelCollection){
        label.delegate = self;
        label.backgroundColor = [UIColor greenColor];
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
        
        //now divide everything by three and multiply it by its value
        
    }
//    NSLog(@"hi");
//    for(NSNumber *number in self.countArray){
//        NSLog(@"%d", [number intValue]);
    NSLog(@"%@", self.countArray);
    }

- (void)increaseValue:(int)value{
    
    int initialNumber = [self.countArray[value] intValue];
    initialNumber++;
    NSNumber *newNumber = [NSNumber numberWithInteger:initialNumber];
    self.countArray[value] = newNumber;
//    NSLog(@"%@", newNumber);

    
}










@end
