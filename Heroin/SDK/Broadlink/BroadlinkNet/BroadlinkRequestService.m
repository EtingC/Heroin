//
//  BroadlinkRequestService.m
//  Heroin
//
//  Created by Benson on 2018/10/9.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadlinkRequestService.h"

@implementation BroadlinkRequestService

+ (instancetype)sharedService{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
        
    });
    return instance;
}



- (void)getServerDeviceFirmwareVersionWithDeviceType:(NSInteger)deviceType localVersion:(NSInteger)localVersion success:(successBlock)success failure:(failureBlock)failure{
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    self.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@%zd", BL_GET_FIRMWARE_VERSION_FROM_SRV, deviceType];
    
    [self GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"44"];
        NSArray *versions = [dict objectForKey:@"versions"];
        NSDictionary *infoDict = [versions objectAtIndex:0];
        success(infoDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
}


- (void)getProductDetailWithProductPid:(NSString *)productPid success:(successBlock)success failure:(failureBlock)failure{
    NSDictionary *body = @{
                           @"pid":productPid,
                           @"queryinfo":@{
                                   @"locate":@"abroad",
                                   @"system":@"ios",
                                   @"language":@"en",
                                   @"licenseid":POWER_LID,
                                   }
                           };
    NSDictionary *header = @{
                             @"UserId":[[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT],
                             @"language":@"en",
                             @"licenseid":POWER_LID
                             };
    NSString *urlString= [NSString stringWithFormat:@"https://%@%@%@",POWER_LID,POWER_DOMAINNAME,@"/ec4/v1/system/getproductdetail"];
    [self getNetDataBody:body Header:header URL:urlString success:^(id param) {
        success(param);
    } failure:^(id param) {
        failure(param);
    }];
}

- (void)getProductModelWithCategoryid:(NSString *)categoryid success:(successBlock)success failure:(failureBlock)failure{
    NSDictionary *body = @{
                           @"categoryid":categoryid,
                           @"queryinfo":@{
                                   @"locate":@"abroad",
                                   @"system":@"ios",
                                   @"language":@"en",
                                   @"licenseid":POWER_LID,
                                   }
                           };
    NSDictionary *header = @{
                             @"UserId":[[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT],
                             @"language":@"en",
                             @"licenseid":POWER_LID
                             };
    
    NSString *urlString= [NSString stringWithFormat:@"https://%@%@%@",POWER_LID,POWER_DOMAINNAME,@"/ec4/v1/system/getproductlist"];
    [self getNetDataBody:body Header:header URL:urlString success:^(id param) {
        success(param);
    } failure:^(id param) {
        failure(param);
    }];
    
}

- (void)getProductKindsuccess:(successBlock)success failure:(failureBlock)failure{
    NSDictionary *body = @{
                           @"pricategoryid":@"00000001",
                           @"queryinfo":@{
                                   @"locate":@"abroad",
                                   @"system":@"ios",
                                   @"language":@"en",
                                   @"licenseid":POWER_LID,
                                   }
                           };
    NSDictionary *header = @{
                             @"UserId":[[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT],
                             @"language":@"en",
                             @"licenseid":POWER_LID
                             };
    NSString *urlString= [NSString stringWithFormat:@"https://%@%@%@",POWER_LID,POWER_DOMAINNAME,@"/ec4/v1/system/getcategorylist"];
    [self getNetDataBody:body Header:header URL:urlString success:^(id param) {
        success(param);
    } failure:^(id param) {
        failure(param);
    }];
}


/**
 设置请求头
 
 {"0":{"versions":[{"version":"30","url":"http://cn-fwversions.ibroadlink.com/firmware/download/10002/30.bin","date":"2017-08-23","changelog":{"cn":"更新内容：\n解决红外码超时问题","en":"updating:\nSolving infrared code timeout problems "}}]}}
 
 @param manager AFHTTPSessionManager
 @param header 请求头
 */
- (void)setHeaderWithAFHTTPSessionManager:(AFHTTPSessionManager *)manager header:(NSDictionary *)header {
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}

/**
 获取网络数据
 
 @param body body
 @param header header
 @param url uel
 @param success success
 @param failure failure
 */
- (void)getNetDataBody:(NSDictionary *)body Header:(NSDictionary *)header URL:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //允许非安全访问
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    //设置内容请求响应类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [self setHeaderWithAFHTTPSessionManager:manager header:header];
    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
