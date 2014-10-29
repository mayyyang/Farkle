//
//  ViewController.m
//  Farkle
//
//  Created by May Yang on 10/29/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController ()
@property DieLabel *myDie;

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labelCollection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myDie roll];
    int randomNumber = arc4random_uniform(6)+1;

}


@end
