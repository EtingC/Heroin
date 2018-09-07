//
//  LocalLogInViewController.m
//  Heroin
//  本地登陆，自动登录//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "LocalLogInViewController.h"

@implementation LocalLogInViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"启动页"]];
    backImage.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    [self.view addSubview:backImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
