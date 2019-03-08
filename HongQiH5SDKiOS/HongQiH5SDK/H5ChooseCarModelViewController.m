//
//  ChooseCarModelViewController.m
//  CarApp
//
//  Created by Yu Chen on 2018/4/21.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "H5ChooseCarModelViewController.h"
#import "H5CarAppConstant.h"
#import "H5CAR_AFNetworking.h"
#import "UIView+H5CARAdd.h"
#import "UIColor+H5CARUtil.h"
#import "UIView+H5frameAdjust.h"
#import  "H5JKWKWebViewHandler.h"
#import "H5JKWKWebViewController.h"

@interface H5ChooseCarModelViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView   *bgImageView;   //背景图片
@property (nonatomic, strong) UILabel       *topTitleLabel;      //请选择当前车型
@property (nonatomic, strong) UIView        *searchView;     //显示选项框
@property (nonatomic, strong) UILabel       *searchViewLabel;//显示所选车型
@property (nonatomic, strong) UIButton      *searchViewBtn;//显示所选车型
@property (nonatomic, strong) UIButton      *closeBtn;//关闭按钮
@property (nonatomic, strong) UIButton      *submitBtn;//进入H5页面按钮
@property (nonatomic, strong) UIView        *chooseCarModelView;    //选项
@property (nonatomic, assign) BOOL          showChooseCarModelView;//是否显示选项
@property (nonatomic, assign) NSInteger     chooseCarModelIndex;//用来记录选择了什么车型


@end

@implementation H5ChooseCarModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showChooseCarModelView = false;
    self.chooseCarModelIndex = 100001;
    [self configView];
    
}

- (void)configView {
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.searchView];
    //[self.view addSubview:self.topTitleLabel];
    //[self.view addSubview:self.closeBtn];
    //[self.view addSubview:self.submitBtn];
    [self.view addSubview:self.chooseCarModelView];
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [bundle URLForResource:@"H5CarResource" withExtension:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
        NSString *resNameBg = @"bg_style_1";
        UIImage *imageBg =  resourceBundle?[UIImage imageNamed:resNameBg inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameBg];

        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgImageView.image = imageBg;
    }
    return _bgImageView;
}

- (UILabel *)topTitleLabel {
    if (!_topTitleLabel) {
        _topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _searchView.top - 30*KScale, kScreenWidth, 20*KScale)];
        _topTitleLabel.textColor = [UIColor whiteColor];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.font = [UIFont systemFontOfSize:12*KScale];
        _topTitleLabel.text = @"请选择当前车型";
    }
    return _topTitleLabel;
}

- (UIView *)searchView {
    if (!_searchView) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [bundle URLForResource:@"H5CarResource" withExtension:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
  
        //        _searchView = [[UIView alloc] initWithFrame:CGRectMake(100*KScale, _topTitleLabel.bottom + 10*KScale, 150*KScale, 20*KScale)];
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.5, 20*KScale)];
        _searchView.centerX = self.view.centerX;
        
        //适配iponex  强行适配有问题啊！*******************
        if(KIsiPhoneX){
            _searchView.centerY = self.view.centerY+1.5*KScale;
        }else{
            _searchView.centerY = self.view.centerY+ 2*KScale;
        }
        
        //_searchView.backgroundColor = [UIColor colorWithHexString:@"#09497b"];
        _searchView.layer.borderWidth = 1;
        _searchView.layer.borderColor = [[UIColor colorWithHexString:@"#c7d7ed"] CGColor];
        _searchView.layer.cornerRadius = 10;
        
        _searchView.layer.shadowColor = [[UIColor colorWithHexString:@"#c7d7ed"] CGColor];
        _searchView.layer.shadowOpacity = 1;
        _searchView.layer.shadowRadius = 5;
        _searchView.layer.shadowOffset = CGSizeMake(0, 0);
        
        
        //添加左侧的文字展示
        _searchViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(_searchView.size.width/2-50*KScale, 0, 100*KScale, 20*KScale)];
        //_searchViewLabel.center = _searchView.center;
        _searchViewLabel.text = @"请选择车辆版本";
        _searchViewLabel.textColor = [UIColor whiteColor];
        _searchViewLabel.textAlignment = NSTextAlignmentLeft;
        _searchViewLabel.font = [UIFont systemFontOfSize:10*KScale];
        _searchViewLabel.userInteractionEnabled = false;
        [_searchView addSubview:_searchViewLabel];
        
        //添加右侧的按钮
        _searchViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(_searchView.width-29*KScale, KScale, 28*KScale, 18*KScale)];//按钮周围边框留空1像素
        _searchViewBtn.userInteractionEnabled = false;
        // 图片名称
        NSString *resNameSearch = @"button_select_car_down";
        UIImage *imageSearch =  resourceBundle?[UIImage imageNamed:resNameSearch inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameSearch];
        [_searchViewBtn setImage:imageSearch forState: UIControlStateNormal];
        // _searchViewBtn.backgroundColor =  [UIColor colorWithHexString:@"#5380a3"];
        //        _searchViewBtn.layer.borderWidth = 1;
        //        _searchViewBtn.layer.borderColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
        //        _searchViewBtn.layer.cornerRadius = 18;
        //        _searchViewBtn.layer.cornerRadius = 16;
        //        _searchViewBtn.layer.shadowColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
        //        _searchViewBtn.layer.shadowOpacity = 1;
        //        _searchViewBtn.layer.shadowRadius = 5;
        //        _searchViewBtn.layer.masksToBounds = YES;
        //        _searchViewBtn.layer.shadowOffset = CGSizeMake(-3, 3);
                
        [_searchView addSubview:_searchViewBtn];
        
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(searchViewClicked)];
        [_searchView addGestureRecognizer:tapGesture];
        
    }
    return _searchView;
}


