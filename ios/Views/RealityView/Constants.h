//
//  Constants.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 6/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import SceneKit;

#ifndef Constants_h
#define Constants_h

//
// Size
//

extern CGFloat const DISK_SMALL_RADIUS;
extern CGFloat const DISK_SMALL_HEIGHT;
extern CGFloat const DISK_SMALL_POSTER_BOTTOM_MARGIN;

extern CGFloat const DISK_LARGE_RADIUS;
extern CGFloat const DISK_LARGE_HEIGHT;
extern CGFloat const ARC_WIDTH;
extern CGFloat const SPACE_BETWEEN_INNER_DISK_AND_ARC;
extern CGFloat const DISK_LARGE_INNER_RADIUS;
extern CGFloat const DISK_LARGE_INNER_HEIGHT;
extern CGFloat const DISK_LARGE_ARC_HEIGHT;

extern CGFloat const DISK_SPACING_TO_POSTER;

extern CGFloat const SENSE_TEXT_SCALE;
extern CGFloat const SENSE_TEXT_DEPTH;

extern CGFloat const DISK_CALL_TO_ACTION_SCALE;
extern CGFloat const DISK_CALL_TO_ACTION_DEPTH;

extern CGFloat const BUTTON_CALL_TO_ACTION_WIDTH;
extern CGFloat const BUTTON_CALL_TO_ACTION_HEIGHT;
extern CGFloat const BUTTON_CALL_TO_ACTION_DEPTH;
extern CGFloat const BUTTON_CALL_TO_ACTION_CORNER_RADIUS;
extern CGFloat const BUTTON_CALL_TO_ACTION_SPACING_TO_DISK;

extern CGFloat const BUTTON_CALL_TO_ACTION_TEXT_SCALE;
extern CGFloat const BUTTON_CALL_TO_ACTION_TEXT_DEPTH;

extern CGFloat const DEACTIVATION_DISTANCE;

//
// Timing
//
extern NSTimeInterval const DISK_MOVE_TO_BOTTOM_DURATION;
extern NSTimeInterval const DISK_MOVE_TO_MIDDLE_DURATION;
extern NSTimeInterval const DISK_MOVE_TO_OFFSET_MIDDLE_DURATION;
extern NSTimeInterval const DISK_SCALE_TO_LARGE_DURATION;
extern NSTimeInterval const DISK_SCALE_TO_LARGE_DURATION;
extern NSTimeInterval const DISK_ROTATE_TO_ACTIVE_DURATION;
extern NSTimeInterval const DISK_ROTATE_TO_PASSIVE_DURATION;
extern NSTimeInterval const DISK_SPIN_DURATION;
extern NSTimeInterval const DISK_REVERSE_SPIN_DURATION;

extern NSTimeInterval const BUTTON_CALL_TO_ACTION_TO_HIDDEN_DURATION;
extern NSTimeInterval const BUTTON_CALL_TO_ACTION_TO_VISIBLE_DURATION;

//
// Color
//
#define TURQUOISE_LIGHT_COLOR [UIColor colorWithRed:87/255.0 green:214/255.0 blue:210/255.0 alpha:1]
#define COOL_GREY_COLOR [UIColor colorWithRed:242/255.0 green:241/255.0 blue:240/255.0 alpha:1]

#define DISK_CALL_TO_ACTION_TEXT_COLOR UIColor.blackColor
#define BUTTON_CALL_TO_ACTION_TEXT_COLOR UIColor.whiteColor
#define SENSE_TEXT_COLOR COOL_GREY_COLOR

//
// Content
//
#define DISK_CALL_TO_ACTION_TEXT @"Open"
#define BUTTON_CALL_TO_ACTION_TEXT @"Unlock"

//
// Other
//

extern CGFloat const ARC_PATH_FLATNESS;
extern CGFloat const ARC_SCALE_ADJUSTMENT_FIX;
extern CGFloat const MAXIMUM_SENSES_COUNT;

CGFloat convertDegreesToRadians(CGFloat degrees);
CGFloat roundToDecimals(CGFloat number, int decimals);
NSString *NSStringFromSCNVector3(SCNVector3 vector);
CGFloat distanceBetween(SCNVector3 a, SCNVector3 b);

#endif /* Constants_h */
