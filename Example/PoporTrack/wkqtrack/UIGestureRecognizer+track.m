//
//  UIGestureRecognizer+track.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIGestureRecognizer+track.h"

#import <PoporFoundation/NSObject+Swizzling.h>
#import <PoporFoundation/NSObject+performSelector.h>
#import "UIView+track.h"
#import "PoporTrack.h"

@implementation UIGestureRecognizer (track)
@dynamic trackTarget;
@dynamic trackAction;
@dynamic trackVcClass;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //        // 初始化
        //        [objc_getClass("UIGestureRecognizer") methodSwizzlingWithOriginalSelector:@selector(initWithTarget:action:)  bySwizzledSelector:@selector(trackinitWithTarget:action:)];
        //        [objc_getClass("UIGestureRecognizer") methodSwizzlingWithOriginalSelector:@selector(addTarget:action:)  bySwizzledSelector:@selector(trackaddTarget:action:)];
        //        [objc_getClass("UIGestureRecognizer") methodSwizzlingWithOriginalSelector:@selector(removeTarget:action:)  bySwizzledSelector:@selector(trackremoveTarget:action:)];
        
    });
}

- (instancetype)trackinitWithTarget:(nullable id)target action:(nullable SEL)action {
    NSLog(@"target: %@, action:%@", target, NSStringFromSelector(action));
    SEL swizzleSEL = [self swizzlingTarget:target action:action];
    
    UIGestureRecognizer * gr = [self trackinitWithTarget:target action:swizzleSEL];
    gr.trackTarget = target;
    gr.trackAction = action;
    
    return gr;
}

- (void)trackaddTarget:(id)target action:(SEL)action {
    
}

- (void)trackremoveTarget:(nullable id)target action:(nullable SEL)action {
    
}

- (SEL)swizzlingTarget:(id)target action:(SEL)action {
    if (!target || !action) {
        return nil;
    }
    SEL swizzleSEL = @selector(trackEvent:);
    // 新增函数
    class_addMethod([target class], swizzleSEL, class_getMethodImplementation([UIGestureRecognizer class], swizzleSEL), "v@:@");
    // 交换
    [[self class] methodSwizzlingWithOriginalSelector:action bySwizzledSelector:swizzleSEL];
    
    return swizzleSEL;
}

- (void)trackEvent:(UIGestureRecognizer *)gr {
    // 假如gr.view.userInteractionEnabled = NO; 可能导致gr时间击穿.
    
    if (gr.trackAction) {
        PoporTrack * track = [PoporTrack share];
        if (!gr.trackVcClass) {
            gr.trackVcClass = gr.view.vcClassName;
        }
        NSString * trackID = [NSString stringWithFormat:@"%@_%@", gr.trackVcClass, NSStringFromSelector(gr.trackAction)];
        if ([track.eventSet containsObject:trackID]) {
            NSLog(@"需要跟踪 gr : %@, %@", NSStringFromClass([self class]), NSStringFromSelector(gr.trackAction));
        }
        //SuppressPerformSelectorLeakWarning([gr.trackTarget performSelector:gr.trackAction];);
        [NSObject target:self voidAction:gr.trackAction];
    }
}

// MARK: set get
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

- (void)setTrackVcClass:(NSString *)trackVcClass {
    objc_setAssociatedObject(self, @"trackVcClass", trackVcClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackVcClass {
    return objc_getAssociatedObject(self, @"trackVcClass");
}


@end
