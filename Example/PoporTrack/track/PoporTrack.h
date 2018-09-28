//
//  PoporTrack.h
//  Pods-PoporTrack_Example
//
//  Created by apple on 2018/9/25.
//

#import <Foundation/Foundation.h>

/*
 采用UI为主线的方式,默认只监测UI触发的用户事件.
 eventClassActionSet: class 和 action 以_区分
 */
NS_ASSUME_NONNULL_BEGIN

@interface PoporTrack : NSObject

+ (instancetype)share;

@property (nonatomic, strong) NSMutableSet * vcSet;
//@property (nonatomic, strong) NSMutableDictionary * eventDic;
@property (nonatomic, strong) NSMutableDictionary * routerDic;

// 下面针对的是UIControl,只需要采集VC和Action即可.
@property (nonatomic, strong) NSMutableSet * controlVcActionSet; // 完整的eventID;
//@property (nonatomic, strong) NSMutableSet * eventVcSet; // eventClass 集合

/*
 下面针对UIGestureRecognizer,需要采集VC,Target,Action. 因为系统会生成大量的GR事件,hook的时候会和用户事件产生bug.
 vc:监测的页面
 target:gr初始target
 action:gr初始action
 */
@property (nonatomic, strong) NSMutableSet * grEventVcTargetActionSet;
@property (nonatomic, strong) NSMutableSet * grEventTargetSet;

- (void)sort;

@end

NS_ASSUME_NONNULL_END
