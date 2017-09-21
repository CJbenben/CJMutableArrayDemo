//
//  CJObj.h
//  CJMutableArrayDemo
//
//  Created by 笨笨编程 on 2017/9/21.
//  Copyright © 2017年 chenxiaojie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJObj : NSObject<NSCopying, NSMutableCopying>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;

@end
