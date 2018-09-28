//
//  RootVC2Cell.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "RootVC2Cell.h"
#import <Masonry/Masonry.h>

@implementation RootVC2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addviews];
    }
    return self;
}

- (void)addviews {
    self.bt = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(0, 0, 80, 40);
        [button setTitle:@"CellBT" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor brownColor]];
        
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        
        [self addSubview:button];
        
        [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    
    self.l = ({
        UILabel * l = [UILabel new];
        l.frame              = CGRectMake(0, 0, 0, 44);
        l.backgroundColor    = [UIColor clearColor];
        l.font               = [UIFont systemFontOfSize:15];
        l.textColor          = [UIColor darkGrayColor];
        
        l.numberOfLines      = 1;
        
        l.layer.cornerRadius = 5;
        l.layer.borderColor  = [UIColor lightGrayColor].CGColor;
        l.layer.borderWidth  = 1;
        l.clipsToBounds      = YES;
        
        [self addSubview:l];
        l;
    });
    
    self.l.userInteractionEnabled = YES;
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction)];
    [self.l addGestureRecognizer:self.tapGR];
    
    [self.bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.bt.mas_left).mas_offset(-10);
        
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(0);
    }];
    
}

- (void)btAction {
    NSLog(@"%s", __func__);
    
}

- (void)tapGRAction {
    NSLog(@"%s", __func__);
    
}

@end
