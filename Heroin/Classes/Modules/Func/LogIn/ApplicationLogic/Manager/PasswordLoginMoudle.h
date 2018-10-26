//
//  PasswordLoginMoudle.h
//  Heroin
//
//  Created by Benson on 2018/10/24.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginMoudleInterface.h"

@interface PasswordLoginMoudle : NSObject<PasswordLoginMoudleInterface>

-(instancetype)initWithView:(id) loginView;

@end
