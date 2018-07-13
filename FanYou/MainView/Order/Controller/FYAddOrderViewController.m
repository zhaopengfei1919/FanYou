//
//  FYAddOrderViewController.m
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYAddOrderViewController.h"
#import "OrderHeaderView.h"
#import "FYOrderFooterView.h"
#import "FYOrderTableViewCell.h"
#import "FYAddressModel.h"

@interface FYAddOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) OrderHeaderView * headerView;
@property (strong,nonatomic) FYOrderFooterView * footerView;

@end

@implementation FYAddOrderViewController
-(void)getDefaultAddress{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    
    [NetWorkManager requestWithMethod:POST Url:GetDefault Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            FYAddressModel * model = [FYAddressModel mj_objectWithKeyValues:[responseObject safeObjectForKey:@"result"]];
            weakself.headerView.model = model;
        }else{
            [weakself.headerView.AddressBtn setTitle:@"点击选择收货地址" forState:0];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)goodsInfo{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.goods_id forKey:@"goods_id"];
    
    [NetWorkManager requestWithMethod:POST Url:GoodInfo Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            weakself.model = [FYHomeModel mj_objectWithKeyValues:[[responseObject safeObjectForKey:@"result"][@"items"] objectAtIndex:0]];
            [self.table reloadData];
        }else{
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    
    [self getDefaultAddress];
    [self goodsInfo];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)setupUI{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor= [UIColor clearColor];
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.table];
    [self.table registerNib:[UINib nibWithNibName:@"FYOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYOrderTableViewCell"];
    
    UIView *baseHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 81)];
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"OrderHeaderView" owner:self options:nil] objectAtIndex:0];
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 81);
    [baseHeaderView addSubview:self.headerView];
    self.table.tableHeaderView = baseHeaderView;
    
    UIView *baseFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 125)];
    self.footerView = [[[NSBundle mainBundle] loadNibNamed:@"FYOrderFooterView" owner:self options:nil] objectAtIndex:0];
    self.footerView.isniming = YES;
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 125);
    [self.footerView.jianBtn addTarget:self action:@selector(jian) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView.jiaBtn addTarget:self action:@selector(jia) forControlEvents:UIControlEventTouchUpInside];
    [baseFooterView addSubview:self.footerView];
    self.table.tableFooterView = baseFooterView;
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT -44 - StatusHeight - 44 - BarBottomHeight, SCREEN_WIDTH, 44 + BarBottomHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH - 140, 0, 140, 44);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, 140, 44);
    [btn.layer addSublayer:gradientLayer];
    
    [btn setTitle:@"提交订单" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:0];
    [btn addTarget:self action:@selector(addorder) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 300, 15, 145, 14)];
    self.priceLabel.font = [UIFont systemFontOfSize:13];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:self.priceLabel];
    
    [self price];
}
-(void)jian{
    int count = [self.footerView.CountLabel.text intValue];
    if (count == 1) {
        [SVProgressHUD showErrorWithStatus:@"已到最小数量1"];
        return;
    }
    count --;
    self.footerView.CountLabel.text = [NSString stringWithFormat:@"%d",count];
    [self price];
}
-(void)jia{
    int count = [self.footerView.CountLabel.text intValue];
    count ++;
    self.footerView.CountLabel.text = [NSString stringWithFormat:@"%d",count];
    [self price];
}
-(void)price{
    int count = [self.footerView.CountLabel.text intValue];
    int price = [self.model.goods_price intValue] * count;
    NSString * str = [NSString stringWithFormat:@"共%d件商品  小计：￥%d",count,price];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(self.footerView.CountLabel.text.length + 10, string.length - self.footerView.CountLabel.text.length - 10)];
    [string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf82f4b) range:NSMakeRange(self.footerView.CountLabel.text.length + 9, string.length - self.footerView.CountLabel.text.length - 9)];
    self.footerView.PriceLabel.attributedText = string;
    
    NSString * str1 = [NSString stringWithFormat:@"合计金额：￥%d",price];
    NSMutableAttributedString * string1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(6, string1.length - 6)];
    [string1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf82f4b) range:NSMakeRange(5, string1.length - 5)];
    self.priceLabel.attributedText = string1;
}
-(void)addorder{
    int num = [self.headerView.model.addr_id intValue];
    if (num == 0){
        [SVProgressHUD showErrorWithStatus:@"请选择收货地址"];
        return;
    }
//    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.headerView.model.addr_id forKey:@"addr_id"];
    [paraDic setObject:self.goods_id forKey:@"goods_id"];
    int count = [self.footerView.CountLabel.text intValue];
    [paraDic setObject:[NSNumber numberWithInt:count] forKey:@"goods_count"];
    [paraDic setObject:[NSNumber numberWithBool:self.footerView.isniming] forKey:@"is_anonymous"];
    [paraDic setObject:[NSNumber numberWithFloat:6.00] forKey:@"express_fee"];
    float price = [self.model.goods_price floatValue] * count + 6;
    [paraDic setObject:[NSNumber numberWithFloat:price] forKey:@"total_price"];
    
    
    [NetWorkManager requestWithMethod:POST Url:OrderCreate Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {

        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
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
    label.text = self.model.shop_name;
    [view addSubview:label];
    
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.model.goods_icon.length == 0) {
        return 0;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYOrderTableViewCell"];
    cell.model = self.model;
    [self price];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
