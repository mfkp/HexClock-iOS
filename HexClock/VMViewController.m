//
//  VMViewController.m
//  HexClock
//
//  Created by Kyle on 6/19/14.
//  Copyright (c) 2014 VibraMedia. All rights reserved.
//

#import "VMViewController.h"
#import "UIColor+Expanded.h"

@implementation VMViewController

@synthesize hexText, animator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:hexText snapToPoint:self.view.center];
    snap.damping = 0.2;
    [animator addBehavior:snap];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [self timerTick:timer];
    
    [self performSelector:@selector(moveUp) withObject:nil afterDelay:3.0];
}

- (void)timerTick:(NSTimer *)timer {
    NSDate *now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HHmmss"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    NSString *hexString = [@"#" stringByAppendingString:newDateString];
    [self.view setBackgroundColor:[UIColor colorWithHexString:hexString]];
    hexText.text = hexString;
}

- (void)moveUp {
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = hexText.frame;
                         frame.origin.y -= 10.0;
                         hexText.frame = frame;
                     } completion:^(BOOL finished) {
                         [self moveDown];
                     }];
}

- (void)moveDown{
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = hexText.frame;
                         frame.origin.y += 10.0;
                         hexText.frame = frame;
                     } completion:^(BOOL finished) {
                         [self moveUp];
                     }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