/**
 关闭按钮
 
 @return 关闭按钮
 */
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(_searchView.left-30, _searchView.bottom+10*KScale, 198/2*KScale, 82/2*KScale)];
        [_closeBtn setImage:[UIImage imageNamed:@"button_select_car_close"] forState: UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

/**
 确认按钮
 
 @return 确认按钮，去H5页面
 */
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(_closeBtn.right-20, _searchView.bottom+10*KScale, 198/2*KScale, 82/2*KScale)];
        [_submitBtn setImage:[UIImage imageNamed:@"button_select_car_right"] forState: UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)buttonClicked:(id)object {
    UIButton *btn = (UIButton *)object;
    NSInteger tag = btn.tag;
    _chooseCarModelIndex = btn.tag;
    switch (tag) {
        case 100001:
            _searchViewLabel.text = @"型动版";
            break;
        case 100002:
            _searchViewLabel.text = @"智联灵动版";
            break;
        case 100003:
            _searchViewLabel.text = @"智联韵动版";
            break;
        case 100004:
            _searchViewLabel.text = @"智联享动版";
            break;
        case 100005:
            _searchViewLabel.text = @"智联御动版";
            break;
        case 100006:
            _searchViewLabel.text = @"自动尊贵";
            break;
        case 100007:
            _searchViewLabel.text = @"自动旗舰";
            break;
        default:
            break;
    }
    
    //选择车型后关闭弹框
    [self searchViewClicked];
    
    //选择完车型 1s后确认选择
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(timer, dispatch_get_main_queue(), ^(void){
        [self submit];
    });
    
}


