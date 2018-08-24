//
//  Pack.m
//  ARKitBasics
//
//  Created by Morgan Wilde on 7/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "Pack.h"

@implementation Pack

+ (ARReferenceImage *)configureReferenceImageForPack:(Pack *)pack {
  NSURL *imageUrl = [NSBundle.mainBundle URLForResource:pack.poster[@"name"]
                                          withExtension:pack.poster[@"type"]];
  NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
  CGFloat physicalWidth = ((NSNumber *) pack.poster[@"physicalWidth"]).floatValue;
  ARReferenceImage *referenceImage = [[ARReferenceImage alloc] initWithCGImage:[UIImage imageWithData:imageData].CGImage
                                                                   orientation:kCGImagePropertyOrientationUp
                                                                 physicalWidth:physicalWidth];
  referenceImage.name = pack.poster[@"name"];
  
  return referenceImage;
}

+ (Pack *)buildingsPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.201 /* meters */, @"name": @"BuildingsPoster", @"type": @"jpg"};
  pack.asset = @"Buildings";
  pack.nodeTag = 22;
  pack.senses = @[@"courtyard",
                  @"ceiling",
                  @"catering",
                  @"lift",
                  @"triangle",
                  @"tower",
                  @"stairs",
                  @"roof",
                  @"headquarters",
                  @"concierge",
                  @"coffee bar",
                  @"block",
                  @"architecture"];
  
  return pack;
}
+ (Pack *)communicationPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.292 /* meters */, @"name": @"CommunicationPoster", @"type": @"jpg"};
  pack.asset = @"Communication";
  pack.nodeTag = 29;
  pack.senses = @[@"medium",
                  @"conversation",
                  @"technology",
                  @"message",
                  @"electronic",
                  @"tool",
                  @"share",
                  @"secure",
                  @"network",
                  @"modern",
                  @"innovative",
                  @"information",
                  @"flexible",
                  @"face to face",
                  @"collaborative"];
  
  return pack;
}
+ (Pack *)environmentPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.292 /* meters */, @"name": @"EnvironmentPoster", @"type": @"jpg"};
  pack.asset = @"Environment";
  pack.nodeTag = 27;
  pack.senses = @[@"recycle",
                  @"nature",
                  @"issue",
                  @"global warming",
                  @"climate change",
                  @"responsible",
                  @"urban",
                  @"reduce",
                  @"prevent",
                  @"manage",
                  @"impact",
                  @"green",
                  @"disaster"];
  
  return pack;
}
+ (Pack *)foodAndDrinkPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.292 /* meters */, @"name": @"FoodAndDrinkPoster", @"type": @"jpg"};
  pack.asset = @"FoodAndDrink";
  pack.nodeTag = 26;
  pack.senses = @[@"salad",
                  @"ingredient",
                  @"healthy",
                  @"sliced",
                  @"recipe",
                  @"snack",
                  @"vegetarian",
                  @"tasty",
                  @"spicy",
                  @"menu",
                  @"fried",
                  @"chopped"];
  
  return pack;
}
+ (Pack *)gardenPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.292 /* meters */, @"name": @"GardenPoster", @"type": @"jpg"};
  pack.asset = @"Garden";
  pack.nodeTag = 30;
  pack.senses = @[@"herb",
                  @"lush",
                  @"plant",
                  @"seed",
                  @"water",
                  @"patch",
                  @"landscape",
                  @"grow",
                  @"cultivate",
                  @"blossom"];
  
  return pack;
}
+ (Pack *)relaxationPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.201 /* meters */, @"name": @"RelaxationPoster", @"type": @"jpg"};
  pack.asset = @"Relaxation";
  pack.nodeTag = 31;
  pack.senses = @[@"take it easy",
                  @"sit back",
                  @"restful",
                  @"relief",
                  @"recover",
                  @"pleasure",
                  @"peace of mind",
                  @"leisure",
                  @"hang out",
                  @"content",
                  @"comfort",
                  @"chill out",
                  @"calm"];
  
  return pack;
}
+ (Pack *)technologyPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.201 /* meters */, @"name": @"TechnologyPoster", @"type": @"jpg"};
  pack.asset = @"Technology";
  pack.nodeTag = 20;
  pack.senses = @[@"plug",
                  @"hardware",
                  @"server",
                  @"software",
                  @"click",
                  @"virus",
                  @"upload",
                  @"shut down",
                  @"install",
                  @"download",
                  @"charger",
                  @"browser"];
  
  return pack;
}
+ (Pack *)wellbeingPack {
  Pack *pack = [[Pack alloc] init];
  pack.poster = @{@"physicalWidth": @0.201 /* meters */, @"name": @"WellbeingPoster", @"type": @"jpg"};
  pack.asset = @"Wellbeing";
  pack.nodeTag = 28;
  pack.senses = @[@"health",
                  @"physical",
                  @"plan of action",
                  @"rowing",
                  @"work out",
                  @"train",
                  @"mental health",
                  @"massage",
                  @"induction",
                  @"fit",
                  @"exercise",
                  @"book"];
  
  return pack;
}

@end
