//
//  VCWkq1.m
//  PoporTrack_Example
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "VCWkq1.h"

#import "VCWkq2.h"
#import "VCWkq3.h"

@interface VCWkq1 ()

@end

@implementation VCWkq1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
 
    
    //    {
    //        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"VCWkq2" style:UIBarButtonItemStylePlain target:self action:@selector(VCWkq2Action)];
    //        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"VCWkq3" style:UIBarButtonItemStylePlain target:self action:@selector(VCWkq3Action)];
    //
    //        self.navigationItem.rightBarButtonItems = @[item2, item1];
    //    }
    
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"VCWkq2" style:UIBarButtonItemStylePlain target:self action:nil];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"VCWkq3" style:UIBarButtonItemStylePlain target:self action:@selector(VCWkq3Action)];
        
        self.navigationItem.rightBarButtonItems = @[item2, item1];
    }
}

- (void)VCWkq2Action {
    [self.navigationController pushViewController:[VCWkq2 new] animated:YES];
}

- (void)VCWkq3Action {
    [self.navigationController pushViewController:[VCWkq3 new] animated:YES];
}


@end
