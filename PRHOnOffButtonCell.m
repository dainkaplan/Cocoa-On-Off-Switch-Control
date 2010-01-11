//
//  PRHOnOffButtonCell.m
//  PRHOnOffButton
//
//  Created by Peter Hosey on 2010-01-10.
//  Copyright 2010 Peter Hosey. All rights reserved.
//

#import "PRHOnOffButtonCell.h"

//In this file, the “button” is the part that slides between the two extremes of the frame.

#define BUTTON_WIDTH_FRACTION 0.45f
#define BUTTON_CORNER_RADIUS 3.0f
#define FRAME_CORNER_RADIUS 5.0f

#define BUTTON_GRADIENT_MAX_Y_WHITE 1.0f
#define BUTTON_GRADIENT_MIN_Y_WHITE 0.9f
#define BACKGROUND_GRADIENT_MAX_Y_WHITE 0.50f
#define BACKGROUND_GRADIENT_MIN_Y_WHITE 0.75f
#define BORDER_WHITE 0.1f

#define BUTTON_SHADOW_WHITE 0.0f
#define BUTTON_SHADOW_ALPHA 0.5f
#define BUTTON_SHADOW_BLUR 3.0f

@implementation PRHOnOffButtonCell

+ (NSFocusRingType) defaultFocusRingType {
	return NSFocusRingTypeExterior;
}

- (id) initImageCell:(NSImage *)image {
	if ((self = [super initImageCell:image])) {
		[self setFocusRingType:[[self class] defaultFocusRingType]];
	}
	return self;
}
- (id) initTextCell:(NSString *)str {
	if ((self = [super initTextCell:str])) {
		[self setFocusRingType:[[self class] defaultFocusRingType]];
	}
	return self;
}
//HAX: IB (I guess?) sets our focus ring type to None for some reason. Nobody asks defaultFocusRingType unless we do it.
- (id) initWithCoder:(NSCoder *)decoder {
	if ((self = [super initWithCoder:decoder])) {
		[self setFocusRingType:[[self class] defaultFocusRingType]];
	}
	return self;
}

- (void) drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	//Draw the background, then the frame.
	NSBezierPath *borderPath = [NSBezierPath bezierPathWithRoundedRect:cellFrame xRadius:FRAME_CORNER_RADIUS yRadius:FRAME_CORNER_RADIUS];
	
	NSGradient *background = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.5f alpha:1.0f] endingColor:[NSColor colorWithCalibratedWhite:0.75f alpha:1.0f]] autorelease];
	[background drawInBezierPath:borderPath angle:90.0f];

	[[NSColor colorWithCalibratedWhite:BORDER_WHITE alpha:1.0f] setStroke];
	[borderPath stroke];

	[self drawInteriorWithFrame:cellFrame inView:controlView];
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	//Draw the button (sliding bit).

	NSGraphicsContext *context = [NSGraphicsContext currentContext];
	[context saveGraphicsState];

	cellFrame.size.width -= 2.0f;
	cellFrame.size.height -= 2.0f;
	cellFrame.origin.x += 1.0f;
	cellFrame.origin.y += 1.0f;
	NSBezierPath *clipPath = [NSBezierPath bezierPathWithRoundedRect:cellFrame xRadius:BUTTON_CORNER_RADIUS yRadius:BUTTON_CORNER_RADIUS];
	[clipPath addClip];

	NSRect buttonFrame = cellFrame;
	buttonFrame.size.width *= BUTTON_WIDTH_FRACTION;

	NSCellStateValue state = [self state];
	switch (state) {
		case NSOffState:
			//Far left. We're already there; don't do anything.
			break;
		case NSOnState:
			//Far right.
			buttonFrame.origin.x += (cellFrame.size.width - buttonFrame.size.width);
			break;
		case NSMixedState:
			//Middle.
			buttonFrame.origin.x = (cellFrame.size.width / 2.0f) - (buttonFrame.size.width / 2.0f);
			break;
	}

	NSBezierPath *buttonPath = [NSBezierPath bezierPathWithRoundedRect:buttonFrame xRadius:BUTTON_CORNER_RADIUS yRadius:BUTTON_CORNER_RADIUS];
	NSShadow *buttonShadow = [[[NSShadow alloc] init] autorelease];
	[buttonShadow setShadowColor:[NSColor colorWithCalibratedWhite:BUTTON_SHADOW_WHITE alpha:BUTTON_SHADOW_ALPHA]];
	[buttonShadow setShadowBlurRadius:BUTTON_SHADOW_BLUR];
	[buttonShadow setShadowOffset:NSZeroSize];
	[buttonShadow set];
	[[NSColor whiteColor] setFill];
	if ([self showsFirstResponder] && ([self focusRingType] != NSFocusRingTypeNone))
		NSSetFocusRingStyle(NSFocusRingBelow);
	[buttonPath fill];
	NSGradient *buttonGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:BUTTON_GRADIENT_MAX_Y_WHITE alpha:1.0f] endingColor:[NSColor colorWithCalibratedWhite:BUTTON_GRADIENT_MIN_Y_WHITE alpha:1.0f]] autorelease];
	[buttonGradient drawInBezierPath:buttonPath angle:90.0f];

	[context restoreGraphicsState];
}

- (NSUInteger)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
	NSPoint mouseLocation = [controlView convertPoint:[event locationInWindow] fromView:nil];
	return NSPointInRect(mouseLocation, cellFrame) ? (NSCellHitContentArea | NSCellHitTrackableArea) : NSCellHitNone;
}

@end
