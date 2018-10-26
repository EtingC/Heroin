//
//  RegisterMoudle.h
//  Heroin
//
//  Created by Benson on 2018/10/24.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginMoudleInterface.h"
#import "LogInInterface.h"

@interface RegisterMoudle : NSObject<RegisterMoudleInterface>

-(instancetype)initWithView:(id) registerView;

@end
