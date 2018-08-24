//
//  Pack.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ARKit;
@import SceneKit;
@class RealityScene;

@interface Pack : NSObject

@property NSDictionary *poster;
@property NSString *asset;
@property NSArray<NSString *> *senses;
@property SCNVector3 position;
@property NSInteger nodeTag;
@property RealityScene *realityScene;

+ (ARReferenceImage *)configureReferenceImageForPack:(Pack *)pack;

+ (Pack *)buildingsPack;
+ (Pack *)communicationPack;
+ (Pack *)environmentPack;
+ (Pack *)foodAndDrinkPack;
+ (Pack *)gardenPack;
+ (Pack *)relaxationPack;
+ (Pack *)technologyPack;
+ (Pack *)wellbeingPack;

@end
