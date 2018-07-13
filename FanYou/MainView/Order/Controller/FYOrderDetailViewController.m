//
//  FYOrderDetailViewController.m
//  FanYou
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOrderDetailViewController.h"
#import "FYOrderListTableViewCell.h"
#import "FYAddOrderViewController.h"

@interface FYOrderDetailViewController ()

@end

@implementation FYOrderDetailViewController
-(void)orderdetail{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderDetail Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            self.model = [FYOrderDetailModel mj_objectWithKeyValues:[responseObject safeObjectForKey:@"result"]];
            [weakself setupUI];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)setupUI{
    [self.table reloadData];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 62);
    [self.BackView.layer addSublayer:gradientLayer];
    
    self.NameLabel.text = self.model.acc_name;
    self.PhoneLabel.text = self.model.acc_mobile;
    self.AreaLabel.text = self.model.acc_addr;
    CGSize size = CGSizeMake(SCREEN_WIDTH - 45,2000);
    NSDictionary * fontDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil];
    CGRect labelsize = [self.AreaLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    if (labelsize.size.height < 28) {
        self.AreaViewHeight.constant = labelsize.size.height;
    }else
        self.AreaViewHeight.constant = 28;
    
    self.GoodPrice.text = [NSString stringWithFormat:@"￥%.2f",[self.model.goods_price floatValue] * [self.model.goods_count intValue]];
    self.Yunfei.text = [NSString stringWithFormat:@"￥%.2f",[self.model.express_fee floatValue]];
    self.totalPrice.text = [NSString stringWithFormat:@"￥%.2f",[self.model.total_price floatValue]];
    
    [self.Btn1 setTitleColor:UIColorFromRGB(0x666666) forState:0];
    self.Btn1.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
    self.Btn1.layer.borderWidth = 0.5;
    self.Btn1.layer.cornerRadius = 9.5;
    [self.Btn2 setTitleColor:UIColorFromRGB(0x666666) forState:0];
    self.Btn2.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
    self.Btn2.layer.borderWidth = 0.5;
    self.Btn2.layer.cornerRadius = 9.5;
    if ([self.model.order_status isEqualToString:@"unpay"]) {
        self.StatusLabel.text = @"等待付款";
        self.Label1.text = [NSString stringWithFormat:@"订单编号： %@",self.model.order_no];
        self.Label2.text = [NSString stringWithFormat:@"创建时间： %@",self.model.crt_at];
        self.Btn1.hidden = NO;
        [self.Btn1 setTitle:@"取消订单" forState:0];
        [self.Btn1 addTarget:self action:@selector(cancelorder:) forControlEvents:UIControlEventTouchUpInside];
        [self.Btn2 setTitle:@"付款" forState:0];
        [self.Btn2 addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.model.order_status isEqualToString:@"undeliver"]){
        self.StatusLabel.text = @"等待发货";
        self.Label1.text = [NSString stringWithFormat:@"订单编号： %@",self.model.order_no];
        self.Label2.text = [NSString stringWithFormat:@"创建时间： %@",self.model.crt_at];
        self.Label3.text = [NSString stringWithFormat:@"付款时间： %@",self.model.pay_at];
        [self.Btn2 setTitle:@"提醒发货" forState:0];
        [self.Btn2 addTarget:self action:@selector(fahuo:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.model.order_status isEqualToString:@"unreceive"]){
        self.StatusLabel.text = @"等待收货";
        self.Label1.text = [NSString stringWithFormat:@"订单编号： %@",self.model.order_no];
        self.Label2.text = [NSString stringWithFormat:@"创建时间： %@",self.model.crt_at];
        self.Label3.text = [NSString stringWithFormat:@"付款时间： %@",self.model.pay_at];
        self.Label4.text = [NSString stringWithFormat:@"发货时间： %@",self.model.delicer_at];
        [self.Btn2 setTitle:@"确认收货" forState:0];
        [self.Btn2 addTarget:self action:@selector(shouhuo:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.model.order_status isEqualToString:@"completed"]){
        self.StatusLabel.text = @"交易成功";
        self.Label1.text = [NSString stringWithFormat:@"订单编号： %@",self.model.order_no];
        self.Label2.text = [NSString stringWithFormat:@"创建时间： %@",self.model.crt_at];
        self.Label3.text = [NSString stringWithFormat:@"付款时间： %@",self.model.pay_at];
        self.Label4.text = [NSString stringWithFormat:@"发货时间： %@",self.model.delicer_at];
        self.Label5.text = [NSString stringWithFormat:@"完成时间： %@",self.model.receive_at];
        [self.Btn2 setTitle:@"再次购买" forState:0];
        [self.Btn2 addTarget:self action:@selector(payagain:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.model.order_status isEqualToString:@"cancle"]){
        self.StatusLabel.text = @"订单取消";
        self.Label1.text = [NSString stringWithFormat:@"订单编号： %@",self.model.order_no];
        self.Label2.text = [NSString stringWithFormat:@"创建时间： %@",self.model.crt_at];
        [self.Btn2 setTitle:@"删除订单" forState:0];
        [self.Btn2 addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//取消订单
-(void)cancelorder:(UIButton *)btn{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.model.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderLose Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
    }];
}
//订单付款
-(void)payOrder:(UIButton *)btn{
    
}
//提醒发货
-(void)fahuo:(UIButton *)btn{
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.model.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:Hintdeliver Parameters:paraDic success:^(id responseObject) {
        [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
    }];
}
//确认收货
-(void)shouhuo:(UIButton *)btn{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.model.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderConfirm Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
    }];
}
//删除订单
-(void)deleteOrder:(UIButton *)btn{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.model.order_id forKey:@"order_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderDelete Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
    }];
}
//再次购买
-(void)payagain:(UIButton *)btn{
    FYAddOrderViewController * addorder = [[FYAddOrderViewController alloc]init];
    addorder.goods_id = self.model.goods_id;
    [self.navigationController pushViewController:addorder animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self orderdetail];
    [self.table registerNib:[UINib nibWithNibName:@"FYOrderListTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYOrderListTableViewCell"];
    // Do any additional setup after loading the view from its nib.
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
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * images = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 12, 11)];
    images.image = [UIImage imageNamed:@"店铺icon -"];
    [view addSubview:images];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, 9, 200, 12)];
    label.textColor = UIColorFromRGB(0x666666);
    label.font = [UIFont systemFontOfSize:12];
    label.text = [NSString stringWithFormat:@"%@",self.model.shop_name];
    
//    UIImageView * image = [[UIImageView alloc]initWithFrame:cgrectm];
    [view addSubview:label];
    
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYOrderListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYOrderListTableViewCell"];
    cell.detailmodel = self.model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
