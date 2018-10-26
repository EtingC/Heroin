//
//  BroadlinkRequestService.h
//  Heroin
//
//  Created by Benson on 2018/10/9.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "BroadLinkPlugin.h"
@interface BroadlinkRequestService : AFHTTPSessionManager

/**
 创建网络请求的单例
 */
+ (instancetype)sharedService;

/**
 获取设备的云端版本

 @param deviceType 设备类型 type
 @param localVersion 本地版本
 @param success 数据获取成功
 @param failure 数据获取失败
 */
- (void)getServerDeviceFirmwareVersionWithDeviceType:(NSInteger)deviceType localVersion:(NSInteger)localVersion success:(successBlock)success failure:(failureBlock)failure;

/**
 获取型号的详细信息
 请求地址 @"https://d0f94faa04c63d9b7b0b034dcf895656bizappmanage.ibroadlink.com/ec4/v1/system/getproductlist
 
 @param productPid 产品 Pid
 @param success 数据获取成功
 @param failure 数据获取失败
 */
-(void)getProductDetailWithProductPid:(NSString *)productPid success:(successBlock)success failure:(failureBlock)failure;

/**
 获取产品型号
 请求地址 @"https://d0f94faa04c63d9b7b0b034dcf895656bizappmanage.ibroadlink.com/ec4/v1/system/getproductlist
 
 @param categoryid category ID
 @param success 数据获取成功
 @param failure 数据获取失败
 */
-(void)getProductModelWithCategoryid:(NSString *)categoryid success:(successBlock)success failure:(failureBlock)failure;

/**
 获取产品类型
 请求地址 @"https://d0f94faa04c63d9b7b0b034dcf895656bizappmanage.ibroadlink.com/ec4/v1/system/getcategorylist"
 
 @param success 数据获取成功
 @param failure 数据获取失败
 */
-(void)getProductKindsuccess:(successBlock)success failure:(failureBlock)failure;


@end
