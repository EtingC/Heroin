//
//  FirstAddViewController.m
//  Heroin
//
//  Created by Benson on 2018/10/22.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "FirstAddViewController.h"

#import "UIButton+XX_StyleOne.h"
#import "UILabel+XX_StyleOne.h"
#import "SecondAddPresenter.h"

@interface FirstAddViewController ()

@property(nonatomic, strong) UIImageView *imageView;
@property(strong, nonatomic) UIButton *NextBtn;

@property(strong, nonatomic) UIImageView *logoImage;
@property(strong, nonatomic) UILabel *contentL;

@end

@implementation FirstAddViewController

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initUI];
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

#pragma mark - Event Response

- (void)Onclic:(UIButton *)btn{
    
    [ZIKRouterToView(SecondAddPresenter) performPath:ZIKViewRoutePath.pushFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
        
    }]; 
}

#pragma mark - Private Methods
// mothods

#pragma mark - getters and setters 

- (void)initUI{
    
    [self.view addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.view addSubview:self.NextBtn];
    [_NextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-35);
    }];
    
    [self.view addSubview:self.logoImage];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(150);
        make.right.equalTo(self.view.mas_right).offset(-70);
        make.left.equalTo(self.view.mas_left).offset(70);
        make.height.equalTo(_logoImage.width).offset(-40);
    }];
    
    [self.view addSubview:self.contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_logoImage.mas_bottom).offset(30);
        make.width.equalTo(_logoImage.width);
        make.height.equalTo(40);
        
    }];
}

- (UIButton *)NextBtn{
    if (!_NextBtn) {
        _NextBtn = [[UIButton alloc] initWithPlaceholder:@"下一步" Tag:1001];
        
        [_NextBtn setBackgroundColor:[UIColor grayColor]];
        [_NextBtn addTarget:self action:@selector(Onclic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _NextBtn;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_two"]];
    }
    return _imageView;
}

- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"配网提示界面图片"]];
    }
    return _logoImage;
}

- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc] initWithText:@"1.初次配置时，您的设备上电后，Wi-Fi指示灯快速，设备进入可配置状态;\n2.非初次配置时，请长按开关键6秒以上直至WiFi指示灯快闪，设备即可进入可配置状态;"];
    }
    return _contentL;
}



@end
