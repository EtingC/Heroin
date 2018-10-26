//
//  introductoryPagesHelper.h
//  Heroin
//
//  Created by Benson on 2018/9/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface introductoryPagesHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray *)imageArray;

@end
