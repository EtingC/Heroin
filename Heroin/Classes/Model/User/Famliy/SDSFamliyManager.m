//
//  SDSFamliyManager.m
//  Heroin
//
//  Created by Benson on 2018/9/5.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "SDSFamliyManager.h"

@implementation SDSFamliyManager

+ (SDSFamliyManager *)sharedInstance{
    
    static SDSFamliyManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[SDSFamliyManager alloc]init];
    });
    return sharedInstance;
}

- (NSMutableArray *)famliyMutArr{
    
    if(!_famliyMutArr){
        
        _famliyMutArr    = [[NSMutableArray alloc]init];
        
    }
    return _famliyMutArr;
}

- (void)setFamliyID:(NSString *)famliyID{
    self.famliyID = famliyID;
}

- (NSString *)famliyID{
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"FAMILYID"]) {
        
        return [[NSUserDefaults standardUserDefaults]valueForKey:@"FAMILYID"];
    }
    return @"";
}

- (void)setFamilyVer:(NSString *)familyVer{
    self.familyVer = familyVer;  
}

- (NSString *)familyVer{
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"FAMILYVERSION"]) {
        return [[NSUserDefaults standardUserDefaults]valueForKey:@"FAMILYVERSION"];
    }
    return @"";
}
@end
