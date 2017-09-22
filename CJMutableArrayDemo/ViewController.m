//
//  ViewController.m
//  20170921CJMutableArrayDemo
//
//  Created by 笨笨编程 on 2017/9/21.
//  Copyright © 2017年 chenxiaojie. All rights reserved.
//

#import "ViewController.h"
#import "CJPerson.h"
#import "CJObj.h"

@interface ViewController ()

@property (copy, nonatomic) NSMutableArray *copAry;

@property (strong, nonatomic) NSArray *arr1;
@property (strong, nonatomic) NSArray *arr11;
@property (copy, nonatomic) NSArray *arr2;
@property (copy, nonatomic) NSArray *arr22;

@end

@implementation ViewController

- (void)test01 {
    NSArray *array = @[@1,@2,@3,@4];
    
    NSArray *copyArr = [array copy];
    NSArray *mCopyArr = [array mutableCopy];
    
    NSMutableArray *mcArr = [array copy];
    NSMutableArray *mmCopyArr = [array mutableCopy];
    
    NSLog(@"array:%p--copyArr:%p--mCopyArr:%p--mcArr:%p---mmCopyArr:%p",array,copyArr,mCopyArr,mcArr,mmCopyArr);
    
    /*  输出结果
     array:     0x60000024ce10
     copyArr:   0x60000024ce10
     mCopyArr:  0x60000024cd80
     mcArr:     0x60000024ce10
     mmCopyArr: 0x60000024ce70
     */
    
}

- (void)test02 {
    NSArray *tarray = @[@1,@2,@3,@4];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:tarray];
    
    NSArray *copyArr = [array copy];
    NSArray *mCopyArr = [array mutableCopy];
    
    NSMutableArray *mcArr = [array copy];
    NSMutableArray *mmCopyArr = [array mutableCopy];
    
    NSLog(@"array:%p--copyArr:%p--mCopyArr:%p--mcArr:%p---mmCopyArr:%p",array,copyArr,mCopyArr,mcArr,mmCopyArr);
    /* 输出结果
     array:     0x60000024cd20
     copyArr:   0x60000024cc90
     mCopyArr:  0x60000024ce40
     mcArr:     0x60000024cde0
     mmCopyArr: 0x60000024d020
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self testCash];
    [self testStrongAndCopy];
    
    [self testUserCopyWithAry];
    
    [self test01];
    [self test02];
    
    [self testDeepCopy];
    
    [self copyConstruct];
    
}

// 拷贝构造
- (void)copyConstruct {
    CJObj *obj = [[CJObj alloc] init];
    obj.name = @"zhangsan";
    obj.icon = @"icon";
    
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *copyAry = [NSMutableArray array];
    [arr addObject:obj];
    
    [copyAry addObject:[arr[0] copy]];
    //[copyAry addObject:[arr[0] mutableCopy]];

    
    CJObj *obj2 = arr[0];
    obj2.name = @"lisi";
    obj2.icon = @"obj2_icon";
    
    NSLog(@"arr.name = %@, arr.icon = %@", ((CJObj *)arr[0]).name, ((CJObj *)arr[0]).icon);
    NSLog(@"copyArr.name = %@, copyArr.icon = %@", ((CJObj *)[copyAry objectAtIndex:0]).name, ((CJObj *)[copyAry objectAtIndex:0]).icon);
    
    /* 输出结果：
         arr.name = lisi, arr.icon = obj2_icon
         copyArr.name = zhangsan, copyArr.icon = icon
     */
     
}

// 深拷贝
- (void)testDeepCopy {
    NSString *str = @"abcdefg";
    NSString *cStr = [str copy];
    NSMutableString *mStr = [str mutableCopy];
    [mStr appendString:@"!!"];
    NSLog(@"\n str = %@ = %p,\n cStr = %@ = %p,\n mStr = %@ = %p", str, str, cStr, cStr, mStr, mStr);
    /* 输出结果：
     str = abcdefg = 0x10a9b5150,
     cStr = abcdefg = 0x10a9b5150,
     mStr = abcdefg!! = 0x6040002455e0
     */
}

// 为什么 NSArray 需要使用 copy
- (void)testUserCopyWithAry {
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(1), @(2), @(3), nil];
    self.arr1 = arr;
    self.arr2 = arr;
    
    [arr addObject:@(4)];
    NSLog(@"arr1 = %@, arr2 = %@", self.arr1, self.arr2);
    
    /* 输出结果：
     arr1 = (
         1,
         2,
         3,
         4
     ), arr2 = (
         1,
         2,
         3
     )
     简直白的说就是：如果定义一个数组，使用 strong 来修饰的话，如果这个数组在外界被修改的话，那么这个用 strong 修改的数组变量的值也会跟着变化。为什么？还是因为 strong 进行了指针拷贝。在内存中，两个变量指向的是同一块内存地址。
     */
    
    NSLog(@"**********************");
    // 基本上到这里应该结束了，但是有意思的是。我们先看一下 arr 现在是什么内容：
    NSLog(@"arr = %@", arr);
    // arr: 1 2 3 4
    
    // 如果我们此时不使用 self. 的方式访问属性，而直接使用 _ 方式访问变量
    _arr11 = arr;
    _arr22 = arr;
    
    [arr addObject:@(5)];
    NSLog(@"_arr11 = %@, _arr22 = %@", _arr11, _arr22);
    
    /* 输出结果：
     _arr11 = (
         1,
         2,
         3,
         4,
         5
     ), _arr22 = (
         1,
         2,
         3,
         4,
         5
     )
     很奇怪的现象发现了，_arr11 和 _arr22 的值竟然一样。既然一样的话，说明 _arr11 和 _arr22 在内存中指向的地址和 arr 在内存中的指向的地址在同一块。那么，换句话说使用 self. 和 _ 访问变量的一个区别是：_ 对应的 ARC 下 setter 方法只进行了指针拷贝，并没有进行深拷贝，而 self. 在 ARC 下对应的 setter 方法是根据 property 的修饰词来判断的。
     */
}

// 对 strong 和 copy 的理解
- (void)testStrongAndCopy {
    NSMutableArray *names = [@[@"zhangsan"] mutableCopy];
    CJPerson *person = [[CJPerson alloc] init];
    person.sAry = names;// strong
    person.cAry = names;// copy
    
    [names addObject:@"lisi"];
    NSLog(@"sAry = %@, cAry = %@", person.sAry, person.cAry);
    
    
    /* 输出结果：
     sAry = (
         zhangsan,
         lisi
     ), cAry = (
         zhangsan
     )
     归根结底之所以出现这样问题，那是因为 ARC 情况下 strong 和 copy 对属性 setter 方法重写的区别。
     strong: setter 时调用了 [sAry retain] 方法，实现了指针拷贝，也就是浅拷贝。
     copy:   setter 时调用了 [cAry copy] 方法，实现了内容拷贝，也就是深拷贝。
     具体可以看内存地址图详解：
     */
    
}

// 直接崩溃测试
- (void)testCash {
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
    self.copAry = arr;
    [self.copAry removeObject:@1];
    NSLog(@"self.copyAry = %@", self.copAry);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
