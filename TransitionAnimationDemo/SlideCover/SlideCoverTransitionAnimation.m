//
//  SlideCoverTransitionAnimation.m
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "SlideCoverTransitionAnimation.h"
#import "UIView+Extension.h"

@interface SlideCoverTransitionAnimation()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (weak, nonatomic) id transitionContext;

@end

@implementation SlideCoverTransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    if (!self.dismissType) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，如果不需要实现手势的话，就可以不是用截图视图了
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        tempView.frame = fromVC.view.frame;
        //因为对截图做动画，vc1就可以隐藏了
        fromVC.view.hidden = YES;
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:tempView];
        [containerView addSubview:toVC.view];
        toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
        //开始动画吧，使用产生弹簧效果的动画API
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
            toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
            tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        } completion:^(BOOL finished) {
            //我们必须标记转场的状态，系统才知道处理转场后的操作，否则认为你一直还在，会出现无法交互的情况
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            //转场失败后的处理
            if ([transitionContext transitionWasCancelled]) {
                fromVC.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    }else{
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //参照present动画的逻辑，present成功后，containerView的倒数第二个子视图就是截图视图，我们将其取出准备动画
        UIView *containerView = [transitionContext containerView];
        NSArray *subviewsArray = containerView.subviews;
        UIView *tempView = subviewsArray[subviewsArray.count - 2];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.transform = CGAffineTransformIdentity;
            tempView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                //转场成功,vc1显示出来，移除截屏
                [transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
}

@end