- (UIView *)chooseCarModelView {
    if (!_chooseCarModelView) {
        //每行文字的高度
        float btnHeight = 20*KScale;
        float btnLeft = 0*KScale;
        float lineHeight = 1*KScale;
      //  UIColor *lineViewColor = [UIColor colorWithHexString:@"#1bb2fa"];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [bundle URLForResource:@"H5CarResource" withExtension:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
        
        _chooseCarModelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _searchView.width, (btnHeight+lineHeight)*5)];
        _chooseCarModelView.center = self.view.center;
        //_chooseCarModelView.backgroundColor = [UIColor colorWithHexString:@"#09497b"];
        _chooseCarModelView.layer.cornerRadius = 6;
        _chooseCarModelView.layer.borderWidth = 1;
        _chooseCarModelView.layer.borderColor = [[UIColor colorWithHexString:@"#c7d7ed"] CGColor];
        _chooseCarModelView.layer.cornerRadius = 8;
        _chooseCarModelView.hidden = YES;//默认不显示选项
        
        //边框添加阴影代码
        _chooseCarModelView.layer.shadowColor = [[UIColor colorWithHexString:@"#c7d7ed"] CGColor];
        _chooseCarModelView.layer.shadowOpacity = 1;
        _chooseCarModelView.layer.shadowRadius = 5;
        _chooseCarModelView.layer.shadowOffset = CGSizeMake(0, 0);
        
        
        [self.view addSubview:_chooseCarModelView];
        
        // 1.创建UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, _chooseCarModelView.width, _chooseCarModelView.height);
        scrollView.delegate = self;
        [_chooseCarModelView addSubview:scrollView];
        
        // 隐藏水平滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        //ScrollView的子视图 包涵滚动内容
        UIView *scrollSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _searchView.width, (btnHeight+lineHeight)*7)];
        [scrollView setScrollEnabled:NO];
        [scrollView addSubview:scrollSubView];
        
        scrollView.alwaysBounceVertical = YES;
        // 设置UIScrollView的滚动范围（内容大小）
        scrollView.contentSize = scrollSubView.size;
        
        float lineWidth = _chooseCarModelView.width-5*KScale*2;
        float lineLeft = 0*KScale;
        NSString *resNameLine = @"line";
        NSString *resNameBtnSel = @"image_btn_sel_choose";

        //手动舒适
        UIButton *btnType_1 = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, 0.5*lineHeight, _chooseCarModelView.width, btnHeight)];
        btnType_1.tag = 100001;
        btnType_1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnType_1 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        UILabel * labelTypeName_1 = [[UILabel alloc] initWithFrame:CGRectMake(btnLeft, 0.5*lineHeight, _chooseCarModelView.width, btnHeight)];
        labelTypeName_1.font = [UIFont systemFontOfSize:10*KScale];
        labelTypeName_1.textColor = [UIColor whiteColor];
        labelTypeName_1.text = @"型动版";
        labelTypeName_1.textAlignment = NSTextAlignmentCenter;
        [btnType_1 addSubview:labelTypeName_1];
        UIImage *imageBtnSel_1=  resourceBundle?[UIImage imageNamed:resNameBtnSel inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameBtnSel];
        [btnType_1 setImage:imageBtnSel_1 forState:UIControlStateHighlighted];
        [btnType_1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollSubView addSubview:btnType_1];
        
        UIImageView * imgViewLine_1 = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, btnType_1.bottom, lineWidth, lineHeight)];
        UIImage *imageLine1=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];
        [imgViewLine_1 setImage:imageLine1];
        [scrollSubView addSubview:imgViewLine_1];
        
        //手动豪华
        UIButton *btnType_2 = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, imgViewLine_1.bottom, _chooseCarModelView.width, btnHeight)];
        btnType_2.tag = 100002;
        btnType_2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnType_2 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        UILabel * labelTypeName_2 = [[UILabel alloc] initWithFrame:CGRectMake(btnLeft, 0.5*lineHeight, _chooseCarModelView.width, btnHeight)];
        labelTypeName_2.font = [UIFont systemFontOfSize:10*KScale];
        labelTypeName_2.textColor = [UIColor whiteColor];
        labelTypeName_2.text = @"智联灵动版";
        labelTypeName_2.textAlignment = NSTextAlignmentCenter;
        [btnType_2 addSubview:labelTypeName_2];
        UIImage *imageBtnSel_2=  resourceBundle?[UIImage imageNamed:resNameBtnSel inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameBtnSel];
        [btnType_2 setImage:imageBtnSel_2 forState:UIControlStateHighlighted];
        [btnType_2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollSubView addSubview:btnType_2];
        
        UIImageView * imgViewLine_2 = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, btnType_2.bottom, lineWidth, lineHeight)];
        UIImage *imageLine2=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];
        [imgViewLine_2 setImage:imageLine2];
        [scrollSubView addSubview:imgViewLine_2];
        
        
        //手动尊贵
        UIButton *btnType_3 = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, imgViewLine_2.bottom, _chooseCarModelView.width, btnHeight)];
        btnType_3.tag = 100003;
        btnType_3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnType_3 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
