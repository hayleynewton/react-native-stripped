//
//  CircleSegmentPath.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleSegmentPath : UIBezierPath

+ (UIBezierPath *)circleSegmentWithCenter:(CGPoint)center
                              innerRadius:(CGFloat)innerRadius
                              outerRadius:(CGFloat)outerRadius
                               startAngle:(CGFloat)startAngle
                                 endAngle:(CGFloat)endAngle;

@end
