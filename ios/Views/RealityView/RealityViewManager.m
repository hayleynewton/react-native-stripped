//
//  RealityViewManager.m
//  SymbolScanClient
//
//  Created by Morgan Wilde on 6/29/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RealityViewManager.h"

#import "Pack.h"
#import "RealityScene.h"

#import "Constants.h"

@interface RealityViewManager ()

@property RealityView *realityView;

@end

@implementation RealityViewManager

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(onPackAnimationToActive, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPackAnimationToPassive, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPackOpen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPackUnlock, RCTBubblingEventBlock)

- (UIView *)view {
  self.realityView = [[RealityView alloc] init];
  self.realityView.delegate = self;
  
  [self setupGestureRecognizer];
  [self.realityView setup];
  [self.realityView run];
  
  // Prevent screen dimming.
  UIApplication.sharedApplication.idleTimerDisabled = YES;
  
  return self.realityView;
}
- (void)setupGestureRecognizer {
  UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
  [self.realityView addGestureRecognizer:recognizer];
}


#pragma mark - ARSCNViewDelegate

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
  if (![anchor isKindOfClass:[ARImageAnchor class]]) {
    return;
  }
  [self.realityView didAddNode:node forAnchor:(ARImageAnchor *)anchor];
}
- (void)renderer:(id<SCNSceneRenderer>)renderer willRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time {
  [self.realityView onCameraMove];
}

#pragma mark - Actions

- (void)didTap:(UITapGestureRecognizer *)recognizer {
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    CGPoint location = [recognizer locationInView:self.realityView];
    [self.realityView onTapAtLocation:location];
  }
}
- (void)didTapCommit {
//  self.realityView.onTapCommit(@{});
}
- (void)didTapCancel {
//  self.realityView.onTapCancel(@{});
}

@end
