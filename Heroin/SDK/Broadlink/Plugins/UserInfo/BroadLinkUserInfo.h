//
//  BroadLinkUserInfo.h
//  Heroin
//
//  Created by Benson on 2018/10/17.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BroadLinkPlugin.h"

NS_ASSUME_NONNULL_BEGIN
@interface BroadLinkUserInfo : NSObject

/**
 获取用户的 nickname  userid  iconUrl
 
 @param useridArray userid 数组
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)UserInfoWithUserid:(NSArray<NSString *> *)useridArray Success:(successBlock)success Failure:(failureBlock)failure;



@end
NS_ASSUME_NONNULL_END
