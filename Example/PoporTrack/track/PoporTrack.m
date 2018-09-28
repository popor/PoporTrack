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
        
        instance.eventVcTargetActionSet = [NSMutableSet new];
        instance.eventTargetSet         = [NSMutableSet new];
        
    });
    return instance;
}

- (void)sort {
    for (NSString * grEventVcTargetAction in self.eventVcTargetActionSet) {
        NSArray * array = [grEventVcTargetAction componentsSeparatedByString:@"_"];
        if (array.count == 3) {
            [self.eventTargetSet addObject:array[1]];
        }
    }
}

@end
