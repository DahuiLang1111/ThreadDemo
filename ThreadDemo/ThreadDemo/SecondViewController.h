//
//  SecondViewController.h
//  ThreadDemo
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController {
    int tickets;
    int count;
    NSThread *threadOne;
    NSThread *threadTwo;
    NSThread *threadThree;
    NSCondition *condition;
    NSLock *mylock;
}

- (IBAction)clickAction:(id)sender;

- (IBAction)backAction:(id)sender;


@end
