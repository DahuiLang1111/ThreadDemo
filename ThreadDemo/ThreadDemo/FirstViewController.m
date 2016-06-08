//
//  FirstViewController.m
//  ThreadDemo
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "OperationViewController.h"

#define kURL @"http://static.7192.com/upload/poco/2015/0805/211128GRknmfyv.jpeg"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"NSThread 加载图片";
    
    self.imageView.alpha = 0.0;
    
    /* NSThread： 
     * 优点:比其他两个（NSOperation，GCD）更轻量级
     * 缺点:需要自己管理线程的生命周期,线程同步。线程同步对数据加锁会有一定的系统开销
     
     */
    
    // 方法①先创建线程对象,然后再运行线程操作
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:kURL];
    NSLog(@"线程创建完成，开始启动");
    [thread start];
    // 方法②直接创建线程对象并且开始运行线程
    //[NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:kURL];
}

-(void) downloadImage:(NSString *)url {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        
    } else {
        // 隐式的创建线程   一般更新UI的操作都会放在主线程MainThread中做
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
}

-(void)updateUI:(UIImage *)image {
    [UIView animateWithDuration:2.0 animations:^{
        self.imageView.alpha = 1.0;
        self.imageView.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buyAction:(id)sender {
    SecondViewController *secVC = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self presentViewController:secVC animated:YES completion:nil];
}


- (IBAction)toOperationAction:(id)sender {
    OperationViewController *operVC = [[OperationViewController alloc] initWithNibName:@"OperationViewController" bundle:nil];
    [self presentViewController:operVC animated:YES completion:nil];
}
@end
