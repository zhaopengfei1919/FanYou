//
//  HomeViewController.m
//  FanYou
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "FYLoginViewController.h"
#import "FYHomeTableViewCell.h"
#import "FYHomeStoreTableViewCell.h"
#import "FYHomeModel.h"
#import "FYHomeStoreModel.h"
#import "FYCenterViewController.h"
#import "FYStoreViewController.h"
#import "FYWithDrawViewController.h"
#import "FYOpenStoreViewController.h"
#import "FYStoreListViewController.h"
#import "FYGoodsListViewController.h"
#import "FYAddOrderViewController.h"
#import "FYBannerModel.h"
#import "FYWebViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,homeHeaderViewDelegate>

@property (strong,nonatomic) HomeHeaderView * header;

@end

@implementation HomeViewController
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSLog(@"%@",[FYUser userInfo].userId);
    if ([[FYUser userInfo].userId intValue] > 0) {
        self.header.headerBtn.hidden = YES;
        self.header.tishiLabel.hidden = YES;
        self.header.AdScroll.hidden = NO;
        [self adlist];
    }else{
        self.header.headerBtn.hidden = NO;
        self.header.tishiLabel.hidden = NO;
        self.header.AdScroll.hidden = YES;
    }
}
-(void)hotshop{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[NSNumber numberWithInteger:0] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:HotShop Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYHomeStoreModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            [weakself.dataSourse replaceObjectAtIndex:1 withObject:array];
            [weakself.table reloadData];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)hotgoods{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[NSNumber numberWithInteger:0] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:HotList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYHomeModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            [weakself.dataSourse replaceObjectAtIndex:0 withObject:array];
            [weakself.table reloadData];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)adlist{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    
    [NetWorkManager requestWithMethod:POST Url:AdList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            weakself.bannerArray = [FYBannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            NSMutableArray *pic = [NSMutableArray array];
            for (int i = 0; i <weakself.bannerArray.count; i ++) {
                [pic addObject:[weakself.bannerArray[i] img]];
            }
            weakself.header.imageUrl = pic;
            self.header.AdScroll.hidden = NO;
        }else
            self.header.AdScroll.hidden = YES;
    } requestRrror:^(id requestRrror) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(self.table, self);
    self.tableTop.constant = -StatusHeight;
    
    self.dataSourse = [[NSMutableArray alloc]init];
    self.bannerArray = [[NSMutableArray alloc]init];
    [self.dataSourse addObject:@[]];
    [self.dataSourse addObject:@[]];
    [self hotgoods];
    [self hotshop];

    UIView *baseHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 412+StatusHeight)];
    self.header = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:self options:nil] objectAtIndex:0];
    self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 412+StatusHeight);
    self.header.delegate = self;
    [baseHeaderView addSubview:self.header];
    self.table.tableHeaderView = baseHeaderView;
    
    [self.table registerNib:[UINib nibWithNibName:@"FYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYHomeTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"FYHomeStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYHomeStoreTableViewCell"];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidLayoutSubView{
    
}
//轮播图点击
-(void)homeScrollViewClickWith:(NSInteger)index{
    FYBannerModel * model = self.bannerArray[index];
    FYWebViewController * web = [[FYWebViewController alloc]init];
    web.webUrl = model.url;
    [self.navigationController pushViewController:web animated:YES];
}
-(void)homeheaderviewClick:(NSInteger)btntag{
    if (btntag == 3) {
        FYLoginViewController * login = [[FYLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }else if (btntag == 2){//搜索框

        return;
    }else if (btntag == 8){//店铺列表
        FYStoreListViewController * store = [[FYStoreListViewController alloc]init];
        [self.navigationController pushViewController:store animated:YES];
        return;
    }else if (btntag == 9){//商品列表
        FYGoodsListViewController * goods = [[FYGoodsListViewController alloc]init];
        [self.navigationController pushViewController:goods animated:YES];
        return;
    }
    if ([[FYUser userInfo].userId isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    if (btntag == 1){//左上角个人中心
        FYCenterViewController * center = [[FYCenterViewController alloc]init];
        [self.navigationController pushViewController:center animated:YES];
    }else if (btntag == 5){

    }else if (btntag == 6){//提现
        FYWithDrawViewController * withdraw = [[FYWithDrawViewController alloc]init];
        [self.navigationController pushViewController:withdraw animated:YES];
    }else if (btntag == 7){//开店
        FYOpenStoreViewController * openstore = [[FYOpenStoreViewController alloc]init];
        [self.navigationController pushViewController:openstore animated:YES];
    }else if (btntag == 10){
        //验证当前用户是否有店铺
        [self checkUser];
    }
}
-(void)checkUser{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    
    [NetWorkManager requestWithMethod:POST Url:MYShop Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            FYStoreViewController * store = [[FYStoreViewController alloc]init];
            store.ismyself = YES;
            store.model = [[FYHomeStoreModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]] objectAtIndex:0];
            [weakself.navigationController pushViewController:store animated:YES];
        }else{
            FYStoreViewController * store = [[FYStoreViewController alloc]init];
            store.NoShop = YES;
            [weakself.navigationController pushViewController:store animated:YES];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
    view.backgroundColor = [UIColor whiteColor];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    line.backgroundColor = UIColorFromRGB(0xeef1f2);
    [view addSubview:line];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(12, 15, 3, 14)];
    line1.backgroundColor = UIColorFromRGB(0x2daef9);
    [view addSubview:line1];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 38.5, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xdddddd);
    [view addSubview:line2];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(25, 15, 200, 14)];
    label.textColor = UIColorFromRGB(0x333333);
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"热销商品";
    if (section == 1) {
        label.text = @"热门店铺";
    }
    NSArray * array1 = self.dataSourse[0];
    NSArray * array2 = self.dataSourse[1];
    if (array1.count > 0 && array2.count > 0) {
        label.text = @"热销商品";
        if (section == 1) {
            label.text = @"热门店铺";
        }
    }else if (array2.count > 0 || array1.count > 0){
        NSString * str = array2.count > 0?@"热门店铺":@"热门商品";
        label.text = str;
    }
    [view addSubview:label];
    
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray * array1 = self.dataSourse[0];
    NSArray * array2 = self.dataSourse[1];
    if (array1.count > 0 && array2.count > 0) {
        return 2;
    }else if (array2.count > 0 || array1.count > 0){
        return 1;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array1 = self.dataSourse[0];
    NSArray * array2 = self.dataSourse[1];
    if (array1.count > 0 && array2.count > 0) {
        return [self.dataSourse[section] count];
    }else if (array2.count > 0 || array1.count > 0){
        return array2.count > 0?array2.count:array1.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array1 = self.dataSourse[0];
    NSArray * array2 = self.dataSourse[1];
    if (array1.count > 0 && array2.count > 0) {
        if (indexPath.section == 0) {
            FYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYHomeTableViewCell"];
            cell.Model = array1[indexPath.row];
            return cell;
        }
        FYHomeStoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYHomeStoreTableViewCell"];
        cell.model = array2[indexPath.row];
        return cell;
    }else if (array2.count > 0 || array1.count > 0){
        if (array1.count > 0) {
            FYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYHomeTableViewCell"];
            cell.Model = array1[indexPath.row];
            return cell;
        }
        FYHomeStoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYHomeStoreTableViewCell"];
        cell.model = array2[indexPath.row];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array1 = self.dataSourse[0];
    NSArray * array2 = self.dataSourse[1];
    if (array1.count > 0 && array2.count > 0) {
        if (indexPath.section == 1) {
            FYHomeStoreModel * model = array2[indexPath.row];
            [self pushview:model];
        }
    }else if (array2.count > 0 || array1.count > 0){
        if (array2.count > 0) {
            FYHomeStoreModel * model = array2[indexPath.row];
            [self pushview:model];
        }
    }
}
-(void)pushview:(FYHomeStoreModel *)model{
    FYStoreViewController * store = [[FYStoreViewController alloc]init];
    store.model = model;
    if ([[FYUser userInfo].userId isEqualToNumber:[NSNumber numberWithInt:0]]) {
        store.ismyself = NO;
    }else{
        if ([model.is_mine isEqualToNumber:[FYUser userInfo].userId]) {
            store.ismyself = YES;
        }else
            store.ismyself = NO;
    }
    [self.navigationController pushViewController:store animated:YES];
}
@end
