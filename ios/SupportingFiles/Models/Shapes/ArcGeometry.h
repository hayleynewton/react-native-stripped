//
//  ArcGeometry.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface ArcGeometry : SCNGeometry

+ (SCNGeometry *)arcWithInnerRadius:(CGFloat)innerRadius
                        outerRadius:(CGFloat)outerRadius
                         startAngle:(CGFloat)startAngle
                           endAngle:(CGFloat)endAngle
                             height:(CGFloat)height;

@end
