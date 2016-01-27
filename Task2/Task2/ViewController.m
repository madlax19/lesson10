//
//  ViewController.m
//  Task2
//
//  Created by chublix on 1/27/16.
//  Copyright (c) 2016 Elena Chekhova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *squareCollision;
@property (nonatomic, strong) UICollisionBehavior *circleCollision;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc] init];
    [self.animator addBehavior:self.gravity];
    
    self.squareCollision = [[UICollisionBehavior alloc] init];
    self.squareCollision.collisionDelegate = self;
    self.squareCollision.translatesReferenceBoundsIntoBoundary = YES;
    
    self.circleCollision = [[UICollisionBehavior alloc] init];
    self.circleCollision.collisionDelegate = self;
    self.circleCollision.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:self.squareCollision];
    [self.animator addBehavior:self.circleCollision];
 }

- (void) addSquare:(CGFloat) x y:(CGFloat) y {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 40, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.4745 green:1.0 blue:0.9993 alpha:1.0];
    [self.view addSubview:view];
    [self.gravity addItem:view];
    [self.squareCollision addItem:view];
}

- (void) addCircle: (CGFloat) x y:(CGFloat) y {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 40, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.7092 green:0.3115 blue:0.3767 alpha:1.0];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 20;
    [self.view addSubview:view];
    [self.gravity addItem:view];
    [self.circleCollision addItem:view];
}

- (IBAction)longViewPress:(id)sender {
    UILongPressGestureRecognizer *gesture = sender;
    CGPoint location = [gesture locationInView:self.view];
    int shapeType = arc4random() % 2;
    if (shapeType == 0) {
        [self addSquare: location.x y: location.y];
    } else {
        [self addCircle:location.x y:location.y];
    }
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2 atPoint:(CGPoint)p {
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[item1, item2] mode:UIPushBehaviorModeInstantaneous];
    push.magnitude = M_PI / 2;
    push.angle = -M_PI / 2;
    [self.animator addBehavior:push];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.gravity.gravityDirection = CGVectorMake(0.0, 1.0);
    } else {
        self.gravity.gravityDirection = CGVectorMake(0.0, -1.0);
    }
}



@end
