//
//  SceneViewController.m
//  Heroin
//
//  Created by Benson on 2018/9/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "SceneViewController.h"

@interface SceneViewController ()

@property (nonatomic,strong) UIImageView *imageVIew;

@end

@implementation SceneViewController

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title=@"场景";
    [self iniUI];
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

#pragma mark - Private Methods
// mothods

#pragma mark - getters and setters 

- (void)iniUI{
    [self.view addSubview:self.imageVIew];
    [_imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UIImageView *)imageVIew{
    if (!_imageVIew) {
        _imageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_three"]];
    }
    return _imageVIew;
}
@end
