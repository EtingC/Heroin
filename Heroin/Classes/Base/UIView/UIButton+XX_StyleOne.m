//
//  UIButton+XX_StyleOne.m
//  Heroin
//
//  Created by Benson on 2018/9/12.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "UIButton+XX_StyleOne.h"
#import "UIColor+Random.h"

@implementation UIButton (XX_StyleOne)

- (instancetype)initWithPlaceholder:(NSString *)placeholder{
    return [self initWithPlaceholder:placeholder Tag:0];
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder Tag:(NSInteger)tag{
    
    self = [super init];
    if(self) {
#if ViewDebug
        self.backgroundColor = [UIColor RandomColor];
#endif
        
        [self setTitle:placeholder forState:UIControlStateNormal];
        [self setTitleColor:[UIColor RandomColor]forState:UIControlStateNormal];     
        self.tag = tag;
        self.layer.cornerRadius = 3.0;//2.0是圆角的弧度，根据需求自己更改
        self.layer.borderColor = [UIColor RandomColor].CGColor; //设置边框颜色
        self.layer.borderWidth = 1.0f;//设置边框颜色
        
    }
    return self;
}

- (instancetype)initWithUIImage:(NSString *)imageName{
    
    return [self initWithPlaceholder:imageName Tag:0];
}

- (instancetype)initWithUIImage:(NSString *)imageName Tag:(NSInteger)tag{
    self = [super init];
    if (self) {
        self.tag = tag;
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end
