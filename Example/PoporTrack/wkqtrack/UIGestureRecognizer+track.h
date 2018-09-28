//
//  UIGestureRecognizer+track.h
//  PoporTrack_Example
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (track)

@property (nullable, nonatomic,weak) id  trackTarget;
@property (nullable, nonatomic)      SEL trackAction;
@property (nonatomic, strong) NSString * trackVcClass;

@end

NS_ASSUME_NONNULL_END
