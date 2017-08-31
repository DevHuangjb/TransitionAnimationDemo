//
//  SlideCoverDrivenInteractive.m
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "SlideCoverDrivenInteractive.h"

@interface SlideCoverDrivenInteractive()

@property (nonatomic,weak) UIViewController *vc;

@property (nonatomic,assign) BOOL up;



@end

@implementation SlideCoverDrivenInteractive

+ (instancetype)drivenInteractiveWithController:(UIViewController *) vc gestureDirection:(BOOL) up{
    return  [[self alloc] initWithController:vc gestureDirection:up];
}

- (instancetype)initWithController:(UIViewController *) vc gestureDirection:(BOOL) up{
    self = [super init];
    if (self) {
        _vc = vc;
        _up = up;
        [self addPanGesture];
    }
    return self;
}

- (void)addPanGesture{
    UIPanGestureRecognizer *panGeature = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panned:)];
    [self.vc.view addGestureRecognizer:panGeature];
}

- (void)panned:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
            
        case UIGestureRecognizerStateBegan: {
            //当监听的是手势方向向上，实际手势方向向下，不响应。
            if (self.up && [panGesture velocityInView:self.vc.view].y > 0) return;
            if (!self.up && [panGesture velocityInView:self.vc.view].y < 0) return;
            //实例化一个进度管理
            self.drivenInteractive = [[UIPercentDrivenInteractiveTransition alloc]init];
            if (_toogleBlock) {
                _toogleBlock();
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            CGPoint transition = [panGesture translationInView:self.vc.view];
            CGFloat completionProgress = transition.y / CGRectGetHeight(self.vc.view.bounds);
            if (self.up) completionProgress = -completionProgress;
            //更新转场进度
            [self.drivenInteractive updateInteractiveTransition:completionProgress];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            //松手瞬间向右拖拽，完成转场动画
            if (self.up) {
                if ([panGesture velocityInView:self.vc.view].y < 0) {
                    [self.drivenInteractive finishInteractiveTransition];
                } else {//松手瞬间向左拖拽，取消转场动画
                    [self.drivenInteractive cancelInteractiveTransition];
                }
            }else{
                if ([panGesture velocityInView:self.vc.view].y > 0) {
                    [self.drivenInteractive finishInteractiveTransition];
                } else {//松手瞬间向左拖拽，取消转场动画
                    [self.drivenInteractive cancelInteractiveTransition];
                }
            }

            self.drivenInteractive = nil;
            
            break;
        }
        default:
            //取消转场动画
            [self.drivenInteractive cancelInteractiveTransition];
            self.drivenInteractive = nil;
            break;
    }
}


@end
