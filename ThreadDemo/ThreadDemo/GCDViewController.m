//
//  GCDViewController.m
//  ThreadDemo
//
//  Created by HEXSZ on 16/3/23.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController () {
    dispatch_queue_t serial_queue;
    dispatch_queue_t concurent_queue;
}

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRun:(id)sender {
    
    // 创建连续队列
    serial_queue = dispatch_queue_create("llh.DHL.MySerial", NULL);
    // 暂停队列
    dispatch_suspend(serial_queue);
    
    // 直接实现Block
    dispatch_async(serial_queue, ^{
        NSLog(@"连续任务一");
    });
    // 间接实现Block
    dispatch_block_t myBlock = ^{
        NSLog(@"连续任务二");
    };
    dispatch_async(serial_queue, myBlock);
    
    // 重新启用
    dispatch_resume(serial_queue);
    
    // 创建并发队列
    concurent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务001");});
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务002");});
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务003");});
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务004");});
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务005");});
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务006");});
    dispatch_async(concurent_queue, ^{ NSLog(@"并发任务007");});
}


@end
