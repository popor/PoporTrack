//
//  PoporTrack.m
//  Pods-PoporTrack_Example
//
//  Created by apple on 2018/9/25.
//

#import "PoporTrack.h"


#define LL_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define LL_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface PoporTrack ()

@property (nonatomic, weak  ) UIWindow * window;

@property (nonatomic, strong) UIButton * ballBT;
@property (nonatomic        ) CGFloat sBallHideWidth;
@property (nonatomic        ) CGFloat sBallWidth;

@end

@implementation PoporTrack

+ (instancetype)share {
    static dispatch_once_t once;
    static PoporTrack * instance;
    dispatch_once(&once, ^{
        instance = [self new];
        
        instance.eventVcTargetActionSet = [NSMutableSet new];
        instance.eventTargetSet         = [NSMutableSet new];
        
        instance.sBallHideWidth = 10;
        instance.sBallWidth     = 80;
        instance.activeAlpha    = 1.0;
        instance.normalAlpha    = 0.6;
        instance.recordMaxNum   = 100;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [instance addViews];
        });
        
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

+ (void)trackType:(NSString *)type key:(NSString *)key {
    NSLog(@"发现跟踪type: %@, key:%@", type, key);
    PoporTrack * track = [PoporTrack share];
    if (track.trackBlock) {
        track.trackBlock(type, key);
    }
}


- (void)addViews {
    self.window = [[UIApplication sharedApplication] keyWindow];
    self.ballBT = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(0, 0, self.sBallWidth, self.sBallWidth);
        [button setTitle:@"获取事件" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor brownColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        button.layer.cornerRadius = button.frame.size.width/2;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        
        [self.window addSubview:button];
        
        //[button addTarget:self action:@selector(showPnrListVC) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    NSString * pointString = [self getBallPoint];
    if (pointString) {
        self.ballBT.center = CGPointFromString(pointString);
    }else{
        self.ballBT.center = CGPointMake(self.ballBT.frame.size.width/2- self.sBallHideWidth, 180);
    }
    self.ballBT.alpha = self.normalAlpha;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGR:)];
    [self.ballBT addGestureRecognizer:pan];
}

#pragma mark - Action
- (void)panGR:(UIPanGestureRecognizer *)gr {
    CGPoint panPoint = [gr locationInView:[[UIApplication sharedApplication] keyWindow]];
    //NSLog(@"panPoint: %f-%f", panPoint.x, panPoint.y);
    if (gr.state == UIGestureRecognizerStateBegan) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(resignActive) object:nil];
        [self becomeActive];
    } else if (gr.state == UIGestureRecognizerStateChanged) {
        [self changeSBallViewFrameWithPoint:panPoint];
    } else if (gr.state == UIGestureRecognizerStateEnded || gr.state == UIGestureRecognizerStateCancelled || gr.state == UIGestureRecognizerStateFailed) {
        [self resignActive];
    }
}

- (void)becomeActive {
    self.ballBT.alpha = self.activeAlpha;
}

- (void)resignActive {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ballBT.alpha = self.normalAlpha;
        // Calculate End Point
        CGFloat x = self.ballBT.center.x;
        CGFloat y = self.ballBT.center.y;
        CGFloat x1 = LL_SCREEN_WIDTH / 2.0;
        CGFloat y1 = LL_SCREEN_HEIGHT / 2.0;
        
        CGFloat distanceX = x1 > x ? x : LL_SCREEN_WIDTH - x;
        CGFloat distanceY = y1 > y ? y : LL_SCREEN_HEIGHT - y;
        CGPoint endPoint = CGPointZero;
        
        if (distanceX <= distanceY) {
            // animation to left or right
            endPoint.y = y;
            if (x1 < x) {
                // to right
                endPoint.x = LL_SCREEN_WIDTH - self.ballBT.frame.size.width / 2.0 + self.sBallHideWidth;
            } else {
                // to left
                endPoint.x = self.ballBT.frame.size.width / 2.0 - self.sBallHideWidth;
            }
        } else {
            // animation to top or bottom
            endPoint.x = x;
            if (y1 < y) {
                // to bottom
                endPoint.y = LL_SCREEN_HEIGHT - self.ballBT.frame.size.height / 2.0 + self.sBallHideWidth;
            } else {
                // to top
                endPoint.y = self.ballBT.frame.size.height / 2.0 - self.sBallHideWidth;
            }
        }
        self.ballBT.center = endPoint;
        
        [self saveBallPoint:NSStringFromCGPoint(endPoint)];
    } completion:nil];
}

- (void)changeSBallViewFrameWithPoint:(CGPoint)point {
    //self.ballBT.center = CGPointMake(point.x, point.y-self.ballBT.frame.size.height/2);
    self.ballBT.center = CGPointMake(point.x, point.y);
}

#pragma mark - 记录按钮位置
- (void)saveBallPoint:(NSString *)BallPoint {
    [[NSUserDefaults standardUserDefaults] setObject:BallPoint forKey:@"BallPoint"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getBallPoint {
    NSString * info = [[NSUserDefaults standardUserDefaults] objectForKey:@"BallPoint"];
    return info;
}

@end
