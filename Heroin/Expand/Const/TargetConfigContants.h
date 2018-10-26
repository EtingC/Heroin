//
//  TargetConfigContants.h
//  MobileFrame
//
//  Created by Benson on 2018/7/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#ifndef TargetConfigContants_h
#define TargetConfigContants_h



#define ViewDebug  0


#if PRODUCT  //产品环境

static NSString* const TargetConfig_NetWork_s=@"";
//DDLog等级
static const int ddLogLevel = LOG_LEVEL_ERROR;

#else   //其它环境

//DDLog等级
static const int ddLogLevel = LOG_LEVEL_VERBOSE;




#endif
#endif /* TargetConfigContants_h */