//        [sdzgBtn setTitle:@"手动尊贵" forState: UIControlStateNormal];
        UILabel * labelTypeName_3 = [[UILabel alloc] initWithFrame:CGRectMake(btnLeft, 0.5*lineHeight, _chooseCarModelView.width, btnHeight)];
        labelTypeName_3.font = [UIFont systemFontOfSize:10*KScale];
        labelTypeName_3.textColor = [UIColor whiteColor];
        labelTypeName_3.text = @"智联韵动版";
        labelTypeName_3.textAlignment = NSTextAlignmentCenter;
        [btnType_3 addSubview:labelTypeName_3];
        UIImage *imageBtnSel_3 =  resourceBundle?[UIImage imageNamed:resNameBtnSel inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameBtnSel];
        [btnType_3 setImage:imageBtnSel_3 forState:UIControlStateHighlighted];
        [btnType_3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollSubView addSubview:btnType_3];
        
        UIImageView * imgViewLine_3 = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, btnType_3.bottom, lineWidth, lineHeight)];
        UIImage *imageLine3=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];

        [imgViewLine_3 setImage:imageLine3];
        [scrollSubView addSubview:imgViewLine_3];
        
        
        //自动舒适
        UIButton *btnType_4 = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, imgViewLine_3.bottom, _chooseCarModelView.width, btnHeight)];
        btnType_4.tag = 100004;
        btnType_4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnType_4 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
       // [btnType_4 setTitle:@"自动舒适" forState: UIControlStateNormal];
        UILabel * labelTypeName_4 = [[UILabel alloc] initWithFrame:CGRectMake(btnLeft, 0.5*lineHeight, _chooseCarModelView.width, btnHeight)];
        labelTypeName_4.font = [UIFont systemFontOfSize:10*KScale];
        labelTypeName_4.textColor = [UIColor whiteColor];
        labelTypeName_4.text = @"智联享动版";
        labelTypeName_4.textAlignment = NSTextAlignmentCenter;
        [btnType_4 addSubview:labelTypeName_4];
        UIImage *imageBtnSel_4 =  resourceBundle?[UIImage imageNamed:resNameBtnSel inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameBtnSel];
        [btnType_4 setImage:imageBtnSel_4 forState:UIControlStateHighlighted];
        [btnType_4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollSubView addSubview:btnType_4];
        
        UIImageView * imgViewLine_4 = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, btnType_4.bottom, lineWidth, lineHeight)];
        UIImage *imageLine4=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];

        [imgViewLine_4 setImage:imageLine4];
        [scrollSubView addSubview:imgViewLine_4];
        
        
        //自动豪华
        UIButton *btnType_5 = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, imgViewLine_4.bottom, _chooseCarModelView.width, btnHeight)];
        btnType_5.tag = 100005;
        btnType_5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnType_5 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
       // [btnType_5 setTitle:@"自动豪华" forState: UIControlStateNormal];
        UILabel * labelTypeName_5 = [[UILabel alloc] initWithFrame:CGRectMake(btnLeft, 0.5*lineHeight, _chooseCarModelView.width, btnHeight)];
        labelTypeName_5.font = [UIFont systemFontOfSize:10*KScale];
        labelTypeName_5.textColor = [UIColor whiteColor];
        labelTypeName_5.text = @"智联御动版";
        labelTypeName_5.textAlignment = NSTextAlignmentCenter;
        [btnType_5 addSubview:labelTypeName_5];
        UIImage *imageBtnSel_5 =  resourceBundle?[UIImage imageNamed:resNameBtnSel inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameBtnSel];
        [btnType_5 setImage:imageBtnSel_5 forState:UIControlStateHighlighted];
        [btnType_5 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollSubView addSubview:btnType_5];
        
        UIImageView * imgViewLine_5 = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, btnType_5.bottom, lineWidth, lineHeight)];
        UIImage *imageLine5=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];
        [imgViewLine_5 setImage:imageLine5];
        [scrollSubView addSubview:imgViewLine_5];
//
//        //自动尊贵
//        UIButton *zdzgBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, zdhhLineImgView.bottom, _chooseCarModelView.width, btnHeight)];
//        zdzgBtn.tag = 100006;
//        zdzgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        [zdzgBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
//        [zdzgBtn setTitle:@"自动尊贵" forState: UIControlStateNormal];
//        [zdzgBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [scrollSubView addSubview:zdzgBtn];
//
//        UIImageView * zdzgLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, zdzgBtn.bottom, lineWidth, lineHeight)];
//        UIImage *imageLine6=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];
//        [zdzgLineImgView setImage:imageLine6];
//        [scrollSubView addSubview:zdzgLineImgView];
//
//
//        //自动旗舰
//        UIButton *zdqjBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnLeft, zdzgLineImgView.bottom, _chooseCarModelView.width, btnHeight)];
//        zdqjBtn.tag = 100007;
//        zdqjBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        [zdqjBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
//        [zdqjBtn setTitle:@"自动旗舰" forState: UIControlStateNormal];
//        [zdqjBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [scrollSubView addSubview:zdqjBtn];
//
//        UIImageView * zdqjLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(lineLeft, zdqjBtn.bottom, lineWidth, lineHeight)];
//        UIImage *imageLine7=  resourceBundle?[UIImage imageNamed:resNameLine inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resNameLine];
//        [zdqjLineImgView setImage:imageLine7];
      //  [scrollSubView addSubview:zdqjLineImgView];
        
        
    }
    return _chooseCarModelView;
}


