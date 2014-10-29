//
//  DieLabel.m
//  Farkle
//
//  Created by May Yang on 10/29/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel


- (void)roll
{
    int randomNumber = arc4random_uniform(6)+1;
    [self.delegate dieValueRolled:randomNumber];
    
}


#pragma -mark BUTTONS

-(IBAction)onTapped:(UITapGestureRecognizer *)sender
{
//    UILabel *clickedLabel = sender.view;
//    NSLog(@"%ld", (long)clickedLabel.tag);

    
    
    //When Label is clicked, change background Color to Red
    sender.view.backgroundColor = [UIColor redColor];
    
    
}
@end
