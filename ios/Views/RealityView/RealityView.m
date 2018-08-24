//
//  RealityView.m
//  SymbolScanClient
//
//  Created by Morgan Wilde on 6/29/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RealityView.h"

#import "Pack.h"
#import "RealityScene.h"

#import "Constants.h"

@interface RealityView ()

@property ARWorldTrackingConfiguration *configuration;
@property NSArray<Pack *> *packs;
@property Pack *activePack;

@end

@implementation RealityView

- (instancetype)init {
  self = [super init];
  if (self) {
    // Data.
    _packs = @[[Pack buildingsPack],
               [Pack communicationPack],
               [Pack environmentPack],
               [Pack foodAndDrinkPack],
               [Pack gardenPack],
               [Pack relaxationPack],
               [Pack technologyPack],
               [Pack wellbeingPack]];
    _activePack = nil;
    
    // Configuration.
    _configuration = [ARWorldTrackingConfiguration new];
    _configuration.planeDetection = ARPlaneDetectionHorizontal | ARPlaneDetectionVertical;
    _configuration.lightEstimationEnabled = YES;
    
    NSMutableSet *referenceImages = [[NSMutableSet alloc] init];
    for (Pack *pack in _packs) {
      [referenceImages addObject:[Pack configureReferenceImageForPack:pack]];
    }
    
    _configuration.detectionImages = referenceImages;
    
    // Default property values.
    self.showsStatistics = NO;
    self.autoenablesDefaultLighting = NO;
    self.debugOptions = SCNDebugOptionNone;
  }
  
  return self;
}

- (void)setup {
  // Lights
  SCNLight *ambientLight = [SCNLight light];
  ambientLight.type = SCNLightTypeAmbient;
  ambientLight.intensity = 1000;
  SCNNode *ambientLightNode = [SCNNode node];
  ambientLightNode.light = ambientLight;
  
  [self.scene.rootNode addChildNode:ambientLightNode];
}
- (void)run {
  [self.session runWithConfiguration:self.configuration];
}

#pragma mark - Actions

- (void)didAddNode:(SCNNode *)node forAnchor:(ARImageAnchor *)anchor {
  Pack *pack = nil;
  for (Pack *candidate in self.packs) {
    if ([(NSString *)candidate.poster[@"name"] isEqualToString:anchor.referenceImage.name]) {
      pack = candidate;
      break;
    }
  }
  
  pack.realityScene = [[RealityScene alloc] initWithPosterSize:anchor.referenceImage.physicalSize];
  pack.realityScene.delegate = self;
  
  [node addChildNode:[pack.realityScene createFor:pack]];
  SCNVector3 position = SCNVector3Make(anchor.transform.columns[3].x,
                                       anchor.transform.columns[3].y,
                                       anchor.transform.columns[3].z);
  pack.position = position;
}
- (void)onCameraMove {
  SCNNode *pointOfView = self.pointOfView;
  SCNVector3 cameraLocation = SCNVector3Make(pointOfView.transform.m41,
                                             pointOfView.transform.m42,
                                             pointOfView.transform.m43);
  CGFloat distance = distanceBetween(cameraLocation, self.activePack.position);
  if (distance > DEACTIVATION_DISTANCE) {
    [self.activePack.realityScene animateToPassive];
  }
}
- (void)onTapAtLocation:(CGPoint)location {
  NSArray<SCNHitTestResult *> *hits = [self hitTest:location options:nil];
  for (Pack *pack in self.packs) {
    [pack.realityScene didTapOn:hits];
  }
}

#pragma mark - RealitySceneDelegate

- (void)realitySceneDidAnimateToActive:(Pack *)pack {
  [self.activePack.realityScene animateSpin];
  self.onPackAnimationToActive(@{@"Node.tag": [NSNumber numberWithInteger:pack.nodeTag]});
}
- (void)realitySceneDidAnimateToPassive:(Pack *)pack; {
  if (self.activePack == pack) {
    self.activePack = nil;
  }
  self.onPackAnimationToPassive(@{@"Node.tag": [NSNumber numberWithInteger:pack.nodeTag]});
}
- (void)realitySceneOnOpen:(Pack *)pack {
  self.activePack = pack;
  [self.activePack.realityScene animateToActive];
  self.onPackOpen(@{@"Node.tag": [NSNumber numberWithInteger:pack.nodeTag]});
}
- (void)realitySceneOnUnlockPack:(Pack *)pack {
  self.onPackUnlock(@{@"Node.tag": [NSNumber numberWithInteger:pack.nodeTag]});
}

@end
