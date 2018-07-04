//
//  FYAddressListViewController.m
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYAddressListViewController.h"
#import "FYAddAddressViewController.h"
#import "Address2TableViewCell.h"
#import "AddressTableViewCell1.h"

@interface FYAddressListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FYAddressListViewController
-(void)addresslist{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:[NSNumber numberWithInteger:page_number] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:AddrList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSDictionary * result = [responseObject safeObjectForKey:@"result"];
            NSArray * items = [FYAddressModel mj_objectArrayWithKeyValuesArray:[result safeObjectForKey:@"items"]];
            [weakself.dataSourse removeAllObjects];
            [weakself.dataSourse addObjectsFromArray:items];
            [weakself.table reloadData];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    } requestRrror:^(id requestRrror) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addresslist];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColorFromRGB(0xeef1f2);
    self.title = @"地址列表";
    self.dataSourse = [[NSMutableArray alloc]init];
    isedit = NO;
    page_number = 0;
    [self refreshUI];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerNib:[UINib nibWithNibName:@"Address2TableViewCell" bundle:nil] forCellReuseIdentifier:@"Address2TableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"AddressTableViewCell1" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell1"];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57)];
    view.backgroundColor = [UIColor clearColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(12, 20, SCREEN_WIDTH - 24, 37);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 24, 37);
    [btn.layer addSublayer:gradientLayer];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 4;
    [btn setTitle:@"添加新地址" forState:0];
    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(addaddress) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    self.table.tableFooterView = view;
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 50, 22);
    [self.rightButton setTitleColor:UIColorFromRGB(0x333333) forState:0];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.rightButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitle:@"管理" forState:0];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}
-(void)refreshUI{
    WS(weakself);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page_number = 0;
        [weakself addaddress];
    }];
    self.table.mj_header.automaticallyChangeAlpha = YES;
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page_number += 1;
        [weakself addaddress];
    }];
}
-(void)addaddress{
    FYAddAddressViewController * address = [[FYAddAddressViewController    alloc]init];
    address.isedit = NO;
    [self.navigationController pushViewController:address animated:YES];
}
-(void)edit{
    isedit = !isedit;
    if (isedit) {
        [self.rightButton setTitle:@"完成" forState:0];
    }else
        [self.rightButton setTitle:@"管理" forState:0];
    [self.table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourse.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isedit) {
        Address2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Address2TableViewCell"];
        cell.model = self.dataSourse[indexPath.row];
        cell.setMoren.tag = indexPath.row;
        [cell.setMoren addTarget:self action:@selector(setmoren:) forControlEvents:UIControlEventTouchUpInside];
        cell.editBtn.tag = indexPath.row;
        [cell.editBtn addTarget:self action:@selector(editadd:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteadd:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    AddressTableViewCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell1"];
    cell.model = self.dataSourse[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isfromOrder) {
        if (_addressBlock) {
            self.addressBlock(self.dataSourse[indexPath.row]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isedit) {
        return 94;
    }
    return 54;
}
-(void)setmoren:(UIButton *)addid{
    FYAddressModel * model = self.dataSourse[addid.tag];
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:model.addr_id forKey:@"addr_id"];
    [paraDic setObject:[NSNumber numberWithInteger:1] forKey:@"is_default"];
    
    [NetWorkManager requestWithMethod:POST Url:SetDefault Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
            [weakself addresslist];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)deleteadd:(UIButton *)addid{
    FYAddressModel * model = self.dataSourse[addid.tag];
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:model.addr_id forKey:@"addr_id"];
    
    [NetWorkManager requestWithMethod:POST Url:AddrDelete Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [weakself addresslist];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)editadd:(UIButton *)addid{
    FYAddAddressViewController * address = [[FYAddAddressViewController    alloc]init];
    address.isedit = YES;
    address.model = self.dataSourse[addid.tag];
    [self.navigationController pushViewController:address animated:YES];
}
@end
