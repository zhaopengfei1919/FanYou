//
//  FYGoodsListViewController.m
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYGoodsListViewController.h"
#import "FYHomeModel.h"
#import "FYHomeTableViewCell.h"

@interface FYGoodsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FYGoodsListViewController
-(void)goodsList{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[NSNumber numberWithInteger:page_number] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:GoodsList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYHomeModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            if (self->page_number == 0) {
                [weakself.dataSourse removeAllObjects];
            }
            [weakself.dataSourse addObjectsFromArray:array];
            [weakself.table reloadData];
        }else
            [SVProgressHUD showErrorWithStatus:@"没有更多商品了"];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    } requestRrror:^(id requestRrror) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    self.dataSourse = [[NSMutableArray alloc]init];
    
    page_number = 0;
    [self goodsList];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc]init];
    self.table.backgroundColor= [UIColor clearColor];
    [self.view addSubview:self.table];
    [self.table registerNib:[UINib nibWithNibName:@"FYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FYHomeTableViewCell"];
    
    [self refreshUI];
    // Do any additional setup after loading the view.
}
-(void)refreshUI{
    WS(weakself);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page_number = 0;
        [weakself goodsList];
    }];
    self.table.mj_header.automaticallyChangeAlpha = YES;
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page_number += 1;
        [weakself goodsList];
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
    label.text = [NSString stringWithFormat:@"全部商品%ld件",self.dataSourse.count];
    [view addSubview:label];
    
    return view;
}
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
