//
//  ShareManager.h
//  CarApp
//
//  Created by 张三 on 2018/4/4.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "H5JKWKWebViewController.h"
#import <UIKit/UIKit.h>

@interface H5ShareManager : NSObject
@property (nonatomic,strong) H5JKWKWebViewController *wkWebVC;     //当前的VC
+ (instancetype) shareInstance;
- (BOOL)isBlankString:(NSString *)aStr;
@end