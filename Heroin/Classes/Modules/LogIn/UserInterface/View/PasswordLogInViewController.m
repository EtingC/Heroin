//
//  PasswordLogInViewController.m
//  Heroin
//  账号 + 密码登录
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "PasswordLogInViewController.h"

@interface PasswordLogInViewController()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *NoAccoutntL;
@property (weak, nonatomic) IBOutlet UIButton *RightSecurityBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@end

@implementation PasswordLogInViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



- (IBAction)passwordSecurity:(id)sender {
    
    self.PasswordTF.secureTextEntry = !self.PasswordTF.secureTextEntry;
    if (self.PasswordTF.secureTextEntry == YES) {
        [self.RightSecurityBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
    }else{
        [self.RightSecurityBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }
    
}

//忘记密码
- (IBAction)DisMissAction:(id)sender {
//    self.findPWVC.comeFromVC = @"找回密码";
//    [self.navigationController pushViewController:self.findPWVC animated:YES];
}
//注册
- (IBAction)ZhuceAction:(id)sender
{
//    self.findPWVC.comeFromVC = @"注册";
//    [self.navigationController pushViewController:self.findPWVC animated:YES];
}
//短信登录
- (IBAction)changeLogWay:(id)sender {
//    [self.navigationController pushViewController:self.messageLogVC animated:YES];
}
@end
