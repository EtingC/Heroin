//
//  PasswordLogInViewController.h
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BaseViewController.h"

@interface PasswordLogInViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *PhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *PasswordSecurityBtn;
@property (weak, nonatomic) IBOutlet UIButton *DismissPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *ZhuCeBtn;
@end
