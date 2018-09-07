//
//  SMSLogInViewController.m
//  Heroin
//  账号 + 短信登录
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "SMSLogInViewController.h"

#import "BroadlinkManager.h"

#import "UIColor+HEX.h"
#import "NSString+RegexCategory.h"
#import "MBProgressHUD+XX.h"

@interface SMSLogInViewController ()<UINavigationBarDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *navLine;
@property (nonatomic,strong) UIButton * codeBtn;
@property (nonatomic ,strong) NSTimer *myTimer;  //倒计时
@property  (nonatomic , assign) int timeCount;  //倒计时时间60s
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@end

@implementation SMSLogInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.codeBtn];
    self.timeCount = 60;
    
    self.phoneTF.delegate = self;
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor colorWithHex:333333]}];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView *backgroundView = [self.navigationController.navigationBar subviews].firstObject;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor =  [UIColor blackColor];
    _navLine = backgroundView.subviews.firstObject;
    _navLine.hidden = YES;
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.myTimer setFireDate:[NSDate distantFuture]];
    self.timeCount = 60;
    self.codeBtn.layer.borderColor = HYColor.CGColor;
    self.codeBtn.enabled = YES;
    self.phoneTF.text = @"";
    self.codeTF.text = @"";
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:HYColor forState:UIControlStateNormal];
}

- (IBAction)getPhoneCode {
    if ([self.phoneTF.text isMobileNumber]) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(function) userInfo:nil repeats:YES];
        [_myTimer setFireDate:[NSDate distantPast]];
#warning showInView:self.view
        //[UsingHUD showInView:self.view];
        [[BroadlinkManager sharedManager].account sendFastVCode:self.phoneTF.text countryCode:@"0086" completionHandler:^(BLBaseResult * _Nonnull result) {
            if (result.error == 0) {
                [MBProgressHUD showAutoMessage:@"获取验证码成功"];
            }else{
                [MBProgressHUD showAutoMessage:result.msg];
            }
        }];
    }else{
        [MBProgressHUD showAutoMessage:@"请正确填写手机号码"];
    }
}


@end
