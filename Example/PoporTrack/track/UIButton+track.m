//
//  UIButton+track.m
//  Pods-PoporTrack_Example
//
//  Created by apple on 2018/9/25.
//

#import "UIButton+track.h"

#import <PoporFoundation/NSObject+Swizzling.h>
#import "PoporTrack.h"

@implementation UIButton (track)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSLog(@"追踪BT: %@ %s", NSStringFromClass([self class]), __func__);
        // 初始化
        [objc_getClass("UIButton") methodSwizzlingWithOriginalSelector:@selector(addTarget:action:forControlEvents:)  bySwizzledSelector:@selector(trackAddTarget:action:forControlEvents:)];
    });
}

- (void)trackAddTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [self trackAddTarget:target action:action forControlEvents:controlEvents];
    
    [self removeTarget:self action:@selector(trackExtension) forControlEvents:controlEvents];
    [self trackAddTarget:self action:@selector(trackExtension) forControlEvents:controlEvents];
}

- (void)trackExtension {
    //NSLog(@"追踪BT: %@ %s", NSStringFromClass([self class]), __func__);
    if (!self.trackID) {
        NSString * vcClass;
        UIView * superview = self.superview;
        UIView * subview   = self;
        NSString * tempClass;
        while (!vcClass) {
            tempClass = NSStringFromClass([superview class]);
            if ([tempClass isEqualToString:@"UIViewControllerWrapperView"]) {
                vcClass = subview.trackVcClass;
                break;
            }
            if (!self.superview) {
                return;
            }
            if (!superview) {
                return;
            }
            //NSLog(@"superview:%@, vcClass:%@", vcClass, tempClass);
            subview = superview;
            superview = superview.superview;
        }
        //NSLog(@"-- superview:%@, vcClass:%@", NSStringFromClass([superview class]), vcClass);
        if (vcClass) {
            if (self.currentTitle) {
                self.trackID = [NSString stringWithFormat:@"%@_%@", vcClass, self.currentTitle];
            }else if (self.currentImage) {
                self.trackID = [NSString stringWithFormat:@"%@_%li", vcClass, self.currentImage.hash];
            }else if(self.currentBackgroundImage){
                self.trackID = [NSString stringWithFormat:@"%@_%li", vcClass, self.currentBackgroundImage.hash];
            }
        }
    }
    NSLog(@"self.trackID:%@", self.trackID);
    PoporTrack * track = [PoporTrack share];
    if ([track.eventSet containsObject:self.trackID]) {
        NSLog(@"需要跟踪");
    }else{
        NSLog(@"-- 不需要跟踪");
    }
    
}

//- (void)didMoveToSuperview {
//    [super didMoveToSuperview];
//    NSLog(@"tag:%li, hash:%li, %s, %@", self.tag, self.hash, __func__, self.superview);
//
//    //self.superview
//    //self.hash;
//}

@end