/**
 关闭按钮
 */
- (void)close {
    UIApplication *app = (UIApplication *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.keyWindow;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

/**
 跳转去H5页面
 */
- (void)submit {
    //汽车类型
    NSString *strCarTypeName;
    
    switch (_chooseCarModelIndex) {
        case 100001:
            NSLog(@"手动舒适");
            strCarTypeName = typeManualComfortable;
            break;
        case 100002:
            NSLog(@"手动豪华");
            strCarTypeName = typeManualLuxury;
            break;
        case 100003:
            NSLog(@"手动尊贵");
            strCarTypeName = typeManualHonorable;
            break;
        case 100004:
            NSLog(@"自动舒适");
            strCarTypeName = typeAutomaticComfortable;
            break;
        case 100005:
            NSLog(@"自动豪华");
            strCarTypeName = typeAutomaticLuxury;
            break;
        case 100006:
            NSLog(@"自动尊贵");
            strCarTypeName = typeAutomaticHonorable;
            break;
        case 100007:
            NSLog(@"自动旗舰");
            strCarTypeName = typeAutomaticUltimate;
            break;
        default:
            break;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInteger: _chooseCarModelIndex] forKey:@"chooseCarModelIndex"];
    [userDefaults setObject:strCarTypeName forKey:@"chooseCarModelName"];
    [userDefaults setInteger:MODE_ONLINE forKey:@"webviewLoadMode"];
    
    [userDefaults synchronize];
    //[self getAppNewVersion];
    
    //进入web首页
    [self goJKWKWebViewWithURL:[NSString stringWithFormat:@"%@%@",BaseURL,strCarTypeName]];
    
}

/*
 进入web首页
 */
-(void) goJKWKWebViewWithURL: (NSString*) url{
    H5JKWKWebViewController *jkVC = [H5JKWKWebViewController new];
    jkVC.bottomViewController = self;
    //    NSString *url = [NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]];
    jkVC.url = url;
    [self presentViewController:jkVC  animated:NO completion:nil];
    
}

/**
 点击选择框，显示选项/隐藏选项
 */
- (void)searchViewClicked {
    if (!self.showChooseCarModelView) {
        _chooseCarModelView.hidden = false;
        _searchView.hidden = true;
        _showChooseCarModelView = true;
    } else {
        _chooseCarModelView.hidden = true;
        _searchView.hidden = false;
        _showChooseCarModelView = false;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"
#pragma clang diagnostic ignored "-Wmismatched-return-types"
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#pragma clang diagnostic pop
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

/**
 退出H5页面
 */
- (void)exitH5View {
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        __strong typeof(weakSelf)strongSelf=weakSelf;
        if ([strongSelf.bottomViewController respondsToSelector:@selector(exitH5View)]) {
            [strongSelf.bottomViewController exitH5View];
        }
    }];
}

-(void)getAppNewVersion
{
    //初始化manager
    H5CAR_AFHTTPSessionManager *manager = [H5CAR_AFHTTPSessionManager manager];
    
    //序列化
    manager.responseSerializer = [H5CAR_AFHTTPResponseSerializer serializer];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [userDefaults objectForKey:@"chooseCarModelIndex"];
    NSString *sCarType =  [NSString stringWithFormat:@"%d", [num intValue]%100000];
    
    //Get请求
    NSString *url = [NSString stringWithFormat:@"http://www.haoweisys.com/hongqih5_admin/index.php/home/index/get_new_version/car_type/%@",sCarType];
    
    [manager GET:url parameters:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功，解析数据
        NSString* sVersion;
        sVersion = [[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding];
        
        //与服务器版本号一致 sameVersion 为0
        if([sVersion compare:[userDefaults objectForKey:@"localVersion"]]){
            [userDefaults setObject:@"0" forKey:@"upLoad"];
        }
        //本地保存服务端最新资源版本 如下载最新资源改变本地资源localVerson版本号
        [userDefaults setObject:sVersion forKey:@"newVersion"];
        //        NSLog(@"%@", sVersion);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        //        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
