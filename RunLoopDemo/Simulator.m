//
//  Simulator.m
//  RunLoopDemo
//
//  Created by liyukuan on 2018/6/30.
//  Copyright © 2018年 tencent. All rights reserved.
//

#import "Simulator.h"

// implementation of Task
@implementation Task

+ (Task *)taskWithTarget:(id)target action:(SEL)action {
    Task *task = [[Task alloc] init];
    task.target = target;
    task.action = action;
    return task;
}

- (void)execute {
    [self.target performSelector:self.action];
}

@end

// implementation of TaskList
@interface TaskList ()

@property (nonatomic, strong) NSMutableArray *taskArray;

@end

@implementation TaskList

- (instancetype)init {
    self = [super init];
    _taskArray = [[NSMutableArray alloc] init];
    return self;
}

- (void)push:(Task *)task {
    [self.taskArray addObject:task];
}

- (Task *)pop {
    Task *task = [self.taskArray firstObject];
    [self.taskArray removeObject:task];
    return task;
}

- (BOOL)isEmpty {
    return self.taskArray.count == 0;
}

@end

// implementation of Simulator
@interface Simulator ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, strong) TaskList *taskList;

@property (nonatomic, strong) NSCondition *condition;

@property (atomic, assign) BOOL shouldExit;
@end

@implementation Simulator

- (instancetype)init {
    self = [super init];
    self.taskList = [[TaskList alloc] init];
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntry) object:nil];
    [self.thread start];
    self.condition = [[NSCondition alloc] init];
    return self;
}

- (void)threadEntry {
    while (!self.shouldExit) {
        [_condition lock];
        if ([self.taskList isEmpty]) {
            [_condition wait];
        }
        
        Task *task = nil;
        if (![self.taskList isEmpty]) {
            task = [self.taskList pop];
        }
        [_condition unlock];
        [task execute];
    }
}

- (void)postTask:(Task *)task {
    [_condition lock];
    [self.taskList push:task];
    [_condition signal];
    [_condition unlock];
}

- (void)quit {
    self.shouldExit = YES;
    [_condition signal];
}
@end
