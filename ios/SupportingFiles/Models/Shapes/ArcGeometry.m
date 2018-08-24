//
//  ArcGeometry.m
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "ArcGeometry.h"

#import "CircleSegmentPath.h"

#import "Constants.h"

@implementation ArcGeometry

+ (SCNGeometry *)arcWithInnerRadius:(CGFloat)innerRadius
                        outerRadius:(CGFloat)outerRadius
                         startAngle:(CGFloat)startAngle
                           endAngle:(CGFloat)endAngle
                             height:(CGFloat)height
{
  UIBezierPath *path = [CircleSegmentPath circleSegmentWithCenter:CGPointZero
                                                      innerRadius:innerRadius
                                                      outerRadius:outerRadius
                                                       startAngle:startAngle
                                                         endAngle:endAngle];
  path.flatness = ARC_PATH_FLATNESS;
  
  
  return [SCNShape shapeWithPath:path extrusionDepth:height];
}

@end
