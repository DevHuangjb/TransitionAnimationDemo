//
//  ABModalTransitionAnimation.m
//  TransitionCircleUp
//
//  Created by huangjinbiao on 2017/8/29.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "ABModalTransitionAnimation.h"

@interface ABModalTransitionAnimation()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (weak, nonatomic) id transitionContext;

@end

@implementation ABModalTransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = nil;
    UIViewController *toVC = nil;
    UINavigationController * nav = nil;
    
    self.transitionContext = transitionContext;
    
    if (self.dismissType) {
//        nav = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        toVC = nav.viewControllers.lastObject;
        fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.duration = [self transitionDuration:transitionContext];
        //设置图层的 "属性"来 决定 "动画类型"
        animation.keyPath = @"position.y";
        //设置bounds尺寸变化后的大小
        animation.toValue = [NSNumber numberWithInt:1.5 * [UIScreen mainScreen].bounds.size.height];
        animation.fromValue = [NSNumber numberWithInt:0.5*[UIScreen mainScreen].bounds.size.height];
        //解决方案1： 动画的代理
        animation.delegate = self;
        [fromVC.view.layer addAnimation:animation forKey:nil];
    }else{
        UIView *containerView = [transitionContext containerView];
        toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [containerView addSubview:toVC.view];
        toVC.view.frame = [UIScreen mainScreen].bounds;
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.duration = [self transitionDuration:transitionContext];
        //设置图层的 "属性"来 决定 "动画类型"
        animation.keyPath = @"position.y";
        //设置bounds尺寸变化后的大小
        animation.toValue = [NSNumber numberWithInt:0.5 * [UIScreen mainScreen].bounds.size.height];
        animation.fromValue = [NSNumber numberWithInt:-0.5*[UIScreen mainScreen].bounds.size.height];
        //解决方案1： 动画的代理
        animation.delegate = self;
        [toVC.view.layer addAnimation:animation forKey:nil];
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
}

@end
