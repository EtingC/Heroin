//
//  testModel.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "testModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "BroadlinkFMDB.h"
#import "testModelList.h"
#import "FMDBModel.h"
#import "testO.h"


#import <BLLetAccount/BLLetAccount.h>
#import <BLLetFamily/BLLetFamily.h>
#import <BLLetCore/BLLet.h>



@interface testModel()

@property(strong, nonatomic)FMDBModel *DB;


@end

@implementation testModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"sceneList" : [testModelList class],
             };
}


- (NSInteger)creatDataaWithName:(NSString *)tableName Class:(id) obj{
    
    
    BroadlinkFMDB *Broadlink = [[BroadlinkFMDB alloc] initDB];
    BLFamilyDeviceInfo * hh = [[BLFamilyDeviceInfo alloc ] init];
    hh.familyId = @"10010";
    hh.roomId = @"1001000";
    hh.did = @"did111";
    hh.sDid = @"sDid111";
    hh.mac = @"mac1111";
    hh.pid = @"pid111";
    hh.name = @"name1111";
    hh.password = 667781119;
    hh.type = 879999;
    hh.lock = true;
    hh.aesKey = @"1111aesKey";
    hh.terminalId = 13241324;
    hh.subdeviceNum = 876;
    hh.longitude = @"l1111ongitude";
    hh.latitude = @"latitu1111de";          //设备所在经度
    hh.wifimac = @"wifima1111c";
    hh.extend = @"extend1111";
    
    [Broadlink createDataWithTableName:@"BLModuleInfo" Class:[BLModuleInfo class]];
    
    
    BLModuleInfo *moduleInfo = [[BLModuleInfo alloc] init];
    
    moduleInfo.familyId =@"模块所在家庭ID";          //模块所在家庭ID
    moduleInfo.roomId=@"模块所在房间ID";            //模块所在房间ID
    moduleInfo.moduleId=@"模块自身ID";          //模块自身ID
    moduleInfo.name=@"模块名称";              //模块名称
    moduleInfo.iconPath=@"模块icon路径";          //模块icon路径
    BLModuleIncludeDev *moduleIncludeDev = [[BLModuleIncludeDev alloc] init];
    moduleIncludeDev.did=@"设备Did";      //设备Did
    moduleIncludeDev.sdid=@"若为子设备，则包含该子设备did";     //若为子设备，则包含该子设备did
    moduleIncludeDev.content=@"设备相关扩展内容，由用户自定义";  //设备相关扩展内容，由用户自定义
    moduleIncludeDev.order=666777667677;  //序号

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [arr addObject:moduleIncludeDev];
    
    moduleInfo.moduleDevs = arr; //模块下挂设备列表
    moduleInfo.followDev=1;       //模块移动时，设备是否跟随  0-NO 1-YES
    moduleInfo.order=9999;           //模块序号
    moduleInfo.flag=88777;            //模块Flag
    moduleInfo.moduleType=7879879;     //模块类型
    moduleInfo.scenceType=@"场景类型";        //场景类型
    moduleInfo.extend=@"模块扩展信息";            //模块扩展信息

    
    
    
    [Broadlink insertDataWithTableName:@"BLModuleInfo" Class:moduleInfo];
    
    
    NSLog(@"%@",[Broadlink selectFromTableName:@"BLModuleInfo"]);

//    
//    NSLog(@"%@",[self classPropsFor:obj]);
//    NSLog(@"%@",[self classPropsFor:[testO class]]);
    
//    _DB = [[FMDBModel alloc] initWithPath:kPathDocument fileName:[tableName stringByAppendingString:@".sqlite"]];    
//    
//    [_DB createTableName:tableName maker:^(FMDBMaker *maker) {
//        
//        maker.columnName(@"id").integer().primaryKey().autoincrement().notNull();
//        
//        
//        unsigned int count;
//        objc_property_t* props = class_copyPropertyList([testO class], &count);
//        for (int i = 0; i < count; i++) {
//            objc_property_t property = props[i];
//            const char * name = property_getName(property);
//            
//            NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//            const char * type = property_getAttributes(property);
//            NSString *attr = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
//            NSString * typeString = [NSString stringWithUTF8String:type];
//            NSArray * attributes = [typeString componentsSeparatedByString:@","];
//            NSString * typeAttribute = [attributes objectAtIndex:0];
//            NSString * propertyType = [typeAttribute substringFromIndex:1];
//            const char * rawPropertyType = [propertyType UTF8String];
//            
//            if (strcmp(rawPropertyType, @encode(float)) == 0) {
//                //it's a float
//                NSLog(@"%@ float",propertyName);
//            } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
//                //it's an int
//                NSLog(@"%@ int",propertyName);
//            } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
//                //it's some sort of object
//                NSLog(@"%@ id",propertyName);
//            } else {
//                // According to Apples Documentation you can determine the corresponding encoding values
//            }
//            
//            if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
//                NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];  //turns @"NSDate" into NSDate
//                Class typeClass = NSClassFromString(typeClassName);
//                if (typeClass != nil) {
//                    // Here is the corresponding class even for nil values
//                    NSLog(@"%@ %@",propertyName,typeClass);
//                }
//            }
//            
//        }
//        free(props);            
//        
//        maker.create();
//    }];
    
    return 0;
}


//获取属性名称数组
- (NSDictionary *)classPropsFor:(Class)klass
{
    if (klass == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            
            NSLog(@"propertyName %@ propertyType %@", propertyName, propertyType);
            
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}
//获取属性的方法
static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            
            // if you want a list of what will be returned for these primitives, search online for
            // "objective-c" "Property Attribute Description Examples"
            // apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
            
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}


@end
