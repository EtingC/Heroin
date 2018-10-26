//
//  RegisterMoudle.m
//  Heroin
//
//  Created by Benson on 2018/10/24.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "RegisterMoudle.h"

@interface RegisterMoudle()

@property (nonatomic,strong) id<RegisterInterface> registerView;

@end

@implementation RegisterMoudle

- (instancetype)initWithView:(id)registerView{
    self = [super init];
    if (self) {
        _registerView = registerView;
    }
    return self;
}

- (void)changeView:(ChangeView)changeView { 
    switch (changeView) {
        case ChangeViewPasswordSecurity:{
            [_registerView changeSecret];
        }break;
        default:
            break;
    }
}

- (void)clear { 
    [_registerView onClearText];
}


@end

