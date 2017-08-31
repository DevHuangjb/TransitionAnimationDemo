//
//  ABTransitionAnimation.m
//  TransitionCircleUp
//
//  Created by huangjinbiao on 2017/8/29.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "ABTransitionAnimation.h"
#import "SpreadController1.h"
#import "SpreadController2.h"

@interface ABTransitionAnimation()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (weak, nonatomic) id transitionContext;

@end

@implementation ABTransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    SpreadController1 *vc1 = nil;
    SpreadController2 *vc2 = nil;
    UIViewController * fromVc = nil;
    UIViewController * toVc = nil;
    UIButton *btn = nil;
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    if (self.operation == UINavigationControllerOperationPush) {
        fromVc = vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        toVc = vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = vc1.btn;
        
    }else {
        fromVc = vc2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        toVc = vc1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = vc2.btn;
    }
    
    //初始椭圆
    UIBezierPath *originPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    //以初始椭圆为圆心，算出能覆盖整个屏幕的椭圆的最小半径坐标（x,y）
//    NSLog(@"%@----%@",NSStringFromCGRect(toVc.view.bounds),NSStringFromCGPoint(btn.center));
    CGPoint extremePoint = CGPointMake(btn.center.x - 0, CGRectGetHeight(toVc.view.bounds) - btn.center.y);
    //算出最小半径
    float radius = sqrtf(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
    //以初始椭圆的圆心算出最终路径
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //遮罩的最终路径,没设置默认0，则弹出的视图无法显示
    maskLayer.path = finalPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    
    
    if (self.operation == UINavigationControllerOperationPush) {
        [containerView addSubview:toVc.view];
        toVc.view.frame = [UIScreen mainScreen].bounds;
        toVc.view.layer.mask = maskLayer;
        
        animation.fromValue = (__bridge id _Nullable)(originPath.CGPath);
        animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
        
    }else {
        
        [containerView insertSubview:toVc.view belowSubview:fromVc.view];
        fromVc.view.layer.mask = maskLayer;
        
        animation.toValue = (__bridge id _Nullable)(originPath.CGPath);
        animation.fromValue = (__bridge id _Nullable)(finalPath.CGPath);
    }
    
    [maskLayer addAnimation:animation forKey:@"path"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //动画完毕，清除遮罩
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}


@end
