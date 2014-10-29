//
//  DieLabel.h
//  Farkle
//
//  Created by May Yang on 10/29/14.
//  Copyright (c) 2014 May Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate <NSObject>

- (void)dieValueRolled:(int)value;

@end

@interface DieLabel : UILabel
@property id <DieLabelDelegate> delegate;


- (void)roll;

@end
