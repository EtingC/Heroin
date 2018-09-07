//
//  RegisterViewContrller.h
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewContrller : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *PhoneSyr;
@property (weak, nonatomic) IBOutlet UITextField *TwoCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *SendBtn;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *AgainPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *ZhuCeBtn;
@property(nonatomic,copy) NSString *phoneStr;

@end
