//
//  SecondViewController.m
//  ThreadDemo
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "SecondViewController.h"

#define kTickets 10

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Back"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickAction:(id)sender {
    NSLog(@"点击了买票");
    tickets = kTickets;
    count = 0;
    mylock = [[NSLock alloc] init];
    condition = [[NSCondition alloc] init];
    
    threadOne = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [threadOne setName:@"thread-1"];
    [threadOne start];
    
    threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [threadTwo setName:@"thread-2"];
    [threadTwo start];
    
    threadThree = [[NSThread alloc] initWithTarget:self selector:@selector(run3) object:nil];
    [threadThree setName:@"thread-3"];
    [threadThree start];
    
    UIButton *button = (UIButton *)sender;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.enabled = NO;
}

- (IBAction)backAction:(id)sender {
    NSLog(@"回到首页");
    //cancel方法并不能exit线程，只是把线程标记为canceled，但线程并没有死掉。可以在条件中加入 thread.cancelled 来判断
    [threadOne cancel];
    [threadTwo cancel];
    [threadThree cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) run {
    while (TRUE) {
        // 上锁
        [condition lock];
        [condition wait];
//        [mylock lock];
        if (tickets > 0 && !threadThree.cancelled) {
            //  执行购票操作
            tickets--;
            [NSThread sleepForTimeInterval:0.09];
            count = kTickets - tickets;
            NSLog(@"当前剩余票数是%d张,售出票数:%d张,购票人是%@", tickets, count, [[NSThread currentThread] name]);
        } else {
            break;
        }
//        [mylock unlock];
        [condition unlock];
    }
}

-(void) run3 {
    while (YES) {
        [condition lock];
        [NSThread sleepForTimeInterval:2.0];
        [condition signal];
        [condition unlock];
    }
}

@end
