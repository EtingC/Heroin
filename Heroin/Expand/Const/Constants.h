//
//  Constants.h
//  MobileFrame
//
//  Created by Benson on 2018/3/21.
//  Copyright © 2018年 Benson. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//邮件接收人
static NSString* const kMail_cc_ToRecipients_Address = @"zjxucb@gmail.com";
//网络状态监控地址
static NSString* const kURL_Reachability_Address = @"www.baidu.com";

#pragma mark - 参数
typedef NS_ENUM(NSUInteger, Platform) {
    PlatformBroadLink = 0,
    PlatformHongyar,
    PlatformAlibaba
};

#endif /* Constants_h */
