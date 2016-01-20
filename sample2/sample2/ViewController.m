//
//  ViewController.m
//  sample2
//
//  Created by Anton Lookin on 1/18/16.
//  Copyright © 2016 geekub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor greenColor];

	// UIView Animation
	
	[UIView animateWithDuration:3.0f
						  delay:0.0f
						options:0ul
					 animations:^{
						self.view.backgroundColor = [UIColor redColor];
					 }
					 completion:^(BOOL finished) {
						 
					 }];

	UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
	view.tag = 1;
	view.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:view];
	[UIView animateWithDuration:3.0
						  delay:0.0
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^(void) {
						 view.alpha = 0.0;
					 }
					 completion:^(BOOL finished) {
						 if (finished) {
							 [view removeFromSuperview];
						 }
					 }];
	NSLog(@"alpha is %f", view.alpha);
	
	//	UIViewAnimationOptions
	//	BeginFromCurrentState - interrupt other, in-progress animations of these properties
	//	AllowUserInteraction - allow gestures to get processed while animation is in progress
	//	LayoutSubviews - animate the relayout of subviews along with a parent’s animation
	//	Repeat - repeat indefinitely
	//	Autoreverse - play animation forwards, then backwards
	//	OverrideInheritedDuration - if not set, use duration of any in-progress animation
	//	OverrideInheritedCurve - if not set, use curve (e.g. ease-in/out) of in-progress animation
	//	AllowAnimatedContent - if not set, just interpolate between current and end state image
	//	CurveEaseInEaseOut - slower at the beginning, normal throughout, then slow at end
	//	CurveEaseIn - slower at the beginning, but then constant through the rest
	//	CurveLinear - same speed throughout
}


-(void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	//	UIView transition
	
	UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
	view.tag = 1;
	view.backgroundColor = [UIColor brownColor];
	[self.view addSubview:view];
	
	
	UIView *toView = [[UIView alloc] initWithFrame:self.view.bounds];
	toView.tag = 2;
	toView.backgroundColor = [UIColor blueColor];
	
//	[UIView transitionWithView:self.view
//					  duration:0.5f
//					   options:UIViewAnimationOptionTransitionCurlUp
//					animations:^(void) {
//						[view removeFromSuperview];
//						[self.view addSubview:toView];
//					}
//					completion:NULL];
	
	[UIView transitionFromView:view
						toView:toView
					  duration:0.5f
					   options:UIViewAnimationOptionTransitionCrossDissolve
					completion:NULL];
}


@end
