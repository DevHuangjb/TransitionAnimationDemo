//
//  SpreadController1.m
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "SpreadController2.h"
#import "ABNavigationDelegate.h"
@interface SpreadController2 ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@end

@implementation SpreadController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)popClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"SpreadController2 --- dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
