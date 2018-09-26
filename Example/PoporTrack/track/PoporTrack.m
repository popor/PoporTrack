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
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        
    });
    return instance;
}

@end
