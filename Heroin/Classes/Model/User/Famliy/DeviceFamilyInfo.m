//
//  DeviceFamilyInfo.m
//  Heroin
//
//  Created by Benson on 2018/9/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "DeviceFamilyInfo.h"

@implementation DeviceFamilyInfo

//-(BLModuleInfo *)moduleInfo{
//    BLModuleInfo * moduleif = [[BLModuleInfo alloc]init];
//    for (BLModuleInfo * model in self.moduleInfoArr) {
//        NSArray * BLModuleIncludeDevArr = model.moduleDevs;
//        if (BLModuleIncludeDevArr) {
//            BLModuleIncludeDev * devModel =BLModuleIncludeDevArr.firstObject;
//            if ([devModel.did isEqualToString:self.deviceInfo.did]) {
//                moduleif =model;
//            }
//        }else{
//
//            NSLog(@"BLModuleIncludeDevArr 数组不存在数据");
//        }
//    }
//    return moduleif;
//}

-(NSArray *)moduleInfoArr{
    if (!_moduleInfoArr) {
        _moduleInfoArr = [[NSArray alloc]init];
    }
    return _moduleInfoArr;
}
@end
