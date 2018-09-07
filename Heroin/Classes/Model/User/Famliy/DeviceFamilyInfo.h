//
//  DeviceFamilyInfo.h
//  Heroin
//
//  Created by Benson on 2018/9/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BLLetFamily/BLFamilyDeviceInfo.h>
#import <BLLetFamily/BLModuleInfo.h>

//这是模型 是从首页列表 获取的数据模型 又重新整合的模型，
//因为原来的首页模型获取过来以后是 moudlebaseinfo  和  devicebaseinfo 
//然后  Moudle和device 又都在各自的数组里面 取值的时候很不方便 ，现在把他们对应的整合在一个模型里面

@interface DeviceFamilyInfo : NSObject    

@property (nonatomic,strong) NSArray * moduleInfoArr;

@property (nonatomic,strong) BLFamilyDeviceInfo * deviceInfo;

@property (nonatomic,strong) BLModuleInfo * moduleInfo;

@end
