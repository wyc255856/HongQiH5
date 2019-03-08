//
//  JKWKWebViewController.h
//  Pods
//
//  Created by Jack on 17/4/1.
//
//

#import <UIKit/UIKit.h>
#import "H5WelcomeViewController.h"

@interface H5JKWKWebViewController : UIViewController{
    int nScreen;
}

@property (nonatomic, weak) id bottomViewController;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign, getter=isValue) BOOL isGoBack;

- (void)showLoadFailedAlert;
- (void)downLoadZip;
- (void)goSettingWebView;
- (void)exitH5View;
@end
