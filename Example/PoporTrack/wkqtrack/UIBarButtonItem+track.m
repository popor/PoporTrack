//
//  UIBarButtonItem+track.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIBarButtonItem+track.h"
#import <PoporFoundation/NSObject+Swizzling.h>
#import "OCDynamicHookUtils.h"

@implementation UIBarButtonItem (track)
//@dynamic trackTarget;
//@dynamic trackAction;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSLog(@"追踪BT: %@ %s", NSStringFromClass([self class]), __func__);
        // 初始化
        [objc_getClass("UIBarButtonItem") methodSwizzlingWithOriginalSelector:@selector(initWithTitle:style:target:action:)  bySwizzledSelector:@selector(trackinitWithTitle:style:target:action:)];
    });
}


- (instancetype)trackinitWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action {
    UIBarButtonItem * item = [self trackinitWithImage:image style:style target:target action:action];
    [item trackTarget:target action:action item:item];
    
    return item;
}

- (instancetype)trackinitWithImage:(nullable UIImage *)image landscapeImagePhone:(nullable UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action {
    UIBarButtonItem * item = [self trackinitWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:target action:action];
    [item trackTarget:target action:action item:item];
    
    return item;
}

- (instancetype)trackinitWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action {
    UIBarButtonItem * item = [self trackinitWithTitle:title style:style target:target action:action];
    //[item trackTarget:target action:action item:item];
    
    __block BOOL run = NO;
    [OCDynamicHookUtils AddHookInstanceMethodImp:^id(id self, ...) {
        //[target performSelector:action];
        //return nil;
        run = !run;
        if (run) {
            [item trackEvent];
            //[target performSelector:action];
            //[self performSelector:action];
        }
        return nil;
    } toClass:[target class] toReplaceSelector:action];
    
    return item;
}

- (instancetype)trackinitWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(nullable id)target action:(nullable SEL)action {
    UIBarButtonItem * item = [self trackinitWithBarButtonSystemItem:systemItem target:target action:action];
    [item trackTarget:target action:action item:item];
    
    return item;
}

- (void)trackTarget:(id)target action:(SEL)action item:(UIBarButtonItem *)item {
    __block BOOL run = NO;
    [OCDynamicHookUtils AddHookInstanceMethodImp:^id(id self, ...) {
        run = !run;
        if (run) {
            [item trackEvent];
            //[target performSelector:action];
            [self performSelector:action];
        }
        return self;
    } toClass:[target class] toReplaceSelector:action];
}

- (void)trackEvent {
    NSLog(@"ncbar : %@", NSStringFromClass([self class]));
    //[self.target performSelector:self.action];
    //[self trackExtension1];
    //[self.target trackExtension];
    NSLog(@"1111");
}

// 交换方法
+ (void)swizzlingMethod:(Method)originalMethod by:(Method)swizzledMethod {
    //method_exchangeImplementations(originalMethod, swizzledMethod);
    method_exchangeImplementations(swizzledMethod, originalMethod);
}

+ (void)swizzlingClass:(Class)originalClass action:(SEL)originalAction by:(Class)swizzledClass action:(SEL)swizzledAction {
    Method originalMethod = class_getInstanceMethod(originalClass, originalAction);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledAction);
    
    //method_exchangeImplementations(originalMethod, swizzledMethod);
    method_exchangeImplementations(swizzledMethod, originalMethod);
}

//// MARK: set get
//- (void)setTrackTarget:(id)trackTarget {
//    objc_setAssociatedObject(self, @"trackTarget", trackTarget, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (id)trackTarget {
//    return objc_getAssociatedObject(self, @"trackTarget");
//}
//
//- (void)setTrackAction:(SEL)trackAction {
//    objc_setAssociatedObject(self, @"trackAction", (__bridge_transfer SEL)trackAction, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (SEL)trackAction {
//    return objc_getAssociatedObject(self, @"trackAction");
//}

@end
