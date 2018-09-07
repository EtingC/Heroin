//
//  DeviceInfoManager.h
//  Heroin
//
//  Created by Benson on 2018/9/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfoManager : NSObject

@property (nonatomic,strong) NSMutableArray * deviceInfoArray;
@property (nonatomic,copy) NSString *PID;
@property (nonatomic,copy) NSString *imagePath;
@property (nonatomic,copy) NSString *TheAddDevieceName;

+ (DeviceInfoManager *)sharedManager;
#pragma mark - 解析获取PID
+ (NSString *)getPidStringDecimal:(NSInteger)decimal;

@end
