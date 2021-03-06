//
//  ABNavigationDelegate.h
//  TransitionCircleUp
//
//  Created by huangjinbiao on 2017/8/29.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABNavigationDelegate : NSObject

- (instancetype)initWithNavigationController:(UINavigationController *) nav;

@property (weak, nonatomic) UINavigationController *navigationController;

@end
