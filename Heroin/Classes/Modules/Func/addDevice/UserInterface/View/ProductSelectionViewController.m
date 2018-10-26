//
//  ProductSelectionViewController.m
//  Heroin
//
//  Created by Benson on 2018/10/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "ProductSelectionViewController.h"
#import "ProductBriefModel.h"
#import "DeviceTableViewCell.h"

#import "BroadlinkRequestService.h"
#import "FirstAddPresenter.h"
#import "UIImageView+WebCache.h"

@interface ProductSelectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ProductSelectionViewController

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
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

#pragma mark 每当有一个cell进入桌面 调用方法，返回当前行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProductSelection_Cell%ld%ld",[indexPath section], [indexPath row]];//以indexPath来唯一确定cell 
    
    DeviceTableViewCell *cell = [DeviceTableViewCell cellWithTableView:self.tableView Identifier:CellIdentifier];
    
    ProductBriefModel *ProductBrief = self.dataSource[indexPath.row];

    [cell.iconView sd_setImageWithURL:[NSURL URLWithString: ProductBrief.icon] placeholderImage:[UIImage imageNamed:@"FY_背景图片"]];
    
    cell.nameView.text = ProductBrief.brandName;
    cell.addressView.text = ProductBrief.deviceName;
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [ZIKRouterToView(FirstAddPresenter) performPath:ZIKViewRoutePath.pushFrom(self)  
                                        configuring:^(ZIKViewRouteConfiguration<FirstAddPresenter> * _Nonnull config) {
                                            
                                        }];
    
}

#pragma mark - Custom Delegate
// mothods

#pragma mark - Event Response

#pragma mark - Private Methods
// mothods

- (void)initData{
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    ProductBriefModel * customDeviceModel = [[ProductBriefModel  alloc]init];
    customDeviceModel.brandName = @"三位排插";
    customDeviceModel.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539950435216&di=01240c01245e1568f32cc2b2b449f18b&imgtype=0&src=http%3A%2F%2Fimg9.3lian.com%2Fc1%2Fvector%2F10%2F03%2F021.jpg";
    customDeviceModel.deviceName = @"博联SPmini wifi定时器开关插座";
    
    [self.dataSource addObject:customDeviceModel];

    [[BroadlinkRequestService sharedService] getProductKindsuccess:^(id param) {
        
        NSDictionary *dic = (NSDictionary *)param;
        NSArray *array = dic[@"categorylist"];
        
        for (NSDictionary *li in array) {
            ProductBriefModel * customDeviceModel = [[ProductBriefModel  alloc]init];
            customDeviceModel.brandName = li[@"name"];
            customDeviceModel.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539950435216&di=01240c01245e1568f32cc2b2b449f18b&imgtype=0&src=http%3A%2F%2Fimg9.3lian.com%2Fc1%2Fvector%2F10%2F03%2F021.jpg";
            customDeviceModel.deviceName = li[@"link"];
            
            [self.dataSource addObject:customDeviceModel];
            
            NSLog(@"li %@",li);        
        }
        
        [self.tableView reloadData];
    } failure:^(id param) {
        NSLog(@"param %@",param);        
    }];
}


#pragma mark - getters and setters 

- (void)initUI{
    
    [self.view addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround_two"]];
    }
    return _imageView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.5, 0, 0) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];

        [_tableView registerClass:[DeviceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DeviceTableViewCell class])];
    }
    return _tableView;
}

@end
