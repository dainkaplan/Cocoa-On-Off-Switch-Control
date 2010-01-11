//
//  PRHOnOffButtonAppDelegate.m
//  PRHOnOffButton
//
//  Created by Peter Hosey on 2010-01-10.
//  Copyright 2010 Peter Hosey. All rights reserved.
//

#import "PRHOnOffButtonAppDelegate.h"

@implementation PRHOnOffButtonAppDelegate

- (id) init {
	if ((self = [super init])) {
		onState = NSOnState;
		offState = NSOffState;
		mixedState = NSMixedState;
	}
	return self;
}

@synthesize window;
@synthesize onState, offState, mixedState;

@end
