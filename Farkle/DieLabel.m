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
    
}


#pragma -mark BUTTONS

-(IBAction)onTapped:(UITapGestureRecognizer *)sender
{
    UILabel *clickedLabel = sender.view;
    NSLog(@"%ld", (long)clickedLabel.tag);
    
}
@end
