//
//  FYStoreViewController.m
//  FanYou
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYStoreViewController.h"
#import "FYAddCommodityViewController.h"
#import "FYHomeTableViewCell.h"
#import "FYOpenStoreViewController.h"

@interface FYStoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FYStoreViewController
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (!self.NoShop) {
        [self goodslist];
    }
}
-(void)goodslist{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.model.shop_id forKey:@"shop_id"];
    [paraDic setObject:[NSNumber numberWithInteger:page_number] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:GoodsList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYHomeModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
            }
            [weakself.dataSourse addObjectsFromArray:array];
            if (weakself.dataSourse.count == 0) {
                UILabel * tishilabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 20)];
                tishilabel.textAlignment = NSTextAlignmentCenter;
                tishilabel.font = [UIFont systemFontOfSize:15];
                tishilabel.textColor = [UIColor grayColor];
                tishilabel.text = @"店铺暂无商品";
                [weakself.table addSubview:tishilabel];
            }
            [weakself.table reloadData];
        }else{
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
                [weakself.table reloadData];
            }
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    } requestRrror:^(id requestRrror) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.NoShop) {
        [self.view bringSubviewToFront:self.NoShopView];
        self.BackBtnTop.constant = 16 + StatusHeight;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
        gradientLayer.locations = @[@0.2, @0.8];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, 280, 40);
        [self.OPenShopBtn.layer addSublayer:gradientLayer];
    }else{
        [self setupUI];
        page_number = 0;
        
        self.dataSourse = [[NSMutableArray alloc]init];
        [self.table registerNib:[UINib nibWithNibName:@"FYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYHomeTableViewCell"];
        
        [self refreshUI];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)refreshUI{
    WS(weakself);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page_number = 0;
        [weakself goodslist];
    }];
    self.table.mj_header.automaticallyChangeAlpha = YES;
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page_number += 1;
        [weakself goodslist];
    }];
}
-(void)setupUI{
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:self.model.shop_logo] placeholderImage:[UIImage imageNamed:@""]];
    self.HeaderImage.layer.cornerRadius = 20;
    self.NameLabel.text = self.model.shop_name;
    self.DescTextView.text = self.model.desc;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120+StatusHeight);
    [self.BackImage.layer addSublayer:gradientLayer];
    
    self.AddView.layer.cornerRadius = 10;
    self.UploadView.layer.cornerRadius = 10;
    self.ViewTop.constant = 0;
    self.ViewHeight.constant = StatusHeight + 120;
    if (!_ismyself) {
        [self.AddView removeFromSuperview];
        [self.UploadView removeFromSuperview];
        self.AddViewHeight.constant = 5;
    }else{
        
    }
    
    self.DescTextView.layer.cornerRadius = 4;
    
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
    FYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYHomeTableViewCell"];
    cell.Model = self.dataSourse[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ismyself) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ismyself) {
        return @"删除";
    }
    return nil;
}
/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ismyself) {
        if (editingStyle == UITableViewCellEditingStyleDelete){
            FYHomeModel * Model = self.dataSourse[indexPath.row];
            WS(weakself);
            NSMutableDictionary *paraDic = @{}.mutableCopy;
            [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
            [paraDic setObject:Model.goods_id forKey:@"goods_id"];
            
            [NetWorkManager requestWithMethod:POST Url:GoodsDelete Parameters:paraDic success:^(id responseObject) {
                NSString * succeeded = [responseObject objectForKey:@"succeeded"];
                if ([succeeded intValue] == 1) {
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                    self->page_number = 0;
                    [weakself goodslist];
                }else
                    [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
            } requestRrror:^(id requestRrror) {
                
            }];
        }
    }
}

- (IBAction)UploadGoods:(id)sender {
    FYAddCommodityViewController * commodity = [[FYAddCommodityViewController alloc]init];
    commodity.shopId = self.model.shop_id;
    commodity.titleStr = @"上传商品";
    [self.navigationController pushViewController:commodity animated:YES];
}
- (IBAction)AddGoods:(id)sender {
    FYAddCommodityViewController * commodity = [[FYAddCommodityViewController alloc]init];
    commodity.shopId = self.model.shop_id;
    commodity.titleStr = @"添加商品";
    [self.navigationController pushViewController:commodity animated:YES];
}
- (IBAction)returnHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)openShop:(id)sender {
    FYOpenStoreViewController * openstore = [[FYOpenStoreViewController alloc]init];
    [self.navigationController pushViewController:openstore animated:YES];
}
@end
