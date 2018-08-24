//
//  RealityScene.m
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/24/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SCNAction+Custom.h"

#import "RealityScene.h"

#import "ArcGeometry.h"

#import "Constants.h"

@interface RealityScene ()

// Nodes.

@property SCNNode *cover;
@property SCNNode *disk;
@property SCNNode *innerDisk;
@property SCNNode *commitButton;

// Scalar actions.

@property SCNAction *diskMoveToBottomAction;
@property SCNAction *diskMoveToMiddleAction;
@property SCNAction *diskMoveToOffsetMiddleAction;
@property SCNAction *diskScaleToLargeAction;
@property SCNAction *diskScaleToSmallAction;
@property SCNAction *diskRotateToActiveAction;
@property SCNAction *diskRotateToPassiveAction;
@property SCNAction *diskSpinAction;
@property SCNAction *diskReverseSpinAction;
@property SCNAction *commitButtonToVisibleAction;
@property SCNAction *commitButtonToHiddenAction;

// Non-scalar actions.

@property SCNAction *diskTransitionToActive;
@property SCNAction *diskTransitionToPassive;

// Action values.

@property CGSize posterSize;
@property SCNVector3 diskBottomPosition;
@property SCNVector3 diskMiddlePosition;
@property SCNVector3 diskMiddleOffsetPosition;
@property SCNVector3 diskSmallScale;
@property SCNVector3 diskLargeScale;
@property SCNVector3 diskActiveRotation;
@property SCNVector3 diskPassiveRotation;

// State.
@property NSString *state;

@end

@implementation RealityScene

- (id)initWithPosterSize:(CGSize)posterSize {
  self = [super init];
  
  if (self) {
    _state = @"Closed";
    _posterSize = posterSize;
    
    // Disk position states.
    _diskBottomPosition = SCNVector3Make(0,
                                         -(self.posterSize.height/2 - DISK_SMALL_RADIUS - DISK_SMALL_POSTER_BOTTOM_MARGIN),
                                         0);
    _diskMiddlePosition = SCNVector3Make(0, 0, 0);
    _diskMiddleOffsetPosition = SCNVector3Make(0, 0, DISK_LARGE_RADIUS + DISK_SPACING_TO_POSTER);
    
    _diskMoveToBottomAction = [SCNAction moveTo:_diskBottomPosition duration:DISK_MOVE_TO_BOTTOM_DURATION];
    _diskMoveToBottomAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    _diskMoveToMiddleAction = [SCNAction moveTo:_diskMiddlePosition duration:DISK_MOVE_TO_MIDDLE_DURATION];
    _diskMoveToMiddleAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    _diskMoveToOffsetMiddleAction = [SCNAction moveTo:_diskMiddleOffsetPosition duration:DISK_MOVE_TO_OFFSET_MIDDLE_DURATION];
    _diskMoveToOffsetMiddleAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    // Disk size states.
    _diskSmallScale = SCNVector3Make(DISK_SMALL_RADIUS/DISK_LARGE_RADIUS,
                                     DISK_SMALL_HEIGHT/DISK_LARGE_HEIGHT,
                                     DISK_SMALL_RADIUS/DISK_LARGE_RADIUS);
    _diskLargeScale = SCNVector3Make(1, 1, 1);
    
    _diskScaleToLargeAction = [SCNAction scaleFrom:_diskSmallScale toScale:_diskLargeScale duration:DISK_SCALE_TO_LARGE_DURATION];
    _diskScaleToLargeAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    _diskScaleToSmallAction = [SCNAction scaleFrom:_diskLargeScale toScale:_diskSmallScale duration:DISK_SCALE_TO_LARGE_DURATION];
    _diskScaleToSmallAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    // Disk rotation states.
    _diskActiveRotation = SCNVector3Make(convertDegreesToRadians(0), 0, 0);
    _diskPassiveRotation = SCNVector3Make(convertDegreesToRadians(-90), 0, 0);
    SCNVector3 passiveToActiveRotation = SCNVector3Make(_diskActiveRotation.x - _diskPassiveRotation.x,
                                                        _diskActiveRotation.y - _diskPassiveRotation.y,
                                                        _diskActiveRotation.z - _diskPassiveRotation.z);
    
    _diskRotateToActiveAction = [SCNAction rotateByX:passiveToActiveRotation.x
                                                   y:passiveToActiveRotation.y
                                                   z:passiveToActiveRotation.z
                                            duration:DISK_ROTATE_TO_ACTIVE_DURATION];
    _diskRotateToActiveAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    _diskRotateToPassiveAction = [SCNAction rotateByX:_diskPassiveRotation.x
                                                    y:_diskPassiveRotation.y
                                                    z:_diskPassiveRotation.z
                                             duration:DISK_ROTATE_TO_PASSIVE_DURATION];
    _diskRotateToPassiveAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    // Commit button.
    _commitButtonToVisibleAction = [SCNAction fadeOpacityTo:1 duration:BUTTON_CALL_TO_ACTION_TO_VISIBLE_DURATION];
    _commitButtonToHiddenAction = [SCNAction fadeOpacityTo:0 duration:BUTTON_CALL_TO_ACTION_TO_HIDDEN_DURATION];
    
    // Disk transition states.
    _diskTransitionToActive = [SCNAction group:@[_diskScaleToLargeAction,
                                                 _diskRotateToActiveAction,
                                                 _diskMoveToOffsetMiddleAction]];
    _diskTransitionToActive.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    _diskTransitionToPassive = [SCNAction group:@[_diskScaleToSmallAction,
                                                  _diskRotateToPassiveAction,
                                                  _diskMoveToMiddleAction]];
    _diskTransitionToPassive.timingMode = SCNActionTimingModeEaseInEaseOut;
    
    // Disk spin.
    _diskSpinAction = [SCNAction rotateToX:_diskActiveRotation.x
                                         y:convertDegreesToRadians(360)
                                         z:_diskActiveRotation.z
                                  duration:DISK_SPIN_DURATION];
    _diskReverseSpinAction = [SCNAction rotateToX:_diskActiveRotation.x
                                                y:_diskActiveRotation.y
                                                z:_diskActiveRotation.z
                                         duration:DISK_REVERSE_SPIN_DURATION];
  }
  
  return self;
}

