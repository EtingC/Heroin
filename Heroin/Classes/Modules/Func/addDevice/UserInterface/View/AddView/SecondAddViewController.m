//
//  SecondAddViewController.m
//  Heroin
//
//  Created by Benson on 2018/10/22.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "SecondAddViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>//获取网络相关信息

#import "BroadlinkManager.h"

#import "UIButton+XX_StyleOne.h"
#import "UITextField+XX_StyleOne.h"
@interface SecondAddViewController ()

@property(nonatomic, strong) UIImageView *imageView;
@property(strong, nonatomic) UIButton *NextBtn;

@property(strong, nonatomic) UITextField *SSID;
@property(strong, nonatomic) UITextField *Password;

@property (nonatomic,strong) BLDeviceConfigResult * DeviceConfigResult;


@end

@implementation SecondAddViewController

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

#pragma mark - Private Methods
// mothods

- (void)Onclic:(UIButton *)Btn{
    
    NSLog(@"1");
    NSString *ssid = _SSID.text;
    NSString *password = _Password.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BLDeviceConfigResult *result = [[BLLet sharedLet].controller deviceConfig:ssid password:password version:2 timeout:60];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.DeviceConfigResult = result;
            NSLog(@"3");
            NSLog(@"result.error %ld,result.msg %@",(long)result.error,result.msg);
            if (self.DeviceConfigResult.error == 0) {
                // GCD定时器
                NSLog(@"4");
                NSLog(@"result.getMac %@,result.getDid %@,result.getDevaddr %@",result.getMac,result.getDid,result.getDevaddr);
                __block  int timeout =75;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout <= 0 ){
                        dispatch_source_cancel(_timer);
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"%d",timeout);
                        });
                    }
                });
            }
            NSLog(@"5");
        });
        
    });
}

#pragma mark - getters and setters 

- (void)initUI{
    
    [self.view addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    [self.view addSubview:self.SSID]; 
    [_SSID mas_makeConstraints:^(MASConstraintMaker *make) {  
        make.left.equalTo(self.view.mas_left).offset(50);  
        make.right.equalTo(self.view.mas_right).offset(-50);  
        make.top.equalTo(self.view.mas_top).offset(170);  
        make.height.mas_equalTo(50);  
    }];
    
    [self.view addSubview:self.Password];
    [_Password mas_makeConstraints:^(MASConstraintMaker *make) {  
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);  
        make.top.equalTo(_SSID.mas_bottom).offset(10);  
        make.height.mas_equalTo(50);  
    }];
    
    
    
    [self.view addSubview:self.NextBtn];
    [_NextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-35);
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
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_three"]];
    }
    return _imageView;
}

- (UITextField *)SSID{
    if (!_SSID) {
        _SSID = [[UITextField alloc] initWithPlaceholder:@"ssid"];
        _SSID.text =[BLNetworkImp getCurrentSSIDInfo];
    }
    return _SSID;
}  

- (UITextField *)Password{
    if (!_Password) {
        _Password = [[UITextField alloc] initWithPlaceholder:@"password"];
    }
    return _Password;
}


@end
