//
//  testModelList.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "testModelList.h"
#import <BLLetCore/BLLetCore.h>
@implementation testModelList

+ (NSData *)Controller{
    
    static int Bopen = 0;
    
    NSString *close = @"a5a55a5ac1c002000300000f00";
    NSString *open = @"a5a55a5ad0c002000300000f0f";
    NSData *closeData = [close dataUsingEncoding:NSUTF8StringEncoding];
    NSData *openData = [open dataUsingEncoding:NSUTF8StringEncoding];
    
    if (Bopen) {
        Bopen = !Bopen;
        BLController *jj = [[BLController alloc] init];
        NSLog(@"open ");
        return  [jj dnaPassthrough:@"00000000000000000000b4430ddb9d22" passthroughData:closeData].getData;
    }else{
        Bopen = !Bopen;
        NSLog(@"close ");
        BLController *jj = [[BLController alloc] init];
        return  [jj dnaPassthrough:@"00000000000000000000b4430ddb9d22" passthroughData:openData].getData;
    }
    
}

@end
