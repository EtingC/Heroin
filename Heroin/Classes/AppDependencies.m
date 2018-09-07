//
//  AppDependencies.m
//  Heroin
//
//  Created by Benson on 2018/8/3.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "AppDependencies.h"

@implementation AppDependencies

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self configureDependencies];
    }
    
    return self;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window{
    
}


- (void)configureDependencies{
    
}

@end
