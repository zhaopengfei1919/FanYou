//
//  FYOrderDetailViewController.m
//  FanYou
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOrderDetailViewController.h"
#import "FYOrderListTableViewCell.h"

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
            self.model = [FYOrderDetailModel mj_objectWithKeyValues:[[responseObject safeObjectForKey:@"result"][@"items"] objectAtIndex:0]];
            [weakself setupUI];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)setupUI{
    
    
    self.Label1.text = [NSString stringWithFormat:@"订单编号： %@",self.model.order_no];
    self.Label2.text = [NSString stringWithFormat:@"创建时间： %@",self.model.crt_at];
    self.Label3.text = [NSString stringWithFormat:@"付款时间： %@",self.model.pay_at];
    self.Label4.text = [NSString stringWithFormat:@"发货时间： %@",self.model.delicer_at];
    self.Label5.text = [NSString stringWithFormat:@"完成时间： %@",self.model.receive_at];
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
    label.text = self.model.shop_name;
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
