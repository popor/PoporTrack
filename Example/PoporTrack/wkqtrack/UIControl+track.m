//
//  UIControl+track.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIControl+track.h"

#import <PoporFoundation/NSObject+Swizzling.h>
#import "PoporTrack.h"
#import "UIView+track.h"

@implementation UIControl (track)
@dynamic trackID;
@dynamic trackTarget;
@dynamic trackAction;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSLog(@"追踪BT: %@ %s", NSStringFromClass([self class]), __func__);
        // 初始化
        [objc_getClass("UIControl") methodSwizzlingWithOriginalSelector:@selector(addTarget:action:forControlEvents:)  bySwizzledSelector:@selector(trackAddTarget:action:forControlEvents:)];
    });
}

- (void)trackAddTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [self trackAddTarget:target action:action forControlEvents:controlEvents];
    
    self.trackAction = action;
    
    [self removeTarget:self action:@selector(trackExtension) forControlEvents:controlEvents];
    [self trackAddTarget:self action:@selector(trackExtension) forControlEvents:controlEvents];
}

- (void)trackExtension {
    //NSLog(@"追踪BT: %@ %s", NSStringFromClass([self class]), __func__);
    if (!self.trackID) {
        NSString * vcClass = self.vcClassName;
        if (vcClass) {
            self.trackID = vcClass;
        }
    }
    // BT 名字图片可能变更.
    
    NSString * checkID = [NSString stringWithFormat:@"%@_%@", self.trackID, NSStringFromSelector(self.trackAction)];
    
    //    if (self.currentTitle) {
    //        checkID = [NSString stringWithFormat:@"%@_%@", self.trackID, self.currentTitle];
    //    }else if (self.currentImage) {
    //        checkID = [NSString stringWithFormat:@"%@_%li", self.trackID, self.currentImage.hash];
    //    }else if(self.currentBackgroundImage){
    //        checkID = [NSString stringWithFormat:@"%@_%li", self.trackID, self.currentBackgroundImage.hash];
    //    }else{
    //        return;
    //    }
    
    //NSLog(@"checkID:%@", checkID);
    PoporTrack * track = [PoporTrack share];
    if ([track.controlVcActionSet containsObject:checkID]) {
        NSLog(@"UIControl 需要跟踪");
    }else{
        NSLog(@"UIControl -- 不需要跟踪");
    }
    
}

// MARK: set get
- (void)setTrackID:(NSString *)trackID {
    objc_setAssociatedObject(self, @"trackID", trackID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackID {
    return objc_getAssociatedObject(self, @"trackID");
}

- (void)setTrackTarget:(id)trackTarget {
    objc_setAssociatedObject(self, @"trackTarget", trackTarget, OBJC_ASSOCIATION_ASSIGN);
}

- (id)trackTarget {
    return objc_getAssociatedObject(self, @"trackTarget");
}

- (void)setTrackAction:(SEL)trackAction {
    objc_setAssociatedObject(self, @"trackAction", NSStringFromSelector(trackAction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SEL)trackAction {
    return NSSelectorFromString(objc_getAssociatedObject(self, @"trackAction"));
}

@end
