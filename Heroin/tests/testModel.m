//
//  testModel.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "testModel.h"
#import "testModelList.h"
@implementation testModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"sceneList" : [testModelList class],
             };
}
@end
