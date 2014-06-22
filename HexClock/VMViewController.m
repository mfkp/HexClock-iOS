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

@synthesize hexText, outputFormatter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HHmmss"];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [hexText addGestureRecognizer:recognizer];
    hexText.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^() {
                         hexText.center = [self getRotatedCenter];
                     }
                     completion:nil];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [self timerTick:timer];

}

- (void)timerTick:(NSTimer *)timer {
    NSDate *now = [NSDate date];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    NSString *hexString = [@"#" stringByAppendingString:newDateString];
    self.view.backgroundColor = [UIColor colorWithHexString:hexString];
    hexText.text = hexString;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.7
                              delay:0.0
             usingSpringWithDamping:0.3
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:^() {
                             recognizer.view.center = [self getRotatedCenter];
                         }
                         completion:nil];
    }
}

- (CGPoint)getRotatedCenter {
    CGRect screen = [[UIScreen mainScreen] bounds];
    float pos_y, pos_x;
    pos_y = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? screen.size.width/2  : screen.size.height/2;
    pos_x = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? screen.size.height/2 : screen.size.width/2;
    
    return CGPointMake(pos_x, pos_y);
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
