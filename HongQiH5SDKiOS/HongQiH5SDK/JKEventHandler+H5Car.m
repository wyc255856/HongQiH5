//
//  JKEventHandler+Car.m
//  CarApp
//
//  Created by 张三 on 2018/3/30.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "JKEventHandler+H5Car.h"
#import <UIKit/UIKit.h>
#import "H5ShareManager.h"
#import "H5CarAppConstant.h"

@implementation H5JKEventHandler (H5Car)

/*
 首页设置按钮响应
 */
- (void)goSetPage:(id)params{
    //    NSLog(@"goSetPage :%@",params);
    
    //  是/否为在线
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults objectForKey:@"webviewH5LoadMode"] ){
        [userDefaults setInteger:MODE_ONLINE forKey:@"webviewH5LoadMode"];
        [userDefaults synchronize];
    }
    NSInteger nWebViewLoadMode = [[userDefaults objectForKey:@"webviewH5LoadMode"] integerValue];
    NSString *sCarName = [userDefaults objectForKey:@"chooseH5CarModelName"];
    
    
    //  是/否为有本地下载
    if(![userDefaults objectForKey:@"haveLocalH5Packaged"] ){
        [userDefaults setInteger:STATE_UNLOAD forKey:@"haveLocalH5Packaged"];
        [userDefaults synchronize];
    }
    NSInteger nHaveLocal = [[userDefaults objectForKey:@"haveLocalH5Packaged"] integerValue];
    
    //    1.设置请求路径
    NSString *urlBackStr=[NSString stringWithFormat:@"?model=%@&mode=%lu&haveLocalH5Packaged=%lu&version=v%@&upLoad=%@",sCarName,nWebViewLoadMode, nHaveLocal,[userDefaults objectForKey:@"H5LocalVersion"],[userDefaults objectForKey:@"upH5Load"]];
    //    NSString *sVisitor = [userDefaults objectForKey:@"H5Visitor"];
    //    if([@"YES" compare:sVisitor] == NSOrderedSame){
    //        [[JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",VisitorSettingURLByType(sCarName),urlBackStr]]]];
    //    }else{
    //        [[JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",SettingURLByType(sCarName),urlBackStr]]]];
    //    }
    
    NSString *sVisitor = [userDefaults objectForKey:@"H5Visitor"];
    if([@"YES" compare:sVisitor] == NSOrderedSame){
        [[H5JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",VisitorSettingURLByType(sCarName),urlBackStr]]]];
    }else{
        [[H5JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",SettingURLByType(sCarName),urlBackStr]]]];
    }
    
}

/*
 切换车类型响应
 手动..自动..
 */
- (void)selectModel:(id)params{
    //    NSLog(@"selectModel :%@",params);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger nWebViewLoadMode = [[userDefaults objectForKey:@"webviewH5LoadMode"] integerValue];
    // 在线模式 可以切换车型浏览
    if(nWebViewLoadMode == MODE_ONLINE){
        //    1.设置请求路径
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@/?upLoad=%@",BaseURL,params,[userDefaults objectForKey:@"upH5Load"]]]]];
        [userDefaults setObject:params forKey:@"chooseH5CarModelName"];
        [userDefaults synchronize];
    }
    
}

- (void)cleanCache:(id)params{
    //    NSLog(@"cleanCache");
    
}

/*
 在线离线按钮响应
 */
- (void)modeCheck:(id)params{
    //    NSLog(@"modeCheck :%@",params);
    //[[ShareManager shareInstance].wkWebVC showAlert];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"webviewH5LoadMode"];
    [userDefaults synchronize];
    
}

- (void)downloadZip:(id)params{
    //    NSLog(@"downloadZip");
    [[H5ShareManager shareInstance].wkWebVC downLoadZip];
    
}

- (void)getModel:(void(^)(id response))callBack{
    //    NSLog(@"getModel");
    NSString *str = @"Model";
    if(callBack){
        callBack(str);
    }
}

- (void)getMode:(void(^)(id response))callBack{
    //    NSLog(@"getMode");
    NSString *str = @"Mode";
    if(callBack){
        callBack(str);
    }
}

/*
 返回上一页
 */
- (void)goBack:(id)params{
    //    NSLog(@"goBack");
    if ([self.webView canGoBack]) {
        [H5ShareManager shareInstance].wkWebVC.isGoBack = YES;
        [self.webView goBack];
        // [self.webView reload];
        //        NSString *js = @"memoryNav()";
        //        [[JKEventHandler shareInstance].webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        //            NSLog(@"response: %@ error: %@", response, error);
        //        }];
    }
}

/*
 返回首页
 */
- (void)goHome:(id)params{
    //    NSLog(@"goHome");
    //判断webview是/否加载本地
    //依据：1、选择在线模式 2、本地有下载的资源包
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strCarName = [userDefaults objectForKey:@"chooseH5CarModelName"];
    NSInteger nHaveLocal =[[userDefaults objectForKey: @"haveLocalH5Packaged"] integerValue];
    NSInteger nWebViewLoadMode = [[userDefaults objectForKey:@"webviewH5LoadMode"] integerValue];
    
    if([userDefaults objectForKey:@"webviewH5LoadMode"]){
        if(nWebViewLoadMode){
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/?upLoad=%@",[H5ShareManager shareInstance].wkWebVC.url,[userDefaults objectForKey:@"upH5Load"]]]]];
        }else{
            NSString *strLocalCarName = [userDefaults objectForKey:@"localH5CarModelName"];
            NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/index.html",strLocalCarName]];
            [self.webView loadFileURL:temDirURL allowingReadAccessToURL:temDirURL];
        }
    }else{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/?upLoad=%@",[H5ShareManager shareInstance].wkWebVC.url,[userDefaults objectForKey:@"upH5Load"]]]]];
    }
}

/*
 退出应用程序
 */
- (void)exitApp:(id)params{
    [[H5ShareManager shareInstance].wkWebVC exitH5View];
}

/*
 下载资源包
 */
- (void)upLoad:(id)params{
    //    NSLog(@"upH5Load");
    [[H5ShareManager shareInstance].wkWebVC downLoadZip];
}



@end
