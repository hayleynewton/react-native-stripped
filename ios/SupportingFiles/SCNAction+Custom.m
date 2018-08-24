//
//  SCNAction+Custom.m
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/24/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SCNAction+Custom.h"

@implementation SCNAction (Custom)

+ (SCNAction *)scaleFrom:(SCNVector3)initialScale toScale:(SCNVector3)targetScale duration:(NSTimeInterval)sec {
  SCNVector3 deltaScale = SCNVector3Make(targetScale.x - initialScale.x,
                                         targetScale.y - initialScale.y,
                                         targetScale.z - initialScale.z);
  void (^callback)(SCNNode *, CGFloat) = ^(SCNNode *node, CGFloat elapsedTime) {
    node.scale = SCNVector3Make(initialScale.x + deltaScale.x * (elapsedTime/sec),
                                initialScale.y + deltaScale.y * (elapsedTime/sec),
                                initialScale.z + deltaScale.z * (elapsedTime/sec));
  };
  
  return [SCNAction customActionWithDuration:sec actionBlock:callback];
}

@end
