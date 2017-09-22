//
//  SecondViewController.m
//  CJMutableArrayDemo
//
//  Created by 笨笨编程 on 2017/9/22.
//  Copyright © 2017年 chenxiaojie. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (copy, nonatomic) NSString *cStr;
@property (retain, nonatomic) NSString *rStr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testCopyAndRetain];
}

// copy 和 retain 的区别
- (void)testCopyAndRetain {
    NSString *str = @"笨笨编程";
    self.cStr = str;
    self.rStr = str;
    
    NSLog(@"\n str = %p,\n cStr = %p,\n rStr = %p", str, self.cStr, self.rStr);
    /* 输出结果：
     str = 0x106c78070,
     cStr = 0x106c78070,
     rStr = 0x106c78070
     */
    
    NSMutableString *mStr = [@"可变的笨笨编程" mutableCopy];
    self.cStr = mStr;
    self.rStr = mStr;
    
    NSLog(@"\n mStr = %p,\n cStr = %p,\n rStr = %p", mStr, self.cStr, self.rStr);
    /* 输出结果：
     mStr = 0x600000254850,
     cStr = 0x60000025dca0,
     rStr = 0x600000254850
     */
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
