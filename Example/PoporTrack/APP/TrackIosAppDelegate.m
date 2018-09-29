//
//  TrackIosAppDelegate.m
//  PoporTrack
//
//  Created by popor on 09/21/2018.
//  Copyright (c) 2018 popor. All rights reserved.
//

#import "TrackIosAppDelegate.h"

#import "PoporTrack.h"

@implementation TrackIosAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
#if TARGET_IPHONE_SIMULATOR//模拟器
    NSString * iosInjectionPath = @"/Applications/InjectionX.app/Contents/Resources/iOSInjection.bundle";
    if ([[NSFileManager defaultManager] fileExistsAtPath:iosInjectionPath]) {
        [[NSBundle bundleWithPath:iosInjectionPath] load];
    }
#endif
    PoporTrack * track = [PoporTrack share];
    [track.vcSet addObjectsFromArray:@[@"VCWkq1", @"VCWkq2", @"VCWkq3"]];
    
    // ahy
    //[track.eventSet addObjectsFromArray:@[]];
    
    
    [track.eventVcTargetActionSet addObjectsFromArray:@[@"RootVC1_RootVC1_ncRItemAction",
                                                        @"RootVC1_RootVC1_btAction",
                                                        @"VCWkq1_VCWkq1_VCWkq2Action",
                                                        @"VCWkq1_VCWkq1_VCWkq3Action",
                                                        @"RootVC2_VCWkq1_btAction",
                                                        @"RootVC2_RootVC2Cell_tapGRAction"]];
    
    [track sort];
    
    return YES;
}


@end
