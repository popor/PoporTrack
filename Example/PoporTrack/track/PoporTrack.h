//
//  PoporTrack.h
//  Pods-PoporTrack_Example
//
//  Created by apple on 2018/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PoporTrack : NSObject

+ (instancetype)share;

@property (nonatomic, strong) NSMutableSet * vcSet;
//@property (nonatomic, strong) NSMutableDictionary * eventDic;
@property (nonatomic, strong) NSMutableDictionary * routerDic;
@property (nonatomic, strong) NSMutableSet * eventSet;

@end

NS_ASSUME_NONNULL_END
