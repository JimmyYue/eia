//
//  ParkManagementViewController.m
//  eia
//
//  Created by JimmyYue on 2020/4/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ParkManagementViewController.h"

@interface ParkManagementViewController ()

@end

@implementation ParkManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"园区管理";
    self.view.backgroundColor = BackgroundBlack;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    line.backgroundColor = RGBCOLOR(240, 240, 240);
    [self.view addSubview:line];
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 71)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackgroundBlack;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.refreshStr = @"down";
    self.start = @"0";
    self.pageSize = @"20";
    [self setNetList];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(30, self.tableView.frame.origin.y + self.tableView.frame.size.height + 10, kDeviceWidth - 60, 45);
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.backgroundColor = TabbarBlack_S;
    [addBtn.layer setCornerRadius:10.0];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)addBtnAction {
    NewParkViewController *addVC = [[NewParkViewController alloc] init];
    addVC.type = @"add";
    [addVC setBlock:^(NSDictionary * _Nonnull dic) {
        ParkManagementModel*parkManagementModel = [[ParkManagementModel alloc] init];
        [parkManagementModel setValuesForKeysWithDictionary:dic];
        [self.arrayListResult addObject:parkManagementModel];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)loadNewData {
    self.refreshStr = @"down";
    self.start = @"0";
    [self setNetList];
}

- (void)loadMoreData {
    self.refreshStr = @"up";
    self.start = [NSString stringWithFormat:@"%ld", self.arrayListResult.count];
    [self setNetList];
}

//设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayListResult.count;
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//  分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = BackgroundBlack;
    return viewHeader;
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"ParkManagementTableViewCell";
    ParkManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ParkManagementTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    ParkManagementModel*parkManagementModel = [[ParkManagementModel alloc] init];
    parkManagementModel = self.arrayListResult[indexPath.section];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", parkManagementModel.parkName];
    
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", parkManagementModel.lotTypeName];
    
    if ([IsBlankString isBlankString:parkManagementModel.streetName] == NO) {
        cell.addressLabel.text = [NSString stringWithFormat:@"行政区域 : %@%@%@", parkManagementModel.cityName, parkManagementModel.regionName, parkManagementModel.streetName];
    } else {
        cell.addressLabel.text = [NSString stringWithFormat:@"行政区域  : %@%@", parkManagementModel.cityName, parkManagementModel.regionName];
    }
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    ParkManagementModel*parkManagementModel = [[ParkManagementModel alloc] init];
    parkManagementModel = self.arrayListResult[indexPath.section];
    ParkDetailViewController *parkDetailVC = [[ParkDetailViewController alloc] init];
    parkDetailVC.parkCode = [NSString stringWithFormat:@"%@", parkManagementModel.Id];
    [parkDetailVC setBlock:^(NSDictionary * _Nonnull dic) {
        ParkManagementModel*parkManagementModel = [[ParkManagementModel alloc] init];
        [parkManagementModel setValuesForKeysWithDictionary:dic];
        [self.arrayListResult replaceObjectAtIndex:indexPath.section withObject:parkManagementModel];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:parkDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (void)setNetList {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"townpark/query") parameters:@{@"findRange":@"my", @"pageSize":self.pageSize, @"start":self.start, @"entity":@{}} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            if ([self.refreshStr isEqualToString:@"down"]) {
                self.arrayListResult = [NSMutableArray array];
            }
            
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                array = [[result objectForKey:@"result"] objectForKey:@"data"];
                
                for (NSMutableDictionary *dic in array) {
                    ParkManagementModel*parkManagementModel = [[ParkManagementModel alloc] init];
                    [parkManagementModel setValuesForKeysWithDictionary:dic];
                    [self.arrayListResult addObject:parkManagementModel];
                }
            }
            if ([self.refreshStr isEqualToString:@"down"] || [result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                [self.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
