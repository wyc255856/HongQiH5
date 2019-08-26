//
//  H5CarAppConstant.h
//  CarApp
//
//  Created by Yu Chen on 2018/4/21.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#ifndef H5CarAppConstant_h
#define H5CarAppConstant_h

// 视图
#define kScreenWidth               ([UIScreen mainScreen].bounds.size.width)
/*
 iphoneX 底部虚拟home键高度 非安全区
 */
#define KIphoneXBottomOffset            (34)

/*
 1.若为iphoneX 机型 获取安全区域高度  计算方法为 812 - 34
 2.若为普通机型正常取值
 */
#define kScreenHeight                   ([UIScreen mainScreen].bounds.size.height>=812.0f?[UIScreen mainScreen].bounds.size.height-KIphoneXBottomOffset:[UIScreen mainScreen].bounds.size.height)

#define KScale                     ([UIScreen mainScreen].bounds.size.width/375.0f)
#define WeakSelf(x)                     __weak typeof(self) x = self

// 字体
#define CURRENTSYSTEM              ([[UIDevice currentDevice].systemVersion floatValue])
#define FIX_4_5(s)                (kScreenWidth > 320)? (s):(s - 1)
#define Font(s)                   ((CURRENTSYSTEM >= 9.0) ? [UIFont fontWithName:@"PingFangSC-Light" size:FIX_4_5(s)]: [UIFont systemFontOfSize:FIX_4_5(s)])

//上状态栏高
#define kStatusHeight                   ([[UIApplication sharedApplication] statusBarFrame].size.height)
//上导航栏宽高
#define kNavBarHeight                   ([[UINavigationController alloc]init].navigationBar.frame.size.height)

//导航高度
#define KNavBarHeight                   (kStatusHeight+kNavBarHeight)
// iphone X 适配   根据状态栏高度进行偏移24
#define kSafeAreaTopHeight              (kStatusHeight-20)

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

//判断iponex
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//在线车型首页web URL
#define BaseURL   (@"http://www.e-guides.faw.cn/HONGQIH5/")

//在线设置页面web URL
#define SettingURL   (@"http://www.e-guides.faw.cn/C217/C217_1/pages/set.html")
#define SettingURLByType(sType)   ([NSString stringWithFormat:@"%@%@/pages/settingPhone.html",BaseURL,sType])
#define VisitorSettingURLByType(sType)   ([NSString stringWithFormat:@"%@%@/pages/setting.html",BaseURL,sType])

// 是否下载本地资源包状态
typedef NS_ENUM(NSUInteger, nState) {
    STATE_UNLOAD = 0,   //未下载
    STATE_HAVE_LOAD     //已经下载
};

// 在线/离线选择状态
typedef NS_ENUM(NSUInteger, nMode) {
    MODE_OUTLINE = 0,   //离线模式
    MODE_ONLINE         //在线模式
};


//车型
#define typeManualComfortable       (@"HONGQIH5_1")//型动版
#define typeManualLuxury            (@"HONGQIH5_2")//智联灵动版
#define typeManualHonorable         (@"HONGQIH5_3")//智联韵动版
#define typeAutomaticComfortable    (@"HONGQIH5_4")//智联享动版
#define typeAutomaticLuxury         (@"HONGQIH5_5")//智联御动版
#define typeAutomaticHonorable      (@"C217_6")//自动尊贵
#define typeAutomaticUltimate       (@"C217_7")//自动旗舰

//通过车名称获取车型
#define kFuncGetCarTypeByCarName(sName)\
^(){NSDictionary *dic = @{\
@"HONGQIH5_1":@"HONGQIH5_1",\
@"HONGQIH5_2":@"HONGQIH5_2",\
@"HONGQIH5_3":@"HONGQIH5_3",\
@"HONGQIH5_4":@"HONGQIH5_4",\
@"HONGQIH5_5":@"HONGQIH5_5",};\
return dic[sName];\
}()


//
typedef NS_ENUM(NSUInteger, CarType) {
    ManualComfortable = 100001,
    ManualLuxury,
    ManualHonorable,
    AutomaticComfortable,
    AutomaticLuxury,
    AutomaticHonorable,
    AutomaticUltimate
};


#endif /* H5CarAppConstant_h */
