//
//  HZCityViewController.m
//  DLWebsite
//
//  Created by Xiaoheng on 15/3/4.
//  Copyright (c) 2015年 XH. All rights reserved.
//

#import "HZCityViewController.h"

#import "FYAddAddressViewController.h"

@interface HZCityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HZCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"区域选择";
    
    self.array = [[FYUser userInfo] getProvince];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusHeight - BarBottomHeight) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.table];
    [self.table reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *laodMoreCellIdentifierMore1 = @"laodMoreCellIdentifierMore1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:laodMoreCellIdentifierMore1];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:laodMoreCellIdentifierMore1];
    }
    
    if (type == 0) {
        HZProvince *province1 = [self.array objectAtIndex:indexPath.row];
        cell.textLabel.text = province1.name;
    }else if (type == 1){
        HZCity *province1 = [self.array objectAtIndex:indexPath.row];
        cell.textLabel.text = province1.name;
    }else if (type == 2){
        HZDistrict *province1 = [self.array objectAtIndex:indexPath.row];
        cell.textLabel.text = province1.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (type == 0){
        HZProvince *province1 = [self.array objectAtIndex:indexPath.row];
        province = province1.name;
        provinceid = province1.code;
        NSLog(@"%@",province1.name);
        self.array = [[FYUser userInfo] getCity:province1.code];
        type = 1;
        [self.table reloadData];
        
    }else if (type == 1){
        HZDistrict *province1 = [self.array objectAtIndex:indexPath.row];
        city = province1.name;
        cityid = province1.code;
        NSLog(@"%@",province1.name);
        self.array = [[FYUser userInfo] getDistrict:province1.code];
        type = 2;
        [self.table reloadData];
    }else if (type == 2){
        HZCity *province1 = [self.array objectAtIndex:indexPath.row];
        area = province1.name;
        areaid = province1.code;
        NSLog(@"%@",province1.name);
        
        NSArray *array = self.navigationController.viewControllers;
        FYAddAddressViewController *address = [array objectAtIndex:array.count - 2];
        address.province = province;
        address.city = city;
        address.area = area;
        address.provinceid = provinceid;
        address.cityid = cityid;
        address.areaid = areaid;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
