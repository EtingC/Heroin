//
//  LogInInterface.h
//  Heroin
//
//  Created by Benson on 2018/8/6.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LogInInterface <NSObject>

- (void)onClearText;
- (void)onLoginResult:(Boolean) result code:(int) code;
- (void)onSetProgressBarVisibility:(int) visibility;

@end
