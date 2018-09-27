//
//  UIViewController+track.m
//  Pods-PoporTrack_Example
//
//  Created by apple on 2018/9/21.
//

#import "UIViewController+track.h"
#import <PoporFoundation/NSObject+Swizzling.h>
#import "PoporTrack.h"

@implementation UIViewController (track)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化
        [objc_getClass("UIViewController") methodSwizzlingWithOriginalSelector:@selector(viewDidLoad)  bySwizzledSelector:@selector(trackViewDidLoad)];
    });
}


- (void)trackViewDidLoad {
    [self trackViewDidLoad];
    
    self.view.trackVcClass = NSStringFromClass([self class]);
    PoporTrack * track = [PoporTrack share];
    if ([track.vcSet containsObject:self.view.trackVcClass]) {
        NSLog(@"追踪VC: %@", NSStringFromClass([self class]));
    }
}

@end
