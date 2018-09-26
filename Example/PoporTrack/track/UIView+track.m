//
//  UIView+track.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIView+track.h"
#import <PoporFoundation/NSObject+Swizzling.h>

@implementation UIView (track)
@dynamic trackID;
@dynamic trackEnable;
@dynamic trackVcClass;

- (void)setTrackID:(NSString *)trackID {
    objc_setAssociatedObject(self, @"trackID", trackID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackID {
    return objc_getAssociatedObject(self, @"trackID");
}

- (void)setTrackEnable:(BOOL)trackEnable {
    objc_setAssociatedObject(self, @"trackEnable", [NSNumber numberWithBool:trackEnable], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)trackEnable {
    NSNumber * n = objc_getAssociatedObject(self, @"trackEnable");
    return n.boolValue;
}

- (void)setTrackVcClass:(NSString *)trackClass {
    objc_setAssociatedObject(self, @"trackClass", trackClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackVcClass {
    return objc_getAssociatedObject(self, @"trackClass");
}

@end
