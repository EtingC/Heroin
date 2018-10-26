//
//  SDSFamliyManager.h
//  Heroin
//
//  Created by Benson on 2018/9/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BLLetFamily/BLFamilyInfo.h>
#import "DeviceFamilyInfo.h"

@interface SDSFamliyManager : NSObject
+ (SDSFamliyManager *)sharedInstance;

@property (nonatomic,copy) NSString * famliyID;

@property (nonatomic,copy ) NSString *  familyVer;

@property (nonatomic,strong) BLFamilyInfo * familyinfo; //这个是登录以后能用，再启动就不管用了

@property (nonatomic,strong) DeviceFamilyInfo * deFaInfoData;

@property (nonatomic,strong) NSMutableArray * famliyMutArr;
@end

