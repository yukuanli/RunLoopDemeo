//
//  Simulator.h
//  RunLoopDemo
//
//  Created by liyukuan on 2018/6/30.
//  Copyright © 2018年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;

+ (Task *)taskWithTarget:(id)target action:(SEL)action;

- (void)execute;

@end

@interface TaskList : NSObject

- (void)push:(Task *)task;
- (Task *)pop;

- (BOOL)isEmpty;

@end

@interface Simulator : NSObject

- (void)postTask:(Task *)task;

@end
