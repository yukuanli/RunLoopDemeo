//
//  SimulatorViewController.m
//  RunLoopDemo
//
//  Created by liyukuan on 2018/6/30.
//  Copyright © 2018年 tencent. All rights reserved.
//

#import "SimulatorViewController.h"
#import "Simulator.h"

@interface SimulatorViewController ()

@property (nonatomic, strong) Simulator *simulator;
@end

@implementation SimulatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialize];
    _simulator = [[Simulator alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialize {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 100, 60, 24);
    [btn setTitle:@"work" forState:UIControlStateNormal];
    [btn setTitle:@"work" forState:UIControlStateSelected];
    [btn setTitle:@"work" forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(workClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)workClicked:(UIButton *)sender {
    [self.simulator postTask:[Task taskWithTarget:self action:@selector(work)]];
}

- (void)work {
    NSLog(@"I'm working on custom message queue");
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
