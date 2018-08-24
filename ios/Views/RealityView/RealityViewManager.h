//
//  RealityViewManager.h
//  SymbolScanClient
//
//  Created by Morgan Wilde on 6/29/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <ARKit/ARKit.h>
#import <React/RCTViewManager.h>

#import "RealityView.h"

@interface RealityViewManager : RCTViewManager <ARSCNViewDelegate>

// ARSCNViewDelegate
- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor;

@end
