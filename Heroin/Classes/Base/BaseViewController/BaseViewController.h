//
//  BaseViewController.h
//  Heroin
//
//  Created by Benson on 2018/9/3.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIScrollView+EmptyDataSet.h"

@interface BaseViewController : UIViewController<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

//@property (nonatomic,strong) UITableView *myTable;
//@property (nonatomic,strong) NSMutableArray *dataSource;

-(UIBarButtonItem* )setNavLeftRightFrame:(UINavigationController *)nav imageName:(NSString *)name selector:(NSString*)selector ;
-(void)leftBtn;
-(void)rightBtn;

@end
