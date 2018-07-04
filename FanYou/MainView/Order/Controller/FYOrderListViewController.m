//
//  FYOrderListViewController.m
//  FanYou
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOrderListViewController.h"
#import "FYOrderListTableViewCell.h"
#import "FYOrderListModel.h"
#import "FYOrderDetailViewController.h"
#import "FYAddOrderViewController.h"

@interface OrderButton : UIButton
@property (nonatomic, strong) FYOrderListModel *model;
@end
@implementation OrderButton
@end

@interface FYOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FYOrderListViewController
-(void)orderListWith:(NSString *)status{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:[NSNumber numberWithInteger:page_number] forKey:@"page_number"];
    if ([self.type isEqualToString:@"我的订单"]) {
        [paraDic setObject:@"all" forKey:@"status"];
    }else if ([self.type isEqualToString:@"待付款"]){
        [paraDic setObject:@"unpay" forKey:@"status"];
    }else if ([self.type isEqualToString:@"待发货"]){
        [paraDic setObject:@"undeliver" forKey:@"status"];
    }else if ([self.type isEqualToString:@"待收货"]){
        [paraDic setObject:@"unreceive" forKey:@"status"];
    }
    
    [NetWorkManager requestWithMethod:POST Url:OrderList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYOrderListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
            }
            [weakself.dataSourse addObjectsFromArray:array];
            [weakself.table reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有更多订单了"];
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
            }
            [weakself.table reloadData];
        }
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    } requestRrror:^(id requestRrror) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self orderListWith:self.type];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    page_number = 0;
    self.title = self.type;
    self.dataSourse = [[NSMutableArray alloc]init];
    [self refreshUI];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)refreshUI{
    WS(weakself);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page_number = 0;
        [weakself orderListWith:self.type];
    }];
    self.table.mj_header.automaticallyChangeAlpha = YES;
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page_number += 1;
        [weakself orderListWith:self.type];
    }];
}
-(void)setupUI{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStyleGrouped];
    if ([self.type isEqualToString:@"我的订单"]) {
        self.table.frame = CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight - 30);
        [self createButton];
    }
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor= [UIColor clearColor];
    self.table.tableFooterView = [[UIView alloc]init];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    [self.table registerNib:[UINib nibWithNibName:@"FYOrderListTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYOrderListTableViewCell"];
}
-(void)createButton{
    NSArray * array = @[@"全部",@"待付款",@"待发货",@"待收货"];
    for (int i = 0; i<4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH/4*i, 0, SCREEN_WIDTH/4, 30);
        [btn setTitle:array[i] forState:0];
        [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xf82f4b) forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor whiteColor]];
        if (i == 0) {
            btn.selected = YES;
            self.rememberBtn = btn;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    self.line = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4 - 45)/2, 29, 45, 1)];
    self.line.backgroundColor = UIColorFromRGB(0xf82f4b);
    [self.view addSubview:self.line];
}
-(void)btnclick:(UIButton *)btn{
    self.rememberBtn.selected = !self.rememberBtn.selected;
    btn.selected = !btn.selected;
    self.rememberBtn = btn;
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(btn.tag*SCREEN_WIDTH/4 + (SCREEN_WIDTH/4 - 45)/2, 29, 45, 1);
    }];
    [self.table setContentOffset:CGPointMake(0, 0) animated:NO];
    page_number = 0;
    if (btn.tag == 0) {
        self.type = @"我的订单";
        [self orderListWith:self.type];
    }else{
        self.type = btn.titleLabel.text;
        [self orderListWith:self.type];
    }
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    line.backgroundColor = UIColorFromRGB(0xeef1f2);
    [view addSubview:line];
    
    UIImageView * images = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 12, 11)];
    images.image = [UIImage imageNamed:@"店铺icon -"];
    [view addSubview:images];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 9, 200, 12)];
    label.textColor = UIColorFromRGB(0x666666);
    label.font = [UIFont systemFontOfSize:12];
    FYOrderListModel * model = self.dataSourse[section];
    label.text = model.shop_name;
    [view addSubview:label];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(12, 30, SCREEN_WIDTH-24, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    [view addSubview:line];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 8, SCREEN_WIDTH - 42, 14)];
    label.textColor = UIColorFromRGB(0x333333);
    label.font = [UIFont systemFontOfSize:10];
    FYOrderListModel * model = self.dataSourse[section];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%@件商品 合计：￥%.2f(含运费￥%.2f)",model.goods_count,[model.total_price floatValue],[model.express_fee floatValue]]];
    NSString * count = [NSString stringWithFormat:@"%@",model.goods_count];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(9+count.length, 2)];
    label.attributedText = string;
    label.textAlignment = NSTextAlignmentRight;
    [view addSubview:label];
    
    OrderButton *btn = [OrderButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH - 67, 35, 55, 19);
    btn.tag = section;
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn setTitleColor:UIColorFromRGB(0x666666) forState:0];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.cornerRadius = 9.5;
    [view addSubview:btn];
    btn.model = model;
    
    OrderButton *btn1 = [OrderButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(SCREEN_WIDTH - 134, 35, 55, 19);
    btn1.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn1 setTitleColor:UIColorFromRGB(0x666666) forState:0];
    btn1.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
    btn1.layer.borderWidth = 0.5;
    btn1.layer.cornerRadius = 9.5;
    btn1.hidden = YES;
    [view addSubview:btn1];
    btn1.model = model;
    
    if ([model.order_status isEqualToString:@"unpay"]) {
        btn1.hidden = NO;
        [btn1 setTitle:@"取消订单" forState:0];
        [btn1 addTarget:self action:@selector(cancelorder:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"付款" forState:0];
        [btn addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColorFromRGB(0xf82f4b) forState:0];
        btn.layer.borderColor = UIColorFromRGB(0xf82f4b).CGColor;
    }else if ([model.order_status isEqualToString:@"undeliver"]){
        [btn setTitle:@"提醒发货" forState:0];
        [btn addTarget:self action:@selector(fahuo:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColorFromRGB(0xf82f4b) forState:0];
        btn.layer.borderColor = UIColorFromRGB(0xf82f4b).CGColor;
    }else if ([model.order_status isEqualToString:@"unreceive"]){
        [btn setTitle:@"确认收货" forState:0];
        [btn addTarget:self action:@selector(shouhuo:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColorFromRGB(0xf82f4b) forState:0];
        btn.layer.borderColor = UIColorFromRGB(0xf82f4b).CGColor;
    }else if ([model.order_status isEqualToString:@"completed"]){
        [btn setTitle:@"再次购买" forState:0];
        [btn addTarget:self action:@selector(payagain:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([model.order_status isEqualToString:@"cancle"]){
        [btn setTitle:@"删除订单" forState:0];
        [btn addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}
//取消订单
-(void)cancelorder:(OrderButton *)btn{
    
}
//订单付款
-(void)payOrder:(OrderButton *)btn{
    
}
//提醒发货
-(void)fahuo:(OrderButton *)btn{
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:btn.model.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderDetail Parameters:paraDic success:^(id responseObject) {
        [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
    }];
}
//确认收货
-(void)shouhuo:(OrderButton *)btn{
    
}
//删除订单
-(void)deleteOrder:(OrderButton *)btn{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:btn.model.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderDetail Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [weakself orderListWith:self.type];
        }
        [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
    }];
}
//再次购买
-(void)payagain:(OrderButton *)btn{
    FYAddOrderViewController * addorder = [[FYAddOrderViewController alloc]init];
    addorder.goods_id = btn.model.goods_id;
    [self.navigationController pushViewController:addorder animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourse.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYOrderListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYOrderListTableViewCell"];
    cell.model = self.dataSourse[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FYOrderListModel * model = self.dataSourse[indexPath.section];
    FYOrderDetailViewController * detail = [[FYOrderDetailViewController alloc]init];
    detail.order_id = model.order_id;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
