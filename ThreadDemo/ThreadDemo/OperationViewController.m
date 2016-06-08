//
//  OperationViewController.m
//  ThreadDemo
//
//  Created by HEXSZ on 16/3/22.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "OperationViewController.h"

//#define kURL @"http://s13.sinaimg.cn/mw690/001HnGqBgy6PdMReG5Kac&690"
#define kURL @"http://hk.iwall365.com/iPhoneWallpaper/640x1136/1308/Cute-angel-baby_640x1136_iPhone_5_wallpaper.jpg"


@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"NSOperation 加载图片";
    
    self.imageView.alpha = 0.0;
    
    /* NSOperation
     * 优点: 不需要关心线程管理，数据同步的事情，可以把精力放在自己需要执行的操作上。
     * NSOperation是个抽象类 需要用到它的子类（NSInvocationOperation和NSBlockOperation）或者实现它;
     * NSOperationQueue操作队列 相当于一个线程池 可以通过setMaxConcurrentOperationCount设置并发操作数
     */
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:kURL];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是一个Block!!!!!!!!!!!");
    }];
    // 操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue setMaxConcurrentOperationCount:5];
    
    [operationQueue addOperation:invocation];
    [operationQueue addOperation:blockOperation];
    [operationQueue addOperationWithBlock:^{
        NSLog(@"这是另一个Block");
    }];
}


-(void)downloadImage:(NSString *) url{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        
    } else {
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
}

-(void) updateUI:(UIImage *)image {
    [UIView animateWithDuration:2.0 animations:^{
        self.imageView.alpha = 1.0;
        self.imageView.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backHomeAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
