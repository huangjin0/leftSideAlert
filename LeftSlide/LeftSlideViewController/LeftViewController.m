//
//  LeftViewController.m
//  LeftSlide
//
//  Created by HuangJin on 16/2/23.
//  Copyright © 2016年 eamon. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];

self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回去" style:UIBarButtonItemStylePlain target:self action:@selector(backleftMenu)];
// Do any additional setup after loading the view.
}
-(void)backleftMenu
{
    [self.navigationController popViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"left" object:nil userInfo:nil];
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

@end
