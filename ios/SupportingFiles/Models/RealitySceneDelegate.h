//
//  RealitySceneDelegate.h
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Pack.h"

@protocol RealitySceneDelegate <NSObject>

@optional
- (void)realitySceneDidAnimateToActive:(Pack *)pack;
- (void)realitySceneDidAnimateToPassive:(Pack *)pack;
- (void)realitySceneOnOpen:(Pack *)pack;
- (void)realitySceneOnUnlockPack:(Pack *)pack;

@end
