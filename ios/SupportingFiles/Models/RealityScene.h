//
//  RealityScene.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/24/18.
//  Copyright © 2018 Apple. All rights reserved.
//

@import UIKit;
@import ARKit;
@import SceneKit;
@import SceneKit.ModelIO;

#import "RealitySceneDelegate.h"
#import "Pack.h"

@interface RealityScene : NSObject

@property id <RealitySceneDelegate> delegate;
@property Pack *pack;
@property ARAnchor *anchor;

- (id)initWithPosterSize:(CGSize)posterSize;

// Object creation.

- (SCNNode *)createFor:(Pack *)pack;
- (void)removeFromSession:(ARSession *)session;

// Animations.

- (void)animateToActive;
- (void)animateToPassive;
- (void)animateSpin;

// Actions.
- (void)didTapOn:(NSArray<SCNHitTestResult *> *)hits;

@end
