//
//  SlideCover1.m
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "SlideCover1.h"
#import "SlideCover2.h"
#import "SlideCoverDrivenInteractive.h"

@interface SlideCover1 ()

@property (strong, nonatomic) SlideCoverDrivenInteractive *slideCoverDrivenInteractive;

@end

@implementation SlideCover1

- (void)viewDidLoad {
    [super viewDidLoad];
    //为过度添加交互进度管理实例
    _slideCoverDrivenInteractive = [SlideCoverDrivenInteractive drivenInteractiveWithController:self gestureDirection:YES];
    __weak typeof(self) weakSelf = self;
    //手势开始的操作
    _slideCoverDrivenInteractive.toogleBlock = ^{
        SlideCover2 *vc = [[SlideCover2 alloc] init];
        vc.pushInteractive = weakSelf.slideCoverDrivenInteractive.drivenInteractive;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
}

- (IBAction)presentClick:(id)sender {
    SlideCover2 *vc = [[SlideCover2 alloc] init];
    vc.pushInteractive = self.slideCoverDrivenInteractive.drivenInteractive;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
