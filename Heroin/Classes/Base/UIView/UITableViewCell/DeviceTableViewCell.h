//
//  DeviceTableViewCell.h
//  Heroin
//
//  Created by Benson on 2018/10/8.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BaseBorderCell.h"

@interface DeviceTableViewCell : BaseBorderCell


/**
 设备显示图片
 */
@property (nonatomic, strong) UIImageView *iconView;

/**
 设备名字
 */
@property (nonatomic, strong) UILabel *nameView;

/**
 在线状态
 */
@property (nonatomic, strong) UIImageView *onLineView;

@property (nonatomic, strong) UILabel *addressView;


+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier;
@end
