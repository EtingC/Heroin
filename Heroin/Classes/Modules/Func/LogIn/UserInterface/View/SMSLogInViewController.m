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


//
#import "UILabel+XX_StyleOne.h"
#import "UIButton+XX_StyleOne.h"
#import "UITextField+XX_StyleOne.h"

@interface SMSLogInViewController ()<UINavigationBarDelegate,UITextFieldDelegate>

@property(nonatomic,strong) UITextField *account;
@property(nonatomic,strong) UITextField *secret;
//登陆
@property(nonatomic,strong) UIButton *loginBtn;
//注册
@property(nonatomic,strong) UIButton *registerBtn;
//忘记密码
@property(nonatomic,strong) UIButton *VCode;
//短信的登陆
@property(nonatomic,strong) UIButton *accountLogin;
@end

@implementation SMSLogInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor =  [UIColor blackColor];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
}

#pragma mark 更新UI


#pragma mark UI操作控制
- (void)onClick:(UIButton *)btn{
    
}

#pragma mkrk UI_View_Init

- (void)initUI{
    [self.view addSubview:self.account]; 
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {  
        make.left.equalTo(self.view.mas_left).offset(50);  
        make.right.equalTo(self.view.mas_right).offset(-50);  
        make.top.equalTo(self.view.mas_top).offset(170);  
        make.height.mas_equalTo(50);  
    }];
    
    [self.view addSubview:self.secret];
    [_secret mas_makeConstraints:^(MASConstraintMaker *make) {  
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);  
        make.top.equalTo(_account.mas_bottom).offset(10);  
        make.height.mas_equalTo(50);  
    }];
    
    [self.view addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {  
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        
        make.top.equalTo(_secret.mas_bottom).offset(20);  
        make.height.mas_equalTo(40);  
    }];
    
    UILabel *Title = [[UILabel alloc] initWithText:@"短信验证码登陆"];
    [self.view addSubview:Title];
    [Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_account.top).offset(-5);
        make.left.equalTo(self.view.mas_left).offset(50);  
        make.height.mas_equalTo(50);  
    }];
    
    [self.view addSubview:self.registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(_loginBtn.mas_bottom).offset(10);  
        make.height.mas_equalTo(40);  
    }];
 
    [self.view addSubview:self.accountLogin];
    [_accountLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(30);  
    }];
    
    [self.view addSubview:self.VCode];
    [_VCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secret.right).offset(-2);
        make.centerY.equalTo(_secret.mas_centerY);
        make.height.mas_equalTo(25);  
    }];
}

- (UITextField *)account{
    
    if (!_account) {
        _account = [[UITextField alloc] initWithPlaceholder:@"账号"];
    }
    return _account;
}

- (UITextField *)secret{
    if (!_secret) {
        _secret = [[UITextField alloc] initWithPlaceholder:@"验证码"];
    }
    return _secret;
}

- (UIButton *)registerBtn{
    
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithPlaceholder:@"注册" Tag:2];
        [_registerBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithPlaceholder:@"登陆" Tag:1];
        [_loginBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)VCode{
    
    if (!_VCode) {
        _VCode = [[UIButton alloc] initWithPlaceholder:@"获取验证码" Tag:4];
        [_VCode addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _VCode;
}

- (UIButton *)accountLogin{
    
    if (!_accountLogin) {
        _accountLogin = [[UIButton alloc] initWithPlaceholder:@"使用账号/密码登录" Tag:5];
        [_accountLogin addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountLogin;
}
@end
