//
//  HomeViewController.h
//  Heroin
//
//  Created by Benson on 2018/9/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
#import "HomeViewPresenter.h"

@interface HomeViewController : CYLTabBarController<UITabBarControllerDelegate,HomeViewPresenter>

@end
