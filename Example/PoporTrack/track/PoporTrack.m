//
//  PoporTrack.m
//  Pods-PoporTrack_Example
//
//  Created by apple on 2018/9/25.
//

#import "PoporTrack.h"

@implementation PoporTrack

+ (instancetype)share {
    static dispatch_once_t once;
    static PoporTrack * instance;
    dispatch_once(&once, ^{
        instance = [self new];
        instance.controlVcActionSet         = [NSMutableSet new];
        //instance.eventVcSet               = [NSMutableSet new];
        
        instance.grEventVcTargetActionSet = [NSMutableSet new];
        instance.grEventTargetSet         = [NSMutableSet new];
        
    });
    return instance;
}

- (void)sort {
    for (NSString * grEventVcTargetAction in self.grEventVcTargetActionSet) {
        NSArray * array = [grEventVcTargetAction componentsSeparatedByString:@"_"];
        if (array.count == 3) {
            [self.grEventTargetSet addObject:array[1]];
        }
    }
}

@end
