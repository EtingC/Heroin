//
//  DeviceInfoManager.m
//  Heroin
//
//  Created by Benson on 2018/9/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "DeviceInfoManager.h"

@implementation DeviceInfoManager

+ (DeviceInfoManager *)sharedManager{
    static DeviceInfoManager *deviceInfoManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        deviceInfoManager = [[self alloc] init];
        
    });
    return deviceInfoManager;
}

- (NSString *)TheAddDevieceName{
    if (!_TheAddDevieceName) {
        _TheAddDevieceName = [[NSString alloc]init];
        
    }
    return _TheAddDevieceName;
}
- (NSString *)PID{
    if (!_PID) {
        _PID = [[NSString alloc]init];
    }
    
    return _PID;
}

- (NSMutableArray *)deviceInfoArray{
    if (_deviceInfoArray == nil) {
        _deviceInfoArray = [[NSMutableArray alloc] init];
    }
    return _deviceInfoArray;
}

#pragma mark - 解析获取PID
+ (NSString *)getPidStringDecimal:(NSInteger)decimal{
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
            case 10:
                letter =@"a"; break;
            case 11:
                letter =@"b"; break;
            case 12:
                letter =@"c"; break;
            case 13:
                letter =@"d"; break;
            case 14:
                letter =@"e"; break;
            case 15:
                letter =@"f"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", (long)number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            break;
        }
    }
    if (hex.length%2 !=0) {
        hex = [NSString stringWithFormat:@"0%@",hex];
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < hex.length/2; i++) {
        [array addObject:[hex substringWithRange:NSMakeRange(i*2, 2)]];
    }
    NSString *string = @"";
    for (int i = 0; i < array.count; i++) {
        string = [string stringByAppendingString:array[array.count-1-i]];
    }
    NSString *newString = [NSString stringWithFormat:@"000000000000000000000000%@",string];
    while (newString.length <32) {
        newString = [newString stringByAppendingString:@"0"];
    }
    return newString;
}

@end
