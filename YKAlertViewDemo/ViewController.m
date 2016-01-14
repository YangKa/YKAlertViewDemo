//
//  ViewController.m
//  YKAlertViewDemo
//
//  Created by qianzhan on 16/1/14.
//  Copyright © 2016年 qianzhan. All rights reserved.
//

#import "ViewController.h"
#import "YKAlertController.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
}


- (IBAction)showAlertView:(id)sender {
    
    YKAlertController *alert = [[YKAlertController alloc] initWithTitle:@"提示" message:@"上海警方了解客户的空间黑色大翻领宽松大号发大会开始发挥乐山大佛说的话就发觉圣诞快乐返回撒的看法时的空间回复飞机离开说分手的" alertStyle:YKAlertStyleDispaly];
    [alert addAction:[YKAction actionWithTitle:@"取消" action:^{
    }]];
    [alert addAction:[YKAction actionWithTitle:@"确定" action:^{
    }]];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *inputField = [alertView textFieldAtIndex:0];
    NSLog(@"--------%@", inputField.text);
}

- (IBAction)showCustomAlertView:(id)sender {
    
    YKAlertController *alert = [[YKAlertController alloc] initWithTitle:@"提示" message:@"上海警方了解到手上飞机离开说分手的" alertStyle:YKAlertStyleInput];
    
    [alert addAction:[YKAction actionWithTitle:@"取消" action:^{
        
    }]];
    [alert addAction:[YKAction actionWithTitle:@"确定" action:^{
        
        NSLog(@"%@", alert.inputContent);
        
    }]];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
