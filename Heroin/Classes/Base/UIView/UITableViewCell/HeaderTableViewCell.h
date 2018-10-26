//
//  HeaderTableViewCell.h
//  Heroin
//
//  Created by Benson on 2018/9/18.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell

/**
 头像
 */
@property (nonatomic, strong) UIImageView *iconView;
/**
 VIP
 */
@property (nonatomic, strong) UIImageView *vipView;
/**
 昵称
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 昵称
 */
@property (nonatomic, strong) UITextView *nameText;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
