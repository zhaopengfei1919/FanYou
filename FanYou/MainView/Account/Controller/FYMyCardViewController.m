//
//  FYMyCardViewController.m
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYMyCardViewController.h"
#import "FYCardTableViewCell.h"
#import "FYAddCardViewController.h"

@interface FYMyCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FYMyCardViewController
-(void)cardList{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:[NSNumber numberWithInteger:page_number] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:CardList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYCardModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
            }
            [weakself.dataSourse addObjectsFromArray:array];
            [weakself.table reloadData];
        }else{
//            [SVProgressHUD showErrorWithStatus:@"没有更多了"];
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
    [self cardList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColorFromRGB(0xeef1f2);
    page_number = 0;
    self.title = @"我的银行卡";
    self.dataSourse = [[NSMutableArray alloc]init];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerNib:[UINib nibWithNibName:@"FYCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYCardTableViewCell"];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor clearColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(12, 0, SCREEN_WIDTH - 24, 34);
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColorFromRGB(0xbecbdb).CGColor;
    [btn setTitle:@"添加银行卡" forState:0];
    [btn setTitleColor:UIColorFromRGB(0x333333) forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(addcard) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    self.table.tableFooterView = view;
    
    [self refreshUI];
    // Do any additional setup after loading the view.
}
-(void)refreshUI{
    WS(weakself);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page_number = 0;
        [weakself cardList];
    }];
    self.table.mj_header.automaticallyChangeAlpha = YES;
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page_number += 1;
        [weakself cardList];
    }];
}
-(void)addcard{
    FYAddCardViewController * addcard = [[FYAddCardViewController alloc]init];
    [self.navigationController pushViewController:addcard animated:YES];
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
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = UIColorFromRGB(0xeef1f2);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = UIColorFromRGB(0xeef1f2);
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourse.count > 0 ? self.dataSourse.count : 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYCardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYCardTableViewCell"];
    cell.backgroundColor = UIColorFromRGB(0xeef1f2);
    if (self.dataSourse.count == 0) {
        cell.EmptyView.hidden = NO;
        cell.InforView.hidden = YES;
    }else{
        cell.EmptyView.hidden = YES;
        cell.InforView.hidden = NO;
        cell.model = self.dataSourse[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSourse.count > 0) {
        return 125;
    }
    return 243;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ischosen) {
        if (self.chosen) {
            self.chosen(self.dataSourse[indexPath.row]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
