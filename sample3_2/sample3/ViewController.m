//
//  ViewController.m
//  sample3
//
//  Created by Anton Lookin on 1/18/16.
//  Copyright © 2016 geekub. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    [self moveToRight];
}

- (void)moveToRight {
    CGRect rect = self.button.frame;
    rect.origin.x = self.view.bounds.size.width - self.button.bounds.size.width;
    [UIView beginAnimations:@"MoveToRight" context:nil];
    [UIView setAnimationDuration:3.4];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotateButton:finished:context:)];
    
    self.button.frame = rect;
    
    [UIView commitAnimations];
}

- (void) rotateButton:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [UIView beginAnimations:@"ButtonRotate" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    SEL selector;
    if ([animationID isEqualToString:@"MoveToRight"]) {
        selector = @selector(moveToDown);
    } else if ([animationID isEqualToString:@"MoveToDown"]) {
        selector = @selector(moveToLeft);
    } else if ([animationID isEqualToString:@"MoveToLeft"]) {
        selector = @selector(moveToUp);
    } else {
        selector = @selector(moveToRight);
    }
    [UIView setAnimationDidStopSelector: selector];
    
    self.button.transform = CGAffineTransformRotate(self.button.transform, M_PI);
    
    [UIView commitAnimations];
}

- (void)moveToDown {
    CGRect rect = self.button.frame;
    rect.origin.y = self.view.bounds.size.height - self.button.bounds.size.height;
    [UIView beginAnimations:@"MoveToDown" context:nil];
    [UIView setAnimationDuration:5.4];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotateButton:finished:context:)];
    
    self.button.frame = rect;
    
    [UIView commitAnimations];
}

- (void)moveToLeft {
    CGRect rect = self.button.frame;
    rect.origin.x = 0;
    [UIView beginAnimations:@"MoveToLeft" context:nil];
    [UIView setAnimationDuration:3.4];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotateButton:finished:context:)];
    
    self.button.frame = rect;
    
    [UIView commitAnimations];
}

- (void)moveToUp {
    CGRect rect = self.button.frame;
    rect.origin.y = 20;
    [UIView beginAnimations:@"MoveToUp" context:nil];
    [UIView setAnimationDuration:5.4];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotateButton:finished:context:)];
    
    self.button.frame = rect;
    
    [UIView commitAnimations];
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    if ([self.button.layer.presentationLayer hitTest:touchLocation]) {
        NSLog(@"Tap");
    }
}

@end
