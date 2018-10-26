//
//  DeviceViewController.m
//  Heroin
//
//  Created by Benson on 2018/9/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "DeviceViewController.h"
#import "FMDBManager.h"
#import "BroadlinkManager.h"
#import "DeviceControllManager.h"

#import "DeviceTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "ProductSelectionPresenter.h"

@interface DeviceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *imageVIew;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataBaseArry;



@end

@implementation DeviceViewController

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];

    [self initData];
    [self initUI];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataBaseArry.count;
}

#pragma mark 每当有一个cell进入桌面 调用方法，返回当前行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    DeviceTableViewCell * deviceTableCell = [DeviceTableViewCell cellWithTableView:self.tableView indexPath:indexPath];

    id Device = _dataBaseArry[indexPath.row];

    if ([Device isKindOfClass:[BLDNADevice class]]) {
        BLDNADevice *DNADevice = Device;
        
        deviceTableCell.nameView.text = [DNADevice getName];
        deviceTableCell.addressView.text =  [NSString stringWithFormat:@"[mac:%@][Lanaddr:%@]",[DNADevice getMac],[DNADevice getLanaddr]];
        deviceTableCell.backgroundColor = [UIColor clearColor];
    }else if ([Device isKindOfClass:[BLFamilyDeviceInfo class]]){
        BLFamilyDeviceInfo *DNADevice = Device;
        
        deviceTableCell.nameView.text = DNADevice.name;
        deviceTableCell.addressView.text =  [NSString stringWithFormat:@"[mac:%@][did:%@]",DNADevice.mac,DNADevice.did];

    }else{
        
    }
    
    
    [deviceTableCell.iconView sd_setImageWithURL:[NSURL URLWithString: @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537272978316&di=95402b070c227213de5fee6bb171e9f8&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201509%2F28%2F20150928101444_FMauR.jpeg"] placeholderImage:[UIImage imageNamed:@"头像默认图"]];

    return deviceTableCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id Device = _dataBaseArry[indexPath.row];
    UIViewController *nextVC =  [[DeviceControllManager sharedInstance] deviceDiverter:Device Platform:PlatformBroadLink];
    
    [self.navigationController pushViewController:nextVC animated:YES];
}


#pragma mark - Custom Delegate
// mothods

#pragma mark - Event Response


- (void)OnClick:(UIButton *)btn{
    
}

//- (UIImage *)set_rightBarButtonItemWithImage{
//     UIImage *imageVIew = [UIImage imageNamed:@"chooser-button-input"];
//    
//    return imageVIew;
//}

- (UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"chooser-button-input"] forState:UIControlStateNormal];
    return btn;
}

- (void)right_button_event:(UIButton *)sender{
    
    [ZIKRouterToView(ProductSelectionPresenter) performPath:ZIKViewRoutePath.pushFrom(self) configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
        
        config.successHandler = ^(id  _Nonnull destination) {
            NSLog(@"provider: push success");
        };
        
        config.errorHandler = ^(ZIKRouteAction routeAction, NSError * error){
            NSLog(@"provider: push error Handler");
        };
        
    }];
    
}


#pragma mark - Private Methods

- (void)initData{
    _dataBaseArry = [[NSMutableArray alloc] init];
    
    NSArray *broadLinkDevice = [BroadLinkDevice getDevice];
    NSArray *broadLinkLANDevice = [BroadLinkDevice getLANDevice];
    
    [_dataBaseArry addObjectsFromArray:broadLinkDevice];
    [_dataBaseArry addObjectsFromArray:broadLinkLANDevice];
    
}


#pragma mark - getters and setters 
- (void)initUI{
    
    [self.view addSubview:self.imageVIew];
    [_imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.dataSource                     = self;
        _tableView.delegate                       = self;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_tableView registerClass:[DeviceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DeviceTableViewCell class])];
        
    }
    return _tableView;
}

-(UIImageView *)imageVIew{
    if (!_imageVIew) {
        _imageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_five"]];
    }
    return _imageVIew;
}

@end
