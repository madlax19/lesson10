//
//  ViewController.m
//  sample5
//
//  Created by Anton Lookin on 1/18/16.
//  Copyright © 2016 geekub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *satellite;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	CABasicAnimation *animation = [CABasicAnimation animation];
	animation.keyPath = @"position.x";
	animation.fromValue = @77;
	animation.toValue = @455;
	animation.duration = 1;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;

	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(77.0f, 100.0f, 50.0f, 50.0f)];
	view.backgroundColor = [UIColor grayColor];
	[self.view addSubview:view];

	[view.layer addAnimation:animation forKey:@"basic"];
	view.layer.position = CGPointMake(455.0f, 100.0f);
	

	
	
	CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
	shakeAnimation.keyPath = @"position.x";
	shakeAnimation.values = @[ @0, @20, @-20, @20, @0 ];
	shakeAnimation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
	shakeAnimation.duration = 0.4;
	shakeAnimation.repeatCount = 5;
	shakeAnimation.additive = YES;
	
	[self.textField.layer addAnimation:shakeAnimation forKey:@"shake"];

	CGRect boundingRect = CGRectInset(self.satellite.bounds, -100.0f, -100.0f);
	
	CAKeyframeAnimation *orbitAnimation = [CAKeyframeAnimation animation];
	orbitAnimation.keyPath = @"position";
	orbitAnimation.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
	orbitAnimation.duration = 4;
	orbitAnimation.additive = YES;
	orbitAnimation.repeatCount = HUGE_VALF;
	orbitAnimation.calculationMode = kCAAnimationPaced;
	orbitAnimation.rotationMode = kCAAnimationRotateAuto;
	
	[self.satellite.layer addAnimation:orbitAnimation forKey:@"orbit"];

	
	CABasicAnimation *animation2 = [CABasicAnimation animation];
	animation2.keyPath = @"position.x";
	animation2.fromValue = @50;
	animation2.toValue = @300;
	animation2.duration = 1;
	
	animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	[view.layer addAnimation:animation2 forKey:@"basic"];
	
	view.layer.position = CGPointMake(300, 100);
}

@end
