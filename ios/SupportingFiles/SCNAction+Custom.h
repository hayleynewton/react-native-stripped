//
//  SCNAction+Custom.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/24/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface SCNAction (Custom)

+ (SCNAction *)scaleFrom:(SCNVector3)initialScale toScale:(SCNVector3)targetScale duration:(NSTimeInterval)sec;

@end
