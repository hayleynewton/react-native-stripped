//
//  RealityView.h
//  SymbolScanClient
//
//  Created by Morgan Wilde on 6/29/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <ARKit/ARKit.h>
#import <React/RCTComponent.h>

#import "RealitySceneDelegate.h"

@interface RealityView : ARSCNView <RealitySceneDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onPackAnimationToActive;
@property (nonatomic, copy) RCTBubblingEventBlock onPackAnimationToPassive;
@property (nonatomic, copy) RCTBubblingEventBlock onPackOpen;
@property (nonatomic, copy) RCTBubblingEventBlock onPackUnlock;

//@property (nonatomic, copy) RCTBubblingEventBlock onTapCommit;
//@property (nonatomic, copy) RCTBubblingEventBlock onTapCancel;

- (instancetype)init;

- (void)setup;
- (void)run;

// Actions.

- (void)didAddNode:(SCNNode *)node forAnchor:(ARImageAnchor *)anchor;
- (void)onCameraMove;
- (void)onTapAtLocation:(CGPoint)location;

// RealitySceneDelegate

- (void)realitySceneDidAnimateToActive:(Pack *)pack;
- (void)realitySceneDidAnimateToPassive:(Pack *)pack;
- (void)realitySceneOnOpen:(Pack *)pack;
- (void)realitySceneOnUnlockPack:(Pack *)pack;

@end
