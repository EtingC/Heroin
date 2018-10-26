//
//  ZIKLoginViewRouter.m
//  Heroin
//
//  Created by Benson on 2018/10/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "ZIKLoginViewRouter.h"
#import "ZIKLoginViewController.h"
#import "ZIKLoginViewController+Internal.h"
#import "ZIKLoginViewInput.h"

DeclareRoutableView(ZIKLoginViewController, ZIKLoginViewRouter)


@implementation ZIKLoginViewRouter

+ (void)registerRoutableDestination {
    DDLogInfo(@"ZIKLoginViewRouter");
    [self registerExclusiveView:[ZIKLoginViewController class]];
    [self registerViewProtocol:ZIKRoutable(ZIKLoginViewInput)];
    [self registerIdentifier:@"loginView"];
}

- (nullable ZIKLoginViewController *)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
    // Instantiate destination with configuration. Return nil if configuration is invalid.
    ZIKLoginViewController *destination = [[ZIKLoginViewController alloc] init];
    return destination;
}


- (void)prepareDestination:(ZIKLoginViewController *)destination configuration:(ZIKViewRouteConfiguration *)configuration {
    // Prepare destination
    destination.router = self;
}

@end
