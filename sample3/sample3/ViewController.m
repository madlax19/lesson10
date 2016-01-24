//
//  ViewController.m
//  sample3
//
//  Created by Anton Lookin on 1/18/16.
//  Copyright © 2016 geekub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    [self animateButtonFirst];
}

- (void)animateButtonFirst {
    self.constraint.constant = self.view.bounds.size.width - self.button.bounds.size.width;
    [UIView animateWithDuration:3.4f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.button.transform = CGAffineTransformRotate(self.button.transform, M_PI);
                         } completion:^(BOOL finished) {
                             [self animateButtonSecond];
                         }];
                     }];
}

- (void)animateButtonSecond {
    self.constraint.constant = 0;
    [UIView animateWithDuration:3.4f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.button.transform = CGAffineTransformRotate(self.button.transform, M_PI);
                         } completion:^(BOOL finished) {
                             [self animateButtonFirst];
                         }];
                     }];
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
