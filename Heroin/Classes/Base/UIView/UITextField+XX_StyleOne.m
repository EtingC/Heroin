//
//  UITextField+XX_StyleOne.m
//  Heroin
//
//  Created by Benson on 2018/9/12.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "UITextField+XX_StyleOne.h"
#import "UIColor+Random.h"

@implementation UITextField (XX_StyleOne)


- (instancetype)initWithPlaceholder:(NSString *)placeholder{
    
    self = [super init];
    if (self) {
#if ViewDebug
        self.backgroundColor = [UIColor RandomColor];
#endif
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.placeholder = placeholder;
        
        self.layer.cornerRadius = 5.0;//2.0是圆角的弧度，根据需求自己更改
        self.layer.borderColor = [UIColor RandomColor].CGColor; //设置边框颜色
        self.layer.borderWidth = 1.0f;//设置边框颜色

    }
    return self;
}

@end
