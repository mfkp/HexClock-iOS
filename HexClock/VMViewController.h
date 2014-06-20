//
//  VMViewController.h
//  HexClock
//
//  Created by Kyle on 6/19/14.
//  Copyright (c) 2014 VibraMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VMViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *hexText;
@property (nonatomic) UIDynamicAnimator *animator;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
