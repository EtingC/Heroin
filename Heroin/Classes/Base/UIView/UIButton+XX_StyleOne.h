//
//  UIButton+XX_StyleOne.h
//  Heroin
//  按键自定义样式 1 
//  场景：登陆，注册... 
//  Created by Benson on 2018/9/12.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XX_StyleOne)

- (instancetype)initWithPlaceholder:(NSString *)placeholder;
- (instancetype)initWithPlaceholder:(NSString *)placeholder Tag:(NSInteger)tag;

/**

 @param imageName Image Name
 @return self
 */
- (instancetype)initWithUIImage:(NSString *)imageName;
- (instancetype)initWithUIImage:(NSString *)imageName Tag:(NSInteger)tag;
@end
