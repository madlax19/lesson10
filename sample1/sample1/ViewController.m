//
//  ViewController.m
//  sample1
//
//  Created by Anton Lookin on 1/18/16.
//  Copyright © 2016 geekub. All rights reserved.
//

#import "ViewController.h"

typedef double (^unary_double_operation_t)(double operand);

@interface ViewController ()

@property (nonatomic, strong) NSMutableDictionary *unaryOperations;
@property (nonatomic, strong) NSMutableArray *myBlocks;
@property (nonatomic, copy) unary_double_operation_t myblock;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSDictionary *dictionary = @{@"1" : @"one",
								 @"2" : @"two",
								 @"3" : @"three",
								 @"4" : @"four",
								 @"5" : @"five",
								 @"stop" : @"hammer time",
								 @"6" : @6.0f,
								 @"7" : @7,
								 @"8" : @"eight",
								 @"9" : @"nine"};
	
	[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		NSLog(@"value for key %@ is %@", key, value);
		if ([@"stop" isEqualToString:key]) {
			*stop = YES;
		}
	}];

	NSLog(@"---------------------------------------------------");
	
	{
		float stopValue = 6.0f;
		[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
			NSLog(@"value for key %@ is %@", key, value);
			if ([value doubleValue] == stopValue) {
				*stop = YES;
			}
			//	Can't touch this
			//	stopValue = 7;
		}];
		NSLog(@"---------------------------------------------------");
	}
	
	{
		__block BOOL stoppedEarlier = NO;
		[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
			NSLog(@"value for key %@ is %@", key, value);
			if ([key isEqualToString:@"stop"]) {
				*stop = YES;
				stoppedEarlier = YES;
			}
		}];
		if (stoppedEarlier) {
			NSLog(@"Enumeration stopped earlier");
		}
		NSLog(@"---------------------------------------------------");
	}
	
	{
		NSString *stopKey = [@"STOP" lowercaseString];
		__block BOOL stoppedEarly = NO;
		double stopValue = 53.5;
		[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
			NSLog(@"value for key %@ is %@", key, value);
			if ([stopKey isEqualToString:key] || ([value doubleValue] == stopValue)) {
				*stop = YES;
				stoppedEarly = YES;  // this is legal now
			}
		}];
		if (stoppedEarly) {
			NSLog(@"Enumeration stopped earlier");
		}
		// we have strong reference on stopKey
		NSLog(@"---------------------------------------------------");
	}
	
	{
		unary_double_operation_t square;
		square = ^(double operand) {
			return operand * operand;
		};
		double squareOfFive = square(5.0);
		NSLog(@"%f", squareOfFive);
		NSLog(@"---------------------------------------------------");
	}
	
	{
		double d;
		double (^square)(double operand) = ^(double operand) {
			return operand * operand;
		};
		double squareOfFive = square(5.0);
		NSLog(@"%f", squareOfFive);
		NSLog(@"---------------------------------------------------");
	}
	
	{
		self.unaryOperations = [[NSMutableDictionary alloc] init];
		[self addUnaryOperation:@"square" whichExecutesBlock:^(double operand) {
			return operand * operand;
		}];
		[self performOperation:@"square" onOperand:5.0];
		NSLog(@"---------------------------------------------------");
	}
	
	{
//		- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block;
//		
//		typedef void (^enumeratingBlock)(id key, id obj, BOOL *stop);
//		
//		[UIView animateWithDuration:5.0 animations:^() {
//			view.opacity = 0.5;
//		}];
//		
//		[UIView animateWithDuration:5.0 animations:^{
//			view.opacity = 0.5;
//		}];
//		
//		NSSet *mySet = ...;
//		NSSet *matches = [mySet objectsPassingTest:^(id obj, ...) {
//			return [obj isKindOfClass:[UIView class]];
//			No need for the BOOL return type declaration cause return value is clearly a BOOL
//		}];
//
//		You can store blocks inside instance properties, dictionaries and arrays
//		Blocks behave like objects buy only for purposes of storing, their only method is -copy
//		All objects referenced inside a block will stay in the heap as long as the block does.
//		In other words, blocks keep a strong pointer to all objects referenced inside of them.
		[self.myBlocks addObject:^ {
			[self doSomething];
		}];
		
		__weak ViewController *weakSelf = self; // even though self is strong, weakSelf is weak
		[self.myBlocks addObject:^ {
			[weakSelf doSomething];
		}];
	}
}

- (void)addUnaryOperation:(NSString *)operation whichExecutesBlock:(unary_double_operation_t)operationBlock {
	self.unaryOperations[operation] = operationBlock;
}

- (double)performOperation:(NSString *)operation onOperand:(double)operand {
	unary_double_operation_t unaryOperation = self.unaryOperations[operation];
	if (unaryOperation) {
		double result = unaryOperation(operand);
		NSLog(@"%f", result);
		return result;
	}
	return 0.0;
}

-(void) doSomething {
	NSLog(@"Just for Lulz");
}

@end
