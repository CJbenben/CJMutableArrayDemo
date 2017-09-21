//
//  CJObj.m
//  CJMutableArrayDemo
//
//  Created by 笨笨编程 on 2017/9/21.
//  Copyright © 2017年 chenxiaojie. All rights reserved.
//

#import "CJObj.h"

@implementation CJObj

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CJObj *obj = [[CJObj alloc] init];
    if (obj) {
        obj.name = self.name;
        obj.icon = [self.icon copyWithZone:zone];
    }
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    CJObj *obj = [[CJObj alloc] init];
    if (obj) {
        obj.name = self.name;
        obj.icon = [self.icon mutableCopyWithZone:zone];
    }
    return obj;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@ icon = %@", self.name, self.icon];
}

@end
