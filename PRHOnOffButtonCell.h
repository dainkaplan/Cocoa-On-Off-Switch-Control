//
//  PRHOnOffButtonCell.h
//  PRHOnOffButton
//
//  Created by Peter Hosey on 2010-01-10.
//  Copyright 2010 Peter Hosey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PRHOnOffButtonCell : NSButtonCell {
	BOOL tracking;
	NSPoint initialTrackingPoint, trackingPoint;
	NSRect trackingCellFrame; //Set by drawWithFrame: when tracking is true.
	CGFloat trackingButtonCenterX; //Set by drawWithFrame: when tracking is true.
}

@end
