//
//  CircleSegmentPath.m
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "CircleSegmentPath.h"

#import "Constants.h"

@implementation CircleSegmentPath

+ (UIBezierPath *)circleSegmentWithCenter:(CGPoint)center
                              innerRadius:(CGFloat)innerRadius
                              outerRadius:(CGFloat)outerRadius
                               startAngle:(CGFloat)startAngle
                                 endAngle:(CGFloat)endAngle
{
  // Calculate relevant positions.
  CGPoint outerStartAnchor = CGPointMake(outerRadius * cos(startAngle) + center.x,
                                         outerRadius * sin(startAngle) + center.y);
//  CGPoint outerEndAnchor = CGPointMake(outerRadius * cos(endAngle) + center.x,
//                                       outerRadius * sin(endAngle) + center.y);
//  CGPoint innerStartAnchor = CGPointMake(innerRadius * cos(startAngle) + center.x,
//                                         innerRadius * sin(startAngle) + center.y);
  CGPoint innerEndAnchor = CGPointMake(innerRadius * cos(endAngle) + center.x,
                                       innerRadius * sin(endAngle) + center.y);
  
//  NSLog(@"%@ | %@ | %@ | %@",
//        NSStringFromCGPoint(innerStartAnchor),
//        NSStringFromCGPoint(innerEndAnchor),
//        NSStringFromCGPoint(outerEndAnchor),
//        NSStringFromCGPoint(outerStartAnchor));
  
  // Build path.
  UIBezierPath *path = [UIBezierPath bezierPath];

//  [path moveToPoint:innerStartAnchor];
//  [path addLineToPoint:innerEndAnchor];
//  [path addLineToPoint:outerEndAnchor];
//  [path addLineToPoint:outerStartAnchor];
//  [path closePath];
  
  [path moveToPoint:outerStartAnchor];
  [path addArcWithCenter:center radius:outerRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
  [path addLineToPoint:innerEndAnchor];
  [path addArcWithCenter:center radius:innerRadius startAngle:endAngle endAngle:startAngle clockwise:NO];
  [path closePath];
  
  return path;
}

@end
