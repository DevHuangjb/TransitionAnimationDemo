//
//  ABNavigationDelegate.m
//  TransitionCircleUp
//
//  Created by huangjinbiao on 2017/8/29.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "ABNavigationDelegate.h"
#import "ABTransitionAnimation.h"


@interface ABNavigationDelegate ()<UINavigationControllerDelegate>
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation ABNavigationDelegate
//这个方法用来设置转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (self.navigationController.viewControllers.count == 1 && operation == UINavigationControllerOperationPop) return nil;
    
    ABTransitionAnimation * transition = [[ABTransitionAnimation alloc] init];
    transition.operation = operation;
    return (id)transition;
}

//这个方法用来设置转场进度
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return (id)self.interactionController;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIPanGestureRecognizer *panGeature = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:panGeature];
}

- (instancetype)initWithNavigationController:(UINavigationController *) nav{
    self = [super init];
    if (self) {
        _navigationController = nav;
        UIPanGestureRecognizer *panGeature = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panned:)];
        [_navigationController.view addGestureRecognizer:panGeature];
    }
    return self;
}

- (void)panned:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
            
        case UIGestureRecognizerStateBegan: {
            //向左拖拽不响应pop
            if ([panGesture velocityInView:self.navigationController.view].x < 0) return;
            //没有push的情况下不响应pop
            if (self.navigationController.viewControllers.count == 1) return;
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
            //push到子控制器，向右拖拽的情况下执行pop
            [self.navigationController popViewControllerAnimated:YES];
//            if (self.navigationController.viewControllers.count > 1) {
//                [self.navigationController popViewControllerAnimated:YES];
//            } else {
//                [self.navigationController.topViewController performSegueWithIdentifier:@"PushSegue" sender:nil];
//            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            CGPoint transition = [panGesture translationInView:self.navigationController.view];
            CGFloat completionProgress = transition.x / CGRectGetWidth(self.navigationController.view.bounds);
            //更新转场进度
            [self.interactionController updateInteractiveTransition:completionProgress];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            //松手瞬间向右拖拽，完成转场动画
            if ([panGesture velocityInView:self.navigationController.view].x > 0) {
                [self.interactionController finishInteractiveTransition];
            } else {//松手瞬间向左拖拽，取消转场动画
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            
            break;
        }
        default:
            //取消转场动画
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
            break;
    }
}

@end
