//
//  UIBarButtonItem+track.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIBarButtonItem+track.h"
#import <PoporFoundation/NSObject+Swizzling.h>
#import <PoporFoundation/NSObject+performSelector.h>
#import "UIView+track.h"
#import "PoporTrack.h"

@implementation UIBarButtonItem (track)
//@dynamic trackTarget;
@dynamic trackAction;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSLog(@"追踪BT: %@ %s", NSStringFromClass([self class]), __func__);
        // 初始化
        [objc_getClass("UIBarButtonItem") methodSwizzlingWithOriginalSelector:@selector(initWithImage:style:target:action:)  bySwizzledSelector:@selector(trackinitWithImage:style:target:action:)];
        [objc_getClass("UIBarButtonItem") methodSwizzlingWithOriginalSelector:@selector(initWithImage:landscapeImagePhone:style:target:action:)  bySwizzledSelector:@selector(trackinitWithImage:landscapeImagePhone:style:target:action:)];
        [objc_getClass("UIBarButtonItem") methodSwizzlingWithOriginalSelector:@selector(initWithTitle:style:target:action:)  bySwizzledSelector:@selector(trackinitWithTitle:style:target:action:)];
        [objc_getClass("UIBarButtonItem") methodSwizzlingWithOriginalSelector:@selector(initWithBarButtonSystemItem:target:action:)  bySwizzledSelector:@selector(trackinitWithBarButtonSystemItem:target:action:)];
    });
}

- (instancetype)trackinitWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action {
    SEL swizzleSEL = [self swizzlingTarget:target action:action];
    UIBarButtonItem * item = [self trackinitWithImage:image style:style target:target action:swizzleSEL];
    item.trackAction = action;
    item.trackID = [NSString stringWithFormat:@"%@_%@_%@", NSStringFromClass([target class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
    
    return item;
}

- (instancetype)trackinitWithImage:(nullable UIImage *)image landscapeImagePhone:(nullable UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action {
    SEL swizzleSEL = [self swizzlingTarget:target action:action];
    UIBarButtonItem * item = [self trackinitWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:target action:swizzleSEL];
    item.trackAction = action;
    item.trackID = [NSString stringWithFormat:@"%@_%@_%@", NSStringFromClass([target class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
    
    return item;
}

- (instancetype)trackinitWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action {
    SEL swizzleSEL = [self swizzlingTarget:target action:action];
    UIBarButtonItem * item = [self trackinitWithTitle:title style:style target:target action:swizzleSEL];
    item.trackAction = action;
    item.trackID = [NSString stringWithFormat:@"%@_%@_%@", NSStringFromClass([target class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
    
    return item;
}

- (instancetype)trackinitWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(nullable id)target action:(nullable SEL)action {
    SEL swizzleSEL = [self swizzlingTarget:target action:action];
    
    UIBarButtonItem * item = [self trackinitWithBarButtonSystemItem:systemItem target:target action:swizzleSEL];
    item.trackAction = action;
    item.trackID = [NSString stringWithFormat:@"%@_%@_%@", NSStringFromClass([target class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
    
    return item;
}

- (SEL)swizzlingTarget:(id)target action:(SEL)action {
    if (!target || !action) {
        return nil;
    }
    SEL swizzleSEL = @selector(trackEvent:);
    // 新增函数
    class_addMethod([target class], swizzleSEL, class_getMethodImplementation([self class], swizzleSEL), "v@:@");
    // 交换
    [[self class] methodSwizzlingWithOriginalSelector:action bySwizzledSelector:swizzleSEL];
    
    return swizzleSEL;
}

- (void)trackEvent:(UIBarButtonItem *)item {
    if (item.trackAction) {
        PoporTrack * track = [PoporTrack share];
        if ([track.eventVcTargetActionSet containsObject:item.trackID]) {
            NSLog(@"UIBarButtonItem 需要跟踪 ncbar : %@, %@", NSStringFromClass([self class]), NSStringFromSelector(item.trackAction));
        }else{
            NSLog(@"UIBarButtonItem 不需要跟踪");
        }
        SuppressPerformSelectorLeakWarning([self performSelector:item.trackAction];);
    }
}

// MARK: set get
- (void)setTrackAction:(SEL)trackAction {
    objc_setAssociatedObject(self, @"trackAction", NSStringFromSelector(trackAction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SEL)trackAction {
    return NSSelectorFromString(objc_getAssociatedObject(self, @"trackAction"));
}

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
