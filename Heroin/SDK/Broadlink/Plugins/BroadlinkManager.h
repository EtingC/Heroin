//
//  BroadlinkManager.h
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BLLetAccount/BLLetAccount.h>
#import <BLLetFamily/BLLetFamily.h>
#import <BLLetCore/BLLet.h>

@interface BroadlinkManager : NSObject


@property(nonatomic,strong)  BLAccount * account;
@property(nonatomic,strong)  BLLet *let;
@property (nonatomic,strong) BLFamilyController *familyManager;


+ (BroadlinkManager *)sharedManager;

- (void)loadAppSdk;

@end