#pragma mark - Object creation

- (void)createCover {
  SCNMaterial *coverMaterial = [SCNMaterial material];
  coverMaterial.diffuse.contents = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
  SCNPlane *coverGeometry = [SCNPlane planeWithWidth:self.posterSize.width
                                              height:self.posterSize.height];
  coverGeometry.materials = @[coverMaterial];
  SCNNode *cover = [SCNNode nodeWithGeometry:coverGeometry];
  cover.position = SCNVector3Make(0, 0, 0);
  cover.eulerAngles = SCNVector3Make(convertDegreesToRadians(-90), 0, 0);
  
  self.cover = cover;
}
- (void)createDisk {
  SCNMaterial *coolGreyMaterial = [SCNMaterial material];
  coolGreyMaterial.diffuse.contents = COOL_GREY_COLOR;
  SCNMaterial *grayMaterial = [SCNMaterial material];
  grayMaterial.diffuse.contents = [UIColor.grayColor colorWithAlphaComponent:1];
  
  SCNCylinder *diskGeometry = [SCNCylinder cylinderWithRadius:DISK_LARGE_RADIUS height:DISK_LARGE_HEIGHT];
  diskGeometry.materials = @[coolGreyMaterial];
  SCNNode *disk = [SCNNode nodeWithGeometry:diskGeometry];
  disk.scale = self.diskSmallScale;
//  disk.scale = self.diskLargeScale;
  disk.position = self.diskBottomPosition;
//  disk.position = self.diskMiddlePosition;
//  disk.position = self.diskMiddleOffsetPosition;
  disk.eulerAngles = self.diskPassiveRotation;
//  disk.eulerAngles = self.diskActiveRotation;
  
  SCNCylinder *innerDiskGeometry = [SCNCylinder cylinderWithRadius:DISK_LARGE_INNER_RADIUS height:DISK_LARGE_INNER_HEIGHT];
  innerDiskGeometry.materials = @[grayMaterial];
  SCNNode *innerDisk = [SCNNode nodeWithGeometry:innerDiskGeometry];
  innerDisk.position = SCNVector3Make(0, DISK_LARGE_HEIGHT/2 + DISK_LARGE_INNER_HEIGHT/2, 0);
  innerDisk.hidden = YES;
  
  [disk addChildNode:innerDisk];
  
  self.disk = disk;
  self.innerDisk = innerDisk;
  [self.cover addChildNode:disk];
}
- (void)createDiskCallToAction {
  // Draw border around the disk.
  SCNMaterial *turquoiseLightMaterial = [SCNMaterial material];
  turquoiseLightMaterial.diffuse.contents = TURQUOISE_LIGHT_COLOR;
  CGFloat innerRadius = DISK_LARGE_INNER_RADIUS + SPACE_BETWEEN_INNER_DISK_AND_ARC;
  
  CGFloat angleFrom = 0;
  do {
    SCNGeometry *arcGeometry = [ArcGeometry arcWithInnerRadius:innerRadius
                                                   outerRadius:DISK_LARGE_RADIUS
                                                    startAngle:convertDegreesToRadians(angleFrom)
                                                      endAngle:convertDegreesToRadians(angleFrom + 180)
                                                        height:DISK_CALL_TO_ACTION_DEPTH];
    arcGeometry.materials = @[turquoiseLightMaterial];
    SCNNode *arc = [SCNNode nodeWithGeometry:arcGeometry];
    arc.position = SCNVector3Make(0, -(DISK_LARGE_HEIGHT/2 + DISK_LARGE_ARC_HEIGHT/2), 0);
    arc.eulerAngles = SCNVector3Make(convertDegreesToRadians(90), 0, 0);
    
    [self.disk addChildNode:arc];
    
    angleFrom += 180;
  } while (angleFrom < 360);
  
  // Draw text.
  CGFloat textScale = DISK_CALL_TO_ACTION_SCALE;
  CGFloat textDepth = DISK_CALL_TO_ACTION_DEPTH / DISK_CALL_TO_ACTION_SCALE;
  NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:8]};
  NSAttributedString *textString = [[NSAttributedString alloc] initWithString:DISK_CALL_TO_ACTION_TEXT attributes:textAttributes];
  
  SCNMaterial *textMaterial = [SCNMaterial material];
  textMaterial.diffuse.contents = DISK_CALL_TO_ACTION_TEXT_COLOR;
  SCNText *textGeometry = [SCNText textWithString:textString extrusionDepth:textDepth];
  textGeometry.materials = @[textMaterial];
  
  SCNNode *text = [SCNNode nodeWithGeometry:textGeometry];
  text.castsShadow = YES;
  SCNVector3 minTextBound;
  SCNVector3 maxTextBound;
  [text getBoundingBoxMin:&minTextBound max:&maxTextBound];
  text.pivot = SCNMatrix4MakeTranslation((maxTextBound.x - minTextBound.x)/2 + minTextBound.x,
                                         (maxTextBound.y - minTextBound.y)/2 + minTextBound.y,
                                         (maxTextBound.z - minTextBound.z)/2 + minTextBound.z);
  text.scale = SCNVector3Make(textScale, textScale, textScale);
  text.eulerAngles = SCNVector3Make(convertDegreesToRadians(90), 0, 0);
  text.position = SCNVector3Make(0,
                                 -(DISK_SMALL_HEIGHT/2 + DISK_CALL_TO_ACTION_DEPTH/2),
                                 0);
  
  [self.disk addChildNode:text];
}
- (void)createSegmentsFor:(NSArray<NSString *> *)senses {
  SCNMaterial *turquoiseLightMaterial = [SCNMaterial material];
  turquoiseLightMaterial.diffuse.contents = TURQUOISE_LIGHT_COLOR;
  
  NSUInteger sensesCount = senses.count < MAXIMUM_SENSES_COUNT ? senses.count : MAXIMUM_SENSES_COUNT;
  CGFloat anglePerSegment = 360.0 / sensesCount;
  CGFloat segmentAngle = 0;
  CGFloat innerRadius = DISK_LARGE_INNER_RADIUS + SPACE_BETWEEN_INNER_DISK_AND_ARC;
  CGFloat inbetweenRadius = (innerRadius + DISK_LARGE_RADIUS)/2;
  
  for (int i = 0; i < sensesCount; i += 1) {
    // Draw arc segment.
    CGFloat segmentAngleFrom = convertDegreesToRadians(segmentAngle);
    CGFloat segmentAngleTo = convertDegreesToRadians(segmentAngle + anglePerSegment);
    CGFloat segmentAngleInbetween = (segmentAngleFrom + segmentAngleTo) / 2;

    SCNGeometry *arcGeometry = [ArcGeometry arcWithInnerRadius:innerRadius*ARC_SCALE_ADJUSTMENT_FIX
                                                   outerRadius:DISK_LARGE_RADIUS*ARC_SCALE_ADJUSTMENT_FIX
                                                    startAngle:segmentAngleFrom
                                                      endAngle:segmentAngleTo
                                                        height:DISK_LARGE_ARC_HEIGHT*ARC_SCALE_ADJUSTMENT_FIX];
    if (i %2 == 0) {
      arcGeometry.materials = @[turquoiseLightMaterial];
    } else {
      arcGeometry.materials = @[turquoiseLightMaterial];
    }
    SCNNode *arc = [SCNNode nodeWithGeometry:arcGeometry];
    arc.scale = SCNVector3Make(1/ARC_SCALE_ADJUSTMENT_FIX, 1/ARC_SCALE_ADJUSTMENT_FIX, 1/ARC_SCALE_ADJUSTMENT_FIX);
    arc.position = SCNVector3Make(0, 0, 0);
    arc.eulerAngles = SCNVector3Make(convertDegreesToRadians(-90), 0, 0);

    [self.innerDisk addChildNode:arc];
    
    // Draw text.
    CGFloat textScale = ARC_SCALE_ADJUSTMENT_FIX * SENSE_TEXT_SCALE;
    CGFloat textDepth = SENSE_TEXT_DEPTH / SENSE_TEXT_SCALE;
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:8]};
    NSAttributedString *textString = [[NSAttributedString alloc] initWithString:senses[i] attributes:textAttributes];
    
    CGFloat textPositionRadius = ARC_SCALE_ADJUSTMENT_FIX * (inbetweenRadius - SENSE_TEXT_DEPTH);
    CGPoint segmentCenter = CGPointMake(textPositionRadius * cos(segmentAngleInbetween),
                                        textPositionRadius * sin(segmentAngleInbetween));
    
    SCNMaterial *textMaterial = [SCNMaterial material];
    textMaterial.diffuse.contents = SENSE_TEXT_COLOR;
    SCNText *textGeometry = [SCNText textWithString:textString extrusionDepth:textDepth];
    textGeometry.materials = @[textMaterial];
    
    CGFloat textAngle = segmentAngleInbetween + convertDegreesToRadians(90);

    SCNNode *text = [SCNNode nodeWithGeometry:textGeometry];
    text.castsShadow = YES;
    SCNVector3 minTextBound;
    SCNVector3 maxTextBound;
    [text getBoundingBoxMin:&minTextBound max:&maxTextBound];
    text.pivot = SCNMatrix4MakeTranslation((maxTextBound.x - minTextBound.x)/2 + minTextBound.x,
                                           (maxTextBound.y - minTextBound.y)/2 + minTextBound.y,
                                           0);
    text.scale = SCNVector3Make(textScale, textScale, textScale);
    text.eulerAngles = SCNVector3Make(convertDegreesToRadians(90), 0, textAngle);
    text.position = SCNVector3Make(segmentCenter.x,
                                   segmentCenter.y,
                                   0.2);

    [arc addChildNode:text];

    segmentAngle += anglePerSegment;
  }
}
- (void)createAssetModelFrom:(NSString *)assetResource {
  NSURL *assetUrl = [NSBundle.mainBundle URLForResource:assetResource withExtension:@"obj"];
  MDLAsset *assetModel = [[MDLAsset alloc] initWithURL:assetUrl];
  SCNNode *asset = [SCNNode nodeWithMDLObject:[assetModel objectAtIndex:0]];
  
  SCNVector3 minBound;
  SCNVector3 maxBound;
  [asset getBoundingBoxMin:&minBound max:&maxBound];
  CGFloat sizeX = maxBound.x - minBound.x;
  CGFloat sizeY = maxBound.y - minBound.y;
  CGFloat sizeZ = maxBound.z - minBound.z;
  
  CGFloat scale = DISK_LARGE_INNER_RADIUS / sizeX;
  asset.scale = SCNVector3Make(scale, scale, scale);
  asset.pivot = SCNMatrix4MakeTranslation((sizeX)/2 + minBound.x,
                                          (sizeY)/2 + minBound.y,
                                          (sizeZ)/2 + minBound.z);
  asset.position = SCNVector3Make(0, DISK_LARGE_INNER_HEIGHT/2 + scale*sizeY/2, 0);
  
  [self.innerDisk addChildNode:asset];
}
- (void)createLights {
  SCNLight *spotLight = [SCNLight light];
  spotLight.type = SCNLightTypeSpot;
  spotLight.castsShadow = YES;
  spotLight.spotInnerAngle = 45;
  spotLight.spotOuterAngle = 45;
  spotLight.intensity = 4;
  spotLight.zNear = 0.01;
  spotLight.zFar = 2;
  spotLight.shadowMapSize = CGSizeMake(2, 2);
  spotLight.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
  
  SCNLight *directionalLight = [SCNLight light];
  directionalLight.type = SCNLightTypeDirectional;
  directionalLight.color = UIColor.whiteColor;
  directionalLight.castsShadow = YES;
  directionalLight.intensity = 2000;
  directionalLight.shadowRadius = 0.1;
  directionalLight.shadowMapSize = CGSizeMake(1000, 1000);
  directionalLight.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
  
  SCNNode *light = [SCNNode node];
  light.light = directionalLight;
  light.position = SCNVector3Make(0, 0.4, 0);
  light.eulerAngles = SCNVector3Make(convertDegreesToRadians(-89), 0, 0);
  
  [self.innerDisk addChildNode:light];
}
- (void)createCommitButton {
  // Buton shape.
  SCNMaterial *buttonMaterial = [SCNMaterial material];
  buttonMaterial.diffuse.contents = TURQUOISE_LIGHT_COLOR;
  SCNBox *buttonGeometry = [SCNBox boxWithWidth:BUTTON_CALL_TO_ACTION_WIDTH
                                         height:BUTTON_CALL_TO_ACTION_HEIGHT
                                         length:BUTTON_CALL_TO_ACTION_DEPTH
                                  chamferRadius:BUTTON_CALL_TO_ACTION_CORNER_RADIUS];
  buttonGeometry.materials = @[buttonMaterial];
  SCNNode *button = [SCNNode nodeWithGeometry:buttonGeometry];
  button.opacity = 0;
  button.position = SCNVector3Make(0,
                                   -(DISK_LARGE_INNER_HEIGHT + DISK_LARGE_HEIGHT + DISK_CALL_TO_ACTION_DEPTH),
                                   self.diskMiddleOffsetPosition.z + DISK_LARGE_RADIUS + BUTTON_CALL_TO_ACTION_SPACING_TO_DISK + BUTTON_CALL_TO_ACTION_DEPTH/2);
  
  [self.cover addChildNode:button];
  self.commitButton = button;
  
  // Button text.
  CGFloat textScale = BUTTON_CALL_TO_ACTION_TEXT_SCALE;
  CGFloat textDepth = BUTTON_CALL_TO_ACTION_TEXT_DEPTH / BUTTON_CALL_TO_ACTION_TEXT_SCALE;
  NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:8]};
  NSAttributedString *textString = [[NSAttributedString alloc] initWithString:BUTTON_CALL_TO_ACTION_TEXT attributes:textAttributes];
  
  SCNMaterial *textMaterial = [SCNMaterial material];
  textMaterial.diffuse.contents = BUTTON_CALL_TO_ACTION_TEXT_COLOR;
  SCNText *textGeometry = [SCNText textWithString:textString extrusionDepth:textDepth];
  textGeometry.materials = @[textMaterial];
  
  SCNNode *text = [SCNNode nodeWithGeometry:textGeometry];
  text.castsShadow = YES;
  SCNVector3 minTextBound;
  SCNVector3 maxTextBound;
  [text getBoundingBoxMin:&minTextBound max:&maxTextBound];
  text.pivot = SCNMatrix4MakeTranslation((maxTextBound.x - minTextBound.x)/2 + minTextBound.x,
                                         (maxTextBound.y - minTextBound.y)/2 + minTextBound.y,
                                         (maxTextBound.z - minTextBound.z)/2 + minTextBound.z);
  text.scale = SCNVector3Make(textScale, textScale, textScale);
  text.eulerAngles = SCNVector3Make(convertDegreesToRadians(0), 0, 0);
  text.position = SCNVector3Make(0,
                                 0,
                                 BUTTON_CALL_TO_ACTION_DEPTH/2 + BUTTON_CALL_TO_ACTION_TEXT_DEPTH/2);
  
  [button addChildNode:text];
}
- (SCNNode *)createFor:(Pack *)pack {
  self.pack = pack;
  
  [self createCover];
  [self createDisk];
  [self createDiskCallToAction];
  [self createSegmentsFor:pack.senses];
  [self createAssetModelFrom:pack.asset];
  [self createCommitButton];
  [self createLights];
  
  return self.cover;
}
- (void)removeFromSession:(ARSession *)session {
  [self.cover removeFromParentNode];
  [session removeAnchor:self.anchor];
}

