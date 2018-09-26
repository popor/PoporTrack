//
//  UIView+track.h
//  PoporTrack_Example
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (track)

@property (nonatomic, strong) NSString * trackID;
@property (nonatomic        ) BOOL     trackEnable;
@property (nonatomic, strong) NSString * trackVcClass;

@end

NS_ASSUME_NONNULL_END
