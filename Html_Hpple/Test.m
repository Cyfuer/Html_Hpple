//
//  Test.m
//  Html_Hpple
//
//  Created by Cyfuer on 16/11/26.
//  Copyright © 2016年 com.wangan. All rights reserved.
//

#import "Test.h"

@implementation Test

- (Test *)a {
    Test *a = [[Test alloc] init];
    a.superTest = self;
    a.name = [NSString stringWithFormat:@"%@a",self.name];
    return a;
}

@end
