//
//  ShareManager.m
//  CarApp
//
//  Created by 张三 on 2018/4/4.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "ShareManager.h"

@implementation ShareManager

+ (instancetype)shareInstance{
    static ShareManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Network activity indicator manager setup
        shareInstance = [self new];
        
    });
    return shareInstance;
}

- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}


@end
