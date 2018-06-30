//
//  ViewController.m
//  RunLoopDemo
//
//  Created by liyukuan on 2018/6/28.
//  Copyright © 2018年 tencent. All rights reserved.
//

#import "ViewController.h"
#import "SimulatorViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialize];
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntry) object:nil];
    [self.thread start];
}

- (void)threadEntry {
    NSRunLoop *curRunLoop = [NSRunLoop currentRunLoop];
    [curRunLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [curRunLoop run];
}

- (void)doSomething {
    [self performSelector:@selector(work) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)work {
    NSLog(@"working");
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
    
    UIButton *jump = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    jump.frame = CGRectMake(10, 200, 60, 24);
    [jump setTitle:@"jump" forState:UIControlStateNormal];
    [jump setTitle:@"jump" forState:UIControlStateSelected];
    [jump setTitle:@"jump" forState:UIControlStateHighlighted];
    [self.view addSubview:jump];
    [jump addTarget:self action:@selector(jumpClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)workClicked:(UIButton *)sender {
    [self doSomething];
}

- (void)jumpClicked:(UIButton *)sender {
    SimulatorViewController *vc = [[SimulatorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
