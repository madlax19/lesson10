//
//  ViewController.m
//  sample3
//
//  Created by Anton Lookin on 1/18/16.
//  Copyright © 2016 geekub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    [self animateButtonFirst];
}

- (void)animateButtonFirst {
    CGRect rect = self.button.frame;
    rect.origin.x = self.view.bounds.size.width - self.button.bounds.size.width;
    [UIView beginAnimations:@"MoveToRight" context:nil];
    [UIView setAnimationDuration:3.4];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotateButtonFirst)];
    
    self.button.frame = rect;
    
    [UIView commitAnimations];
}

- (void) rotateButtonFirst {
    [UIView beginAnimations:@"ButtonRotateFirst" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateButtonSecond)];
    
    self.button.transform = CGAffineTransformRotate(self.button.transform, M_PI);
    
    [UIView commitAnimations];
}


- (void)animateButtonSecond {
    CGRect rect = self.button.frame;
    rect.origin.x = 0;
    [UIView beginAnimations:@"MoveToLeft" context:nil];
    [UIView setAnimationDuration:3.4];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotateButtonSecond)];
    
    self.button.frame = rect;
    
    [UIView commitAnimations];
}

- (void) rotateButtonSecond {
    [UIView beginAnimations:@"ButtonRotateSecond" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateButtonFirst)];
    
    self.button.transform = CGAffineTransformRotate(self.button.transform, M_PI);
    
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    if ([self.button.layer.presentationLayer hitTest:touchLocation]) {
        self.button.backgroundColor = [self randomColor];
        NSLog(@"Tap");
    }
}

- (UIColor*)randomColor {
    return [UIColor colorWithRed:(CGFloat)(arc4random() % 256) / 255.f
                           green:(CGFloat)(arc4random() % 255) / 255.f
                            blue:(CGFloat)(arc4random() % 255) / 255.f
                           alpha:1.0f];
}

@end
