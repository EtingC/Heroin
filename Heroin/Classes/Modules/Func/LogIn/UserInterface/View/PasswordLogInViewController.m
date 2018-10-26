//
//  PasswordLogInViewController.m
//  Heroin
//  账号 + 密码登录
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "PasswordLogInViewController.h"
#import "UIColor+Random.h"

#import "LoginMoudleInterface.h"
#import "PasswordLoginMoudle.h"

#import "UIButton+XX_StyleOne.h"
#import "UITextField+XX_StyleOne.h"
#import "UILabel+XX_StyleOne.h"

#import "AppDelegate.h"
#import "ZIKLoginViewInput.h"

#import "HomeViewPresenter.h"
//test

@interface PasswordLogInViewController()<UIAlertViewDelegate>

@property(nonatomic,strong) UITextField *account;//账号
@property(nonatomic,strong) UITextField *secret;//密码
//登陆
@property(nonatomic,strong) UIButton *loginBtn;
//注册
@property(nonatomic,strong) UIButton *registerBtn;
//忘记密码
@property(nonatomic,strong) UIButton *forgetPassword;
//短信的登陆
@property(nonatomic,strong) UIButton *SMSLogin;
//密码可见/密码不可见
@property(nonatomic,strong) UIButton *passwordSecurity;

@property (nonatomic,strong) id<PasswordLoginMoudleInterface> LoginMoudle;
@property (nonatomic, strong) ZIKViewRouter *infoViewRouter;
@property (nonatomic,strong) UIImageView *imageVIew;
@end

@implementation PasswordLogInViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupViews];
    _LoginMoudle  = [[PasswordLoginMoudle alloc] initWithView:self];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 更新UI

- (void)onClearText{
    _account.text = @"";
    _secret.text = @"";
}

- (void)onLoginResult:(Boolean) result code:(int) code{
    if (result == YES) {
        [ZIKRouterToView(HomeViewPresenter) performPath:ZIKViewRoutePath.defaultPathFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
            
            config.prepareDestination = ^(UIViewController<CaptchaInterface> *destination) {
                destination.title = @"Home";
            };

        }];
    }
}
- (void)changeSecret{
    
    _secret.secureTextEntry = _secret.secureTextEntry?NO:YES;
    if ([_secret isSecureTextEntry]) {
        [_passwordSecurity setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
        
    }else{
        [_passwordSecurity setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }
}

#pragma mark - UI操作控制
- (void)onClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case LogInModelAccountLogin:{//账号密码登陆
            _account.text = @"15676789894";
            _secret.text = @"znkj1234";
            [_LoginMoudle doLoginWithName:_account.text Passwd:_secret.text];
        }break;
        case LogInModelRegister:{//验证码登陆
            [ZIKRouterToView(RegisterInterface) performPath:ZIKViewRoutePath.pushFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
                
            }];
        }break;
        case LogInModelPasswordSecurity:{//密码隐藏/密码可见
            [_LoginMoudle changeView:ChangeViewPasswordSecurity];
        }break;
        case LogInModelForgetPassword:{//忘记密码
            [ZIKRouterToView(CaptchaInterface) performPath:ZIKViewRoutePath.showFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
                
                config.prepareDestination = ^(UIViewController<CaptchaInterface> *destination) {
                    destination.title = @"忘记密码";
                };
            }];
        }break;
        case LogInModelVCodeLogin:{//验证码登陆
            [ZIKRouterToView(SMSLogInInterface) performPath: ZIKViewRoutePath.pushFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
                
                config.prepareDestination = ^(UIViewController<CaptchaInterface> *destination) {
                    destination.title = @"验证码登陆";
                };
            }];
        }break;
        default:
            break;
    }
    
}

#pragma - mkrk UI_View_Init

- (void)setupViews{
    
    [self.view addSubview:self.imageVIew];
    [_imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
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
    
    [self.view addSubview:self.passwordSecurity];
    [_passwordSecurity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secret.mas_left).offset(-5);
        make.centerY.equalTo(_secret.mas_centerY);
    }];
    
    [self.view addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {  
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        
        make.top.equalTo(_secret.mas_bottom).offset(20);  
        make.height.mas_equalTo(40);  
    }];
    
    [self.view addSubview:self.registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(_loginBtn.mas_bottom).offset(10);  
        make.height.mas_equalTo(40);  
    }];
    
    UILabel *Title = [[UILabel alloc] initWithText:@"密码登陆"];
    [self.view addSubview:Title];
    [Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_account.top).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(50);  
        make.height.mas_equalTo(50);  
    }];
    
    [self.view addSubview:self.SMSLogin];
    [_SMSLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(30);  
    }];
    
    [self.view addSubview:self.forgetPassword];
    [_forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secret.right).offset(-2);
        make.centerY.equalTo(_secret.mas_centerY);
        make.height.mas_equalTo(20);  
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
        _secret = [[UITextField alloc] initWithPlaceholder:@"密码"];
    }
    return _secret;
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithPlaceholder:@"登陆" Tag:LogInModelAccountLogin];
        [_loginBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn{
    
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithPlaceholder:@"注册" Tag:LogInModelRegister];
        [_registerBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)passwordSecurity{
    
    if (!_passwordSecurity) {
        _passwordSecurity = [[UIButton alloc] initWithUIImage:@"密码可见" Tag:LogInModelPasswordSecurity];
        [_passwordSecurity addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordSecurity;
}

- (UIButton *)forgetPassword{
    
    if (!_forgetPassword) {
        _forgetPassword = [[UIButton alloc] initWithPlaceholder:@"忘记密码?" Tag:LogInModelForgetPassword];
        [_forgetPassword addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassword;
}

- (UIButton *)SMSLogin{
    
    if (!_SMSLogin) {
        _SMSLogin = [[UIButton alloc] initWithPlaceholder:@"使用短信验证码登录" Tag:LogInModelVCodeLogin];
        [_SMSLogin addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SMSLogin;
}

-(UIImageView *)imageVIew{
    if (!_imageVIew) {
        _imageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_four"]];
    }
    return _imageVIew;
}
@end
