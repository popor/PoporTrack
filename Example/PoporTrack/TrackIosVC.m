//
//  TrackIosViewController.m
//  PoporTrack
//
//  Created by popor on 09/21/2018.
//  Copyright (c) 2018 popor. All rights reserved.
//

#import "TrackIosVC.h"

#import "VCWkq1.h"
#import "UIButton+track.h"

@interface TrackIosVC ()

@end

@implementation TrackIosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Track";

    [self addViews];
}

- (void)addViews {
    UIButton * touch = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100;
        button.frame =  CGRectMake(100, 100, 80, 44);
        [button setTitle:@"Touch" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor brownColor]];
        
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    
    
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(ncRItemAction)];
        item1.tag = 101;
        self.navigationItem.rightBarButtonItems = @[item1];
    }
    
    
    {
        ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =  CGRectMake(100, 180, 60, 60);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
            
            [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
            
            //button;
        });
        
    }
    
}


- (void)btAction {
    NSLog(@"%s", __func__);
    
}

- (void)ncRItemAction {
    //NSLog(@"%s", __func__);
    [self.navigationController pushViewController:[VCWkq1 new] animated:YES];
}

@end