#pragma mark - Animations

- (void)animateToActive {
  self.state = @"AnimatingToActive";
  [self.disk runAction:self.diskMoveToMiddleAction completionHandler:^{
    self.innerDisk.hidden = NO;
    [self.disk runAction:self.diskTransitionToActive completionHandler:^{
      [self.commitButton runAction:self.commitButtonToVisibleAction completionHandler:^{
        self.state = @"Active";
        [self.delegate realitySceneDidAnimateToActive:self.pack];
      }];
    }];
  }];
}
- (void)animateToPassive {
  if ([self.state isEqualToString:@"Active"]) {
    self.state = @"AnimatingToClosed";
    [self.disk removeActionForKey:@"diskSpinAction"];
    [self.disk runAction:self.diskReverseSpinAction completionHandler:^{
      [self.commitButton runAction:self.commitButtonToHiddenAction completionHandler:^{
        [self.disk runAction:self.diskTransitionToPassive completionHandler:^{
          self.innerDisk.hidden = YES;
          [self.disk runAction:self.diskMoveToBottomAction completionHandler:^{
            self.state = @"Closed";
            [self.delegate realitySceneDidAnimateToPassive:self.pack];
          }];
        }];
      }];
    }];
  }
}
- (void)animateSpin {
  [self.disk runAction:self.diskSpinAction forKey:@"diskSpinAction" completionHandler:^{
    self.disk.eulerAngles = self.diskActiveRotation;
    [self animateSpin];
  }];
}

#pragma mark - Actions

- (void)didTapOn:(NSArray<SCNHitTestResult *> *)hits {
  for (SCNHitTestResult *hit in hits) {
    if (hit.node == self.disk) {
      if ([self.state isEqualToString:@"Closed"]) {
        [self.delegate realitySceneOnOpen:self.pack];
      }
    } else if (hit.node == self.commitButton) {
      if ([self.state isEqualToString:@"Active"]) {
        [self.delegate realitySceneOnUnlockPack:self.pack];
      }
    }
  }
}

@end
