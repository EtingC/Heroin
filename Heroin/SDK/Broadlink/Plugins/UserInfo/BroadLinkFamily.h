//
//  BroadLinkFamily.h
//  Heroin
//
//  Created by Benson on 2018/10/17.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BroadLinkPlugin.h"

NS_ASSUME_NONNULL_BEGIN
@interface BroadLinkFamily : NSObject

/**
 查询账号下的家庭
 
 @param success 成功
 @param failure 失败
 */
+ (void)UserFamilySuccess:(successBlock)success Failure:(failureBlock)failure;

/**
 创建家庭
 
 @param success 成功
 @param failure 失败
 */
+ (void)createNewFamilySuccess:(successBlock)success Failure:(failureBlock)failure;

/**
 通过获取到的家庭信息 获取设备信息
 
 @param ids 家庭信息 id
 @param success 成功
 @param failure 失败
 */
+ (void)queryFamilyInfoWithIds:(NSArray *)ids Success:(successBlock)success Failure:(failureBlock)failure;

@end
NS_ASSUME_NONNULL_END
