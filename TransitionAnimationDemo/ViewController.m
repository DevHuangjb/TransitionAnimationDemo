//
//  ViewController.m
//  TransitionAnimationDemo
//
//  Created by huangjinbiao on 2017/8/31.
//  Copyright © 2017年 dajiaying. All rights reserved.
//

#import "ViewController.h"
#import "SpreadController1.h"
#import "PresentController.h"
#import "SlideCover1.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * dataList;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataList = @[@"push:点击放大",@"modal:向下推",@"slideUp"];
}

#pragma mark - tableView's delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [[SpreadController1 alloc] init];
            break;
        case 1:
            vc = [[PresentController alloc] init];
            break;
        case 2:
            vc = [[SlideCover1 alloc] init];
            break;
            
        default:
            vc = [[SpreadController1 alloc] init];
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - tableView's datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const rootCellId = @"rootCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rootCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rootCellId];
    }
    cell.textLabel.text = _dataList[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
