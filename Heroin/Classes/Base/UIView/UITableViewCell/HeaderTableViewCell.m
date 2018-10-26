//
//  HeaderTableViewCell.m
//  Heroin
//
//  Created by Benson on 2018/9/18.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderTableViewCell.h"

@interface HeaderTableViewCell()


@end

@implementation HeaderTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *identifier = @"headView";
    // 1.缓存中取
    HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[HeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //创建头像/VIP标志/用户昵称
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.vipView];
        [self.contentView addSubview:self.nameLabel];
    }
    
    //设置frame
    [self settingFrame];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)settingFrame{
    //95
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(95);
    }];
#warning 如果需要VIP 等一些设置，需要添加对应的控件并且位置重新安排
//    [_vipView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView.mas_centerX);
//        make.top.equalTo(_iconView.mas_bottom).offset(10);
//        make.width.mas_equalTo(95);
//        make.height.mas_equalTo(95);
//
//    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_bottom).offset(10); 
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
}




#pragma make - UI View
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UIImageView *)vipView{
    if (!_vipView) {
        _vipView = [[UIImageView alloc] init];
    }
    return _vipView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
        _nameLabel.textColor = [UIColor purpleColor];
        
    }
    return _nameLabel;
}


@end
