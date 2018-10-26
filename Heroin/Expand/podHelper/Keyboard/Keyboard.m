//
//  Keyboard.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "Keyboard.h"
#import "IQKeyboardManager.h"

@implementation Keyboard

#pragma mark - 键盘收回管理
+ (void)configureBoardManager
{
        DDLogInfo(@"configureBoardManager  ^_^!");
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        manager.enable = YES;
        manager.shouldResignOnTouchOutside = YES;
        manager.shouldToolbarUsesTextFieldTintColor = YES;
        manager.keyboardDistanceFromTextField=60;
        manager.enableAutoToolbar = NO;
}

@end
