//
//  CordovaViewController.h
//  Heroin
//
//  Created by Benson on 2018/10/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h> 
@interface CordovaViewController : CDVViewController 

@end 

@interface CordovaCommandDelegate : CDVCommandDelegateImpl

@end 

@interface CordovaCommandQueue : CDVCommandQueue

@end
