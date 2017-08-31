//
//  SlideCoverDrivenInteractive.h
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SlideCoverDrivenInteractive : NSObject

@property (strong, nonatomic) void(^toogleBlock)(void);

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *drivenInteractive;

+ (instancetype)drivenInteractiveWithController:(UIViewController *) vc gestureDirection:(BOOL) up;

@end
