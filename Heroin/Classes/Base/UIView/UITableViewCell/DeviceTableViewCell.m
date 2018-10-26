//
//  DeviceTableViewCell.m
//  Heroin
//
//  Created by Benson on 2018/10/8.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "DeviceTableViewCell.h"

@interface DeviceTableViewCell()


@end



@implementation DeviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cellBenson";
    // 1.缓存中取
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[DeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.borderStyle = BaseCellBorderStyleAllRound;
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier{
    
    // 1.缓存中取
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[DeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.borderStyle = BaseCellBorderStyleAllRound;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameView];
        [self.contentView addSubview:self.onLineView];
        [self.contentView addSubview:self.addressView];
        
    }
    //设置frame
    [self settingFrame];
    return self;
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 3;
    [super setFrame:frame];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}
- (void)settingFrame{
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.bottom).offset(-10);
        make.width.equalTo(_iconView.height); /// 约束长度等于宽度
    }];
    
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(_iconView.right).offset(20);
        make.height.mas_equalTo(22);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameView.bottom).offset(1);
        make.left.equalTo(_nameView.left);
        make.height.mas_equalTo(8);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nameView{
    if (!_nameView) {
        _nameView = [[UILabel alloc] init];
    }
    return _nameView;
}

- (UILabel *)addressView{
    if (!_addressView) {
        _addressView = [[UILabel alloc] init];
        [_addressView setNumberOfLines:0];
        _addressView.font = [UIFont boldSystemFontOfSize:8.0f];  //UILabel的字体大小
    }
    return _addressView;
}

- (UIImageView *)onLineView{
    if (!_onLineView) {
        _onLineView = [[UIImageView alloc] init];
    }
    return _onLineView;
}



@end
