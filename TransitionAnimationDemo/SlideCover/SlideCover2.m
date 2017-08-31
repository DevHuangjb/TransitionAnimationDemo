//
//  SlideCover2.m
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "SlideCover2.h"
#import "SlideCoverTransitionAnimation.h"
#import "SlideCoverDrivenInteractive.h"

@interface SlideCover2 ()<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@property (strong, nonatomic) SlideCoverDrivenInteractive *slideCoverDrivenInteractive;

@end

@implementation SlideCover2

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化的时候设置，不能在viewDidLoad设置
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _slideCoverDrivenInteractive = [SlideCoverDrivenInteractive drivenInteractiveWithController:self gestureDirection:NO];
    __weak typeof(self) weakSelf = self;
    _slideCoverDrivenInteractive.toogleBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SlideCoverTransitionAnimation * transition = [[SlideCoverTransitionAnimation alloc] init];
    transition.dismissType = NO;
    return (id) transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    SlideCoverTransitionAnimation * transition = [[SlideCoverTransitionAnimation alloc] init];
    transition.dismissType = YES;
    return (id) transition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return (id) self.slideCoverDrivenInteractive.drivenInteractive;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return (id) self.pushInteractive;
}



- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
