//
//  BroadLinkPlugin.h
//  Heroin
//
//  Created by Benson on 2018/9/20.
//  Copyright © 2018年 Benson. All rights reserved.
//

#ifndef BroadLinkPlugin_h
#define BroadLinkPlugin_h
typedef void (^successBlock)(id param);
typedef void (^failureBlock)(id param);

#define defaultDBName @"BensonItsAJoke"

#define BroadlinkDBName @"Broadlink"

//DataBase Table Name
#define BroadLink_DB_DNADevice @"BLDNADevice"
#define BroadLink_DB_LoginResult @"BLLoginResult"
#define BroadLink_DB_UserInfo @"BLUserInfo"
#define BroadLink_DB_FamilyIdInfo @"BLFamilyIdInfo"
#define BroadLink_DB_OauthResult @"BLOauthResult"
#define BroadLink_DB_FamilyInfo @"BLFamilyInfo"
#define BroadLink_DB_DeviceBaseInfo @"DeviceBaseInfo"
#define BroadLink_DB_SubDeviceBaseInfo @"SubDeviceBaseInfo"
#define BroadLink_DB_ModuleInfo @"BLModuleInfo"
#define BroadLink_DB_RoomInfo @"BLRoomInfo"

//
#define BD_SESSION     @"SESSION"
#define BD_USERID      @"UserID"
#define BD_PASSWORD    @"PassWord"
//User ID
#define ACCOUNT  @"ACCOUNT"


#define BL_H5_NAVI                                  @"h5Navi"
#define DNAKIT_CORVODA_JS_FILE                      @"cordova.js"
#define DNAKIT_CORVODA_PLUGIN_JS_FILE               @"cordova_plugins.js"
#define DNAKIT_DEFAULTH5PAGE_NAME                   @"app.html"


// Net 请求地址
#define BL_GET_FIRMWARE_VERSION_FROM_SRV            @"https://fwversions.ibroadlink.com/getfwversion?devicetype="
#define POWER_DOMAINNAME                            @"bizappmanage.ibroadlink.com"



//状态
#define BroadLinkSuccess @"200"
//失败
#define BroadLinkFamilyNull @"-100"
#define BroadLinkTokenError @"-101"



typedef NS_ENUM(NSUInteger, DBEEVENT) {
    DBEEVENTInsert = 0,
    DBEEVENTUp
};

typedef NS_ENUM(NSUInteger, LandMode) {
    LandModePassword = 0, //账号密码登陆模式
    LandModeVcode         //短信验证码登陆模式
};

#endif /* BroadLinkPlugin_h */
