//
//  Constants.m
//  ARKitBasics
//
//  Created by Morgan Wilde on 6/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "Constants.h"

//
// Size (in meters if not specified otherwise.)
//

CGFloat const DISK_SMALL_RADIUS = 0.022;
CGFloat const DISK_SMALL_HEIGHT = 0.01;
CGFloat const DISK_SMALL_POSTER_BOTTOM_MARGIN = 0.01;

CGFloat const DISK_LARGE_RADIUS = 0.1485;
CGFloat const DISK_LARGE_HEIGHT = 0.02;
CGFloat const ARC_WIDTH = 0.02;
CGFloat const SPACE_BETWEEN_INNER_DISK_AND_ARC = 0.01;
CGFloat const DISK_LARGE_INNER_RADIUS = DISK_LARGE_RADIUS - SPACE_BETWEEN_INNER_DISK_AND_ARC - ARC_WIDTH;
CGFloat const DISK_LARGE_INNER_HEIGHT = 0.01;
CGFloat const DISK_LARGE_ARC_HEIGHT = 0.01;

CGFloat const DISK_SPACING_TO_POSTER = 0.01;

CGFloat const SENSE_TEXT_SCALE = 0.0015; // Relative.
CGFloat const SENSE_TEXT_DEPTH = 0.002;

CGFloat const DISK_CALL_TO_ACTION_SCALE = 0.01; // Relative.
CGFloat const DISK_CALL_TO_ACTION_DEPTH = 0.01;

CGFloat const BUTTON_CALL_TO_ACTION_WIDTH = 0.1;
CGFloat const BUTTON_CALL_TO_ACTION_HEIGHT = 0.05;
CGFloat const BUTTON_CALL_TO_ACTION_DEPTH = 0.02;
CGFloat const BUTTON_CALL_TO_ACTION_CORNER_RADIUS = 0.01;
CGFloat const BUTTON_CALL_TO_ACTION_SPACING_TO_DISK = 0.01;

CGFloat const BUTTON_CALL_TO_ACTION_TEXT_SCALE = 0.0025; // Relative.
CGFloat const BUTTON_CALL_TO_ACTION_TEXT_DEPTH = 0.005;

CGFloat const DEACTIVATION_DISTANCE = 1;

//
// Timing
//

NSTimeInterval const DISK_MOVE_TO_BOTTOM_DURATION = 1;
NSTimeInterval const DISK_MOVE_TO_MIDDLE_DURATION = 1;
NSTimeInterval const DISK_MOVE_TO_OFFSET_MIDDLE_DURATION = 1;
NSTimeInterval const DISK_SCALE_TO_LARGE_DURATION = 1;
NSTimeInterval const DISK_SCALE_TO_SMALL_DURATION = 1;
NSTimeInterval const DISK_ROTATE_TO_ACTIVE_DURATION = 1;
NSTimeInterval const DISK_ROTATE_TO_PASSIVE_DURATION = 1;
NSTimeInterval const DISK_SPIN_DURATION = 10;
NSTimeInterval const DISK_REVERSE_SPIN_DURATION = 1;

NSTimeInterval const BUTTON_CALL_TO_ACTION_TO_HIDDEN_DURATION = 1;
NSTimeInterval const BUTTON_CALL_TO_ACTION_TO_VISIBLE_DURATION = 1;

//
// Other
//

CGFloat const ARC_PATH_FLATNESS = 0.001; // Relative.
CGFloat const ARC_SCALE_ADJUSTMENT_FIX = 10; // Relative.
CGFloat const MAXIMUM_SENSES_COUNT = 10;

CGFloat convertDegreesToRadians(CGFloat degrees) {
  return (degrees / 180.0) * M_PI;
}
CGFloat roundToDecimals(CGFloat number, int decimals) {
  int powerOfTen = 1;
  while (decimals > 0) {
    powerOfTen *= 10;
    decimals -= 1;
  }
  return round(powerOfTen * number) / powerOfTen;
}
NSString *NSStringFromSCNVector3(SCNVector3 vector) {
  NSString *format = @"Vector(%.3f %.3f %.3f)";
  NSString *buffer = [NSString stringWithFormat:format, vector.x, vector.y, vector.z];
  return buffer;
}
CGFloat distanceBetween(SCNVector3 a, SCNVector3 b) {
  return sqrt(pow((b.x - a.x), 2) +
              pow((b.y - a.y), 2) +
              pow((b.z - a.z), 2));
}
