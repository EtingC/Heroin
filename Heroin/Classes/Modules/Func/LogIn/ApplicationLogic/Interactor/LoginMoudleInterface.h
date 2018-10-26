//
//  LoginMoudleInterface.h
//  Heroin
//
//  Created by Benson on 2018/9/18.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ChangeView){
    ChangeViewPasswordSecurity = 0,// 密码可见/隐藏密码
};


@protocol PasswordLoginMoudleInterface <NSObject>

- (void)clear;
- (void)doLoginWithName:(NSString *)name Passwd:(NSString *) passwd;
- (void)changeView:(ChangeView) changeView;
@end

@protocol RegisterMoudleInterface <NSObject>

- (void)clear;
- (void)changeView:(ChangeView) changeView;
@end
