//
//  MeViewController.m
//  Heroin
//
//  Created by Benson on 2018/9/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "MeViewController.h"
#import "HeaderTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Random.h"


#import "LogInInterface.h"

#import "NSUserDefaults+SafeAccess.h"


@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *imageVIew;

@property (nonatomic,strong) UITableView *tableVIew;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *dataDic;

@end

@implementation MeViewController

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title=@"用户信息";
 
    [self initUI];
    _dataArray = @[@{@"IMG":@"tab_equipment_on",@"Name":NSLocalizedString(@"账号设置", nil)},
                   @{@"IMG":@"tab_scene_on",@"Name":NSLocalizedString( @"版本升级", nil)},
                   @{@"IMG":@"tab_user_on",@"Name":NSLocalizedString( @"关于鸿雁", nil)}
                   ];;
    
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIView Delegate
// UIViewDelegate  for example UITableViewDelegate UITableViewDataSource
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

#pragma mark 每当有一个cell进入桌面 调用方法，返回当前行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HeaderTableViewCell * headerCell = [HeaderTableViewCell cellWithTableView:self.tableVIew];
        [headerCell.iconView sd_setImageWithURL:[NSURL URLWithString: @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537272978316&di=95402b070c227213de5fee6bb171e9f8&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201509%2F28%2F20150928101444_FMauR.jpeg"] placeholderImage:[UIImage imageNamed:@"头像默认图"]];
        
        [headerCell.nameLabel setText:@"okokoko"];
        return headerCell;
        
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell 
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell 
        if (cell == nil) { 
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; 
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSDictionary *dic = _dataArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"IMG"]];
        cell.textLabel.text = [dic objectForKey:@"Name"];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (Main_Screen_Height ==480) {
            return 120;
        }
        return 140;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 13;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
        view.backgroundColor = [UIColor RandomColor];
        return view;
    }
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([NSUserDefaults boolForKey:ISLOGIN]) {
        [ZIKRouterToView(PasswordLogInInterface) performPath:ZIKViewRoutePath.pushFrom(self)
                                         configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
            
        }];
    }

}


#pragma mark - Custom Delegate
// mothods

#pragma mark - Event Response

#pragma mark - Private Methods
// mothods

#pragma mark - getters and setters 

- (void)initUI{
    
    [self.view addSubview:self.imageVIew];
    [_imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.view addSubview:self.tableVIew];
    [_tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UITableView *)tableVIew{
    
    if (!_tableVIew) {
        _tableVIew                                = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _tableVIew.showsVerticalScrollIndicator   = NO;
        _tableVIew.showsHorizontalScrollIndicator = NO;
        _tableVIew.dataSource                     = self;
        _tableVIew.delegate                       = self;
        _tableVIew.backgroundColor                = [UIColor clearColor];
        [_tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableVIew registerClass:[HeaderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HeaderTableViewCell class])];
    }
    return _tableVIew;
}

-(UIImageView *)imageVIew{
    if (!_imageVIew) {
        _imageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_six"]];
    }
    return _imageVIew;
}
@end
