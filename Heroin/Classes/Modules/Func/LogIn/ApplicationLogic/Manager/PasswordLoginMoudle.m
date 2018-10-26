//
//  PasswordLoginMoudle.m
//  Heroin
//
//  Created by Benson on 2018/10/24.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "PasswordLoginMoudle.h"
#import "BroadlinkManager.h"
#import "LogInInterface.h"
#import "MBProgressHUD+XX.h"

@interface PasswordLoginMoudle()

@property (nonatomic,strong) id<PasswordLogInInterface> loginView;

@end

@implementation PasswordLoginMoudle

- (instancetype)initWithView:(id)loginView{
    self = [super init];
    if (self) {
        _loginView = loginView;
    }
    return self;
}

- (void)clear { 
    [_loginView onClearText];
}

- (void)doLoginWithName:(NSString *)name Passwd:(NSString *)passwd { 
    
    [[BroadlinkManager sharedManager] logInWithUserName:name PasswordOrVcode:passwd countrycode:nil LandMode:LandModePassword Success:^(id param) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_loginView onLoginResult:YES code:200];
        });    
    } Failure:^(id param) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",param);
            [_loginView onLoginResult:NO code:400];
        });    
    }];
}

- (void)changeView:(ChangeView)changeView { 
    switch (changeView) {
        case ChangeViewPasswordSecurity:{
            [_loginView changeSecret];
        }break;
        default:
            break;
    }
}




@end
