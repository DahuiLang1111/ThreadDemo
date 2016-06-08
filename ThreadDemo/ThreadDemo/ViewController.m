//
//  ViewController.m
//  ThreadDemo
//
//  Created by HEXSZ on 16/3/21.
//  Copyright © 2016年 大辉郎. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "OperationViewController.h"
#import "GCDViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *typeList;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"iOS线程";
    // get data
    typeList = [[NSArray alloc] initWithObjects:@"NSThread", @"NSOperation", @"GCD", nil];
    
    CGFloat sfw = self.view.frame.size.width;
    CGFloat sfh = self.view.frame.size.height;
    // creat tableView
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, sfw, sfh) style:UITableViewStylePlain];
    tabView.dataSource = self;
    tabView.delegate = self;
    [self.view addSubview:tabView];
}

#pragma mark - TableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return typeList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"typeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = typeList[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row = %d", (int)indexPath.row);
    switch (indexPath.row) {
        case 0:
        {
            FirstViewController *first = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
        case 1:
        {
            OperationViewController *operVc = [[OperationViewController alloc] initWithNibName:@"OperationViewController" bundle:nil];
            [self.navigationController pushViewController:operVc animated:YES];
        }
            break;
        case 2:
        {
            GCDViewController *gcdVc = [[GCDViewController alloc] initWithNibName:@"GCDViewController" bundle:nil];
            [self.navigationController pushViewController:gcdVc animated:YES];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
