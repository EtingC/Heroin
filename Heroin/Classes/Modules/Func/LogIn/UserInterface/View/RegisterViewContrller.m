//
//  RegisterViewContrller.m
//  Heroin
//  注册 
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "RegisterViewContrller.h"
#import "RegisterMoudle.h"
#import "UIButton+XX_StyleOne.h"
#import "UITextField+XX_StyleOne.h"
#import "UILabel+XX_StyleOne.h"

#import "testModelList.h"

#import "HomeViewPresenter.h"

@interface RegisterViewContrller()

@property(nonatomic,strong) UITextField *account;
@property(nonatomic,strong) UITextField *secret;
//注册
@property(nonatomic,strong) UIButton *registerBtn;
//密码可见/密码不可见 
@property(nonatomic,strong) UIButton *passwordSecurity;
@property (nonatomic,strong) UIImageView *imageVIew;

@property (nonatomic,strong) id<RegisterMoudleInterface> RegisterMoudle; 

@end

@implementation RegisterViewContrller

@synthesize phoneStr;
#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initData];
    [self setupViews];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIView Delegate
// UIViewDelegate  for example UITableViewDelegate UITableViewDataSource


#pragma mark - Custom Delegate
// mothods

- (void)changeSecret { 
    
    _secret.secureTextEntry = _secret.secureTextEntry?NO:YES;
    if ([_secret isSecureTextEntry]) {
        [_passwordSecurity setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
        
    }else{
        [_passwordSecurity setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }
}

- (void)onClearText { 
    _account.text = @"";
    _secret.text = @"";
}

- (void)onLoginResult:(Boolean)result code:(int)code { 
    
    if (result == YES) {
        [ZIKRouterToView(HomeViewPresenter) performPath:ZIKViewRoutePath.defaultPathFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
            
            config.prepareDestination = ^(UIViewController<CaptchaInterface> *destination) {
                destination.title = @"Home";
            };
            
        }];
    }
}


#pragma mark - Event Response

- (void)onClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case LogInModelRegister:{//注册
            
        }break;
        case LogInModelPasswordSecurity:{//密码隐藏/密码可见
            [_RegisterMoudle changeView:ChangeViewPasswordSecurity];
        }break;
        default:
            break;
    }
    
}

#pragma mark - Private Methods
// mothods

- (void)initData{
    _RegisterMoudle = [[RegisterMoudle alloc] initWithView:self];
}

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
    
    [self.view addSubview:self.registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(_secret.mas_bottom).offset(20);  
        make.height.mas_equalTo(40);  
    }];
    
    
    [self.view addSubview:self.passwordSecurity];
    [_passwordSecurity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secret.mas_left).offset(-5);
        make.centerY.equalTo(_secret.mas_centerY);
    }];
    
}

#pragma mark - getters and setters 

- (UITextField *)account{
    
    if (!_account) {
        _account = [[UITextField alloc] initWithPlaceholder:@"请输入6-16位数字/字母组合密码"];
    }
    return _account;
}

- (UITextField *)secret{
    if (!_secret) {
        _secret = [[UITextField alloc] initWithPlaceholder:@"请再次输入密码"];
    }
    return _secret;
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

- (UIImageView *)imageVIew{
    if (!_imageVIew) {
        _imageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_four"]];
    }
    return _imageVIew;
}
@end
