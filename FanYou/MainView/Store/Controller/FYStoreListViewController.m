//
//  FYStoreListViewController.m
//  FanYou
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYStoreListViewController.h"
#import "FYHomeStoreModel.h"
#import "FYHomeStoreTableViewCell.h"
#import "FYStoreViewController.h"

@interface FYStoreListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FYStoreListViewController
-(void)shoplist{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[NSNumber numberWithInteger:page_number] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:ShopList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYHomeStoreModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
            }
            [weakself.dataSourse addObjectsFromArray:array];
            [weakself.table reloadData];
        }else
            [SVProgressHUD showErrorWithStatus:@"没有更多店铺了"];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    } requestRrror:^(id requestRrror) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺列表";
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    self.dataSourse = [[NSMutableArray alloc]init];
    
    page_number = 0;
    [self shoplist];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor= [UIColor clearColor];
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.table];
    [self.table registerNib:[UINib nibWithNibName:@"FYHomeStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYHomeStoreTableViewCell"];

    [self refreshUI];
    // Do any additional setup after loading the view.
}
-(void)refreshUI{
    WS(weakself);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page_number = 0;
        [weakself shoplist];
    }];
    self.table.mj_header.automaticallyChangeAlpha = YES;
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page_number += 1;
        [weakself shoplist];
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
    view.backgroundColor = UIColorFromRGB(0xeef1f2);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(12, 9, 200, 12)];
    label.textColor = UIColorFromRGB(0x666666);
    label.font = [UIFont systemFontOfSize:12];
    label.text = [NSString stringWithFormat:@"全部店铺%ld家",self.dataSourse.count];
    [view addSubview:label];
    
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourse.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYHomeStoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYHomeStoreTableViewCell"];
    cell.model = self.dataSourse[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FYStoreViewController * store = [[FYStoreViewController alloc]init];
    FYHomeStoreModel * model = self.dataSourse[indexPath.row];
    if ([model.is_mine isEqualToNumber:[FYUser userInfo].userId]) {
        store.ismyself = YES;
    }else
        store.ismyself = NO;
    store.model = model;
    [self.navigationController pushViewController:store animated:YES];
}
@end
