//
//  UIControl+track.h
//  PoporTrack_Example
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (track)

@property (nonatomic, strong) NSString * trackID;
@property (nullable, nonatomic,weak) id  trackTarget;
@property (nullable, nonatomic)      SEL trackAction;

@end

NS_ASSUME_NONNULL_END
