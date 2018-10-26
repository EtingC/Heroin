//
//  CaptchaViewRouter.m
//  Heroin
//
//  Created by Benson on 2018/10/24.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "CaptchaViewRouter.h"
#import "CaptchaViewController.h"

DeclareRoutableView(CaptchaViewController, CaptchaViewRouter)

@implementation CaptchaViewRouter

//app启动时，注册对应的模块和Router
//不使用+load和+initialize方法，因为在Swift中已经不适用
+ (void)registerRoutableDestination {
    
    [self registerView:[CaptchaViewController class]];
    [self registerViewProtocol:ZIKRoutable(CaptchaInterface)];
    [self registerIdentifier:@"CaptchaView"];
    
}

- (id<ZIKRoutableView>)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
    
    CaptchaViewController *destination = [[CaptchaViewController alloc] init];
    return destination;
}


- (void)prepareDestination:(id)destination configuration:(ZIKViewRouteConfiguration *)configuration{
    
}

+ (void)router:(nullable ZIKViewRouter *)router willPerformRouteOnDestination:(id)destination fromSource:(id)source {
    NSLog(@"nrouter: (%@),\n\
          ➡️ will\n\
          perform route\n\
          from source: (%@),\n\
          destination: (%@),\n",router, source, destination);
}

+ (void)router:(nullable ZIKViewRouter *)router didPerformRouteOnDestination:(id)destination fromSource:(id)source {
    NSLog(@"nrouter: (%@),\n\
          ✅ did\n\
          perform route\n\
          from source: (%@),\n\
          destination: (%@),\n",router, source, destination);
}

+ (void)router:(nullable ZIKViewRouter *)router willRemoveRouteOnDestination:(id)destination fromSource:(id)source {
    NSLog(@"nrouter: (%@),\n\
          ⬅️ will\n\
          remove route\n\
          from source: (%@),\n\
          destination: (%@),\n",router, source, destination);
}

+ (void)router:(nullable ZIKViewRouter *)router didRemoveRouteOnDestination:(id)destination fromSource:(id)source {
    NSLog(@"nrouter: (%@),\n\
          ❎ did\n\
          remove route\n\
          from source: (%@),\n\
          destination: (%@),\n",router, source, destination);
}


@end
