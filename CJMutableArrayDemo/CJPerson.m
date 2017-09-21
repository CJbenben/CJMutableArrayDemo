//
//  CJPerson.m
//  20170921CJMutableArrayDemo
//
//  Created by 笨笨编程 on 2017/9/21.
//  Copyright © 2017年 chenxiaojie. All rights reserved.
//

#import "CJPerson.h"

@implementation CJPerson

- (void)setSAry:(NSArray *)sAry {
    if (_sAry != sAry) {
        [_sAry release];
        _sAry = [sAry retain]; // 指针拷贝，浅拷贝
    }
}

- (void)setCAry:(NSArray *)cAry {
    if (_cAry != cAry) {
        [_cAry release];
        _cAry = [cAry copy]; // 内容拷贝，深拷贝
    }
}

@end
