//
//  PatrolPlanViewController.m
//  eia
//
//  Created by JimmyYue on 2020/9/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "PatrolPlanViewController.h"

@interface PatrolPlanViewController ()

@end

@implementation PatrolPlanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setCountNet];
    [self.jjLabel start];  // 开始滚动轮播
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"巡查计划";
    self.view.backgroundColor = BackgroundBlack;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tourPlanView = [[NSBundle mainBundle] loadNibNamed:@"TourPlanView" owner:nil options:nil][0];
    self.tourPlanView.frame = CGRectMake(0, 10, kDeviceWidth, 70);
    self.tourPlanView.backgroundColor = BackgroundBlack;
    [self.view addSubview:self.tourPlanView];
    
    [self.tourPlanView.unfinishedBtn addTarget:self action:@selector(unfinishedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tourPlanView.planBtb addTarget:self action:@selector(planBtbAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lunView = [[UIView alloc] initWithFrame:CGRectMake(5, self.tourPlanView.frame.origin.y + self.tourPlanView.frame.size.height, kDeviceWidth - 10, 50)];
    lunView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lunView];
    
    UIImageView *laba = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 24, 24)];
    laba.image = IMAGENAMED(@"home_new");
    [lunView addSubview:laba];
    
    self.jjLabel = [[JJScorllTextLable alloc] initWithFrame:CGRectMake(45, 0, kDeviceWidth - 75, 50)];
    self.jjLabel.rate = 0.03;
    self.jjLabel.font = [UIFont systemFontOfSize:16];
    self.jjLabel.textColor = TabbarBlack;
    [lunView addSubview:self.jjLabel];
    
    self.jjLabel.text = @"               上海环鉴环境科技有限公司成立于2018年06月06日，公司地位于上海市青浦区双联路158号2层V区228室。经营范围包括从事环境检测领域内的技术服务，环境工程，企业管理咨询，从事环保科技领域的技术开发、技术服务、技术咨询、技术转让，销售仪表仪器、环保设备、电子产品、五金交电、水处理设备。 【依法须经批准的项目，经相关部门批准后方可开展经营活动】";
    [self.jjLabel start];
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, lunView.frame.origin.y + lunView.frame.size.height + 5, kDeviceWidth - 10, kDeviceHeight - (lunView.frame.origin.y + lunView.frame.size.height + 55) - StatusRect - NavRect)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.companyBottomView = [[NSBundle mainBundle] loadNibNamed:@"CompanyBottomView" owner:nil options:nil][0];
    self.companyBottomView.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, kDeviceWidth, 50);
    [self.view addSubview:self.companyBottomView];
    
    [self.companyBottomView.pushBtn.layer setCornerRadius:3.0];
    self.companyBottomView.pushBtn.layer.borderWidth = 1;
    self.companyBottomView.pushBtn.layer.borderColor = TableViewLineColor.CGColor;
    [self.companyBottomView.pushBtn addTarget:self action:@selector(pushBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.companyBottomView.beforePageBtn addTarget:self action:@selector(beforePageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.companyBottomView.afterPageBtn addTarget:self action:@selector(afterPageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.start = 1;
    [self setEnterpriseListNet];
}

- (void)rightBtnAction {
    AddPlanViewController *addCV = [[AddPlanViewController alloc] init];
    [addCV setBlock:^(NSString * _Nonnull reload) {
        [self setEnterpriseListNet];
    }];
    [self.navigationController pushViewController:addCV animated:YES];
}

- (void)unfinishedBtnAction {
    UnfinishedViewController *unfinishedVC = [[UnfinishedViewController alloc] init];
    unfinishedVC.tourPlanStatus = @"unfinish";
    [self.navigationController pushViewController:unfinishedVC animated:YES];
}

- (void)planBtbAction {
    InThePlanViewController *planVC = [[InThePlanViewController alloc] init];
    [planVC setBlock:^(NSString * _Nonnull rload) {
        [self setEnterpriseListNet];
    }];
    planVC.tourPlanStatus = @"patrol";
    [self.navigationController pushViewController:planVC animated:YES];
}

- (void)loadNewData {
    [self setEnterpriseListNet];
}

- (void)beforePageBtnAction {
    if (self.start > 1) {
        self.start = self.start--;
        [self setEnterpriseListNet];
    }
}

- (void)afterPageBtnAction {
    if (self.start < [self.totalPageCount intValue]) {
        self.start = self.start++;
        [self setEnterpriseListNet];
    }
}

- (void)pushBtnAction {  // 跳转
    CompanyPushPageView *pushVC = [[CompanyPushPageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    pushVC.view = self.view;
    [pushVC setAllowCompanyPushPageView:self.totalPageCount start:[NSString stringWithFormat:@"%d", self.start]];
    [pushVC setBlock:^(int start) {
        if (start != self.start) {
            self.start = start;
            [self setEnterpriseListNet];
        }
    }];
    [self.view addSubview:pushVC];
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

//  分区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = BackgroundBlack;
    return viewHeader;
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 5;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"ParkEnterprisesTableViewCell";
    ParkEnterprisesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ParkEnterprisesTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    cell.updateBtn.layer.borderWidth = 1;
    cell.updateBtn.layer.borderColor = TabbarBlack_S.CGColor;
    
    cell.addBtn.layer.borderWidth = 1;
    cell.addBtn.layer.borderColor = TabbarBlack_S.CGColor;
    
    WorkModel*workModel = [[WorkModel alloc] init];
    workModel = self.arrayListResult[indexPath.section];

    cell.titleLabel.text = [NSString stringWithFormat:@"%@", workModel.enterpriseName];
    
    if ([IsBlankString isBlankString:workModel.parkName] == NO) {
        cell.parkLabel.text = [NSString stringWithFormat:@"%@", workModel.parkName];
    }
    
    if ([IsBlankString isBlankString:workModel.cityName] == NO) {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@%@", workModel.cityName, workModel.regionName];
    }
     if ([IsBlankString isBlankString:workModel.cpyObjAddress] == NO) {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@%@", cell.addressLabel.text, workModel.cpyObjAddress];
     }
    
    if ([IsBlankString isBlankString:workModel.summaryEia] == NO) {
        cell.summaryEiaLabel.text = [NSString stringWithFormat:@"%@", workModel.summaryEia];
    }
    if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", workModel.NewTourPlanTime]] == NO) {
        cell.timeLabel.text = [NSString stringWithFormat:@"最近巡查 : %@", workModel.NewTourPlanTime];
//        cell.timeLabel.text = [NSString stringWithFormat:@"最近巡查 : %@", [[NSString stringWithFormat:@"%@", workModel.NewTourPlanTime] timeToyyyy_MM_dd]];
    }
    
    [cell.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag = 320 + indexPath.section;
   
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)addBtnAction:(UIButton *)button {
    WorkModel*workModel = [[WorkModel alloc] init];
    workModel = self.arrayListResult[button.tag - 320];
    
    AddPatrolViewController *addVC = [[AddPatrolViewController alloc] init];
    addVC.EtpId = [NSString stringWithFormat:@"%@", workModel.Id];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    WorkModel*workModel = [[WorkModel alloc] init];
    workModel = self.arrayListResult[indexPath.section];
    if ([workModel.flagMake isEqualToString:@"make"]) {
        ParkEnterprisesDetailViewController *detailVC = [[ParkEnterprisesDetailViewController alloc] init];
        detailVC.Id = [NSString stringWithFormat:@"%@", workModel.Id];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        EnterprisesDetailNoProductionViewController *detailVC = [[EnterprisesDetailNoProductionViewController alloc] init];
        detailVC.Id = [NSString stringWithFormat:@"%@", workModel.Id];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 155;
}

- (void)setEnterpriseListNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    NSMutableDictionary *dicP = [[NSMutableDictionary alloc] init];
    [dicP setObject:@"20" forKey:@"pageSize"];
    [dicP setObject:[NSString stringWithFormat:@"%d", (self.start - 1) * 20] forKey:@"start"];
   
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/query") parameters:dicP view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.arrayListResult = [NSMutableArray array];
            
            self.totalPageCount = [NSString stringWithFormat:@"%@", result[@"result"][@"totalPageCount"]];
            self.companyBottomView.pageLabel.text = [NSString stringWithFormat:@"%d/%@页", self.start, self.totalPageCount];
            
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                array = [[result objectForKey:@"result"] objectForKey:@"data"];
                
                for (NSMutableDictionary *dic in array) {
                    WorkModel*workModel = [[WorkModel alloc] init];
                    [workModel setValuesForKeysWithDictionary:dic[@"enterprise"]];
                    workModel.planId = dic[@"id"];
                    if ([[dic allKeys] containsObject:@"tourPlanId"]) {
                        workModel.tourPlanId = dic[@"tourPlanId"];
                        workModel.tourPlanStatus = dic[@"tourPlanStatus"];
                        workModel.NewTourPlanTime = dic[@"newTourPlanTime"];
                    }
                    [self.arrayListResult addObject:workModel];
                }
            }
            
            [self.tableView reloadData];
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteActionD = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除计划" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否移除计划?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            WorkModel*workModel = [[WorkModel alloc] init];
            workModel = self.arrayListResult[indexPath.section];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[NSString stringWithFormat:@"%@", workModel.planId] forKey:@"id"];
            [dic setObject:@"finish" forKey:@"tourPlanStatus"];
            [dic setObject:@(true) forKey:@"isDeleted"];
            [self setupdateNet:@{@"entity":dic}];
        }]];
        [self presentViewController:alert animated:YES completion:^{ }];
    }];
    deleteActionD.backgroundColor = RGBCOLOR(252, 39, 11);
    
    UITableViewRowAction *deleteActionR = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记为完成" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否标记为完成?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            WorkModel*workModel = [[WorkModel alloc] init];
            workModel = self.arrayListResult[indexPath.section];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[NSString stringWithFormat:@"%@", workModel.planId] forKey:@"id"];
            [dic setObject:@"finish" forKey:@"tourPlanStatus"];
            [dic setObject:@(false) forKey:@"isDeleted"];
            [self setupdateNet:@{@"entity":dic}];
        }]];
        [self presentViewController:alert animated:YES completion:^{ }];
    }];
    deleteActionR.backgroundColor = RGBCOLOR(26, 152, 7);
    return @[deleteActionD, deleteActionR];
}
 
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (void)setCountNet {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/statusCount") parameters:@{} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
        
            if ([result[@"result"] count] > 0) {
                for (int i = 0; i < [result[@"result"] count]; i++) {
                    if ([[NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatus"]] isEqualToString:@"unfinish"]) {
                        self.tourPlanView.unfinishedLabel.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@家", result[@"result"][i][@"tourPlanStatusCount"]]];
                    } else if ([[NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatus"]] isEqualToString:@"patrol"]) {
                        self.tourPlanView.planLabel.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@家", result[@"result"][i][@"tourPlanStatusCount"]]];
                    }
                }
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupdateNet:(NSDictionary *)dic {
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = @"提交中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/update") parameters:dic view:self completion:^(id result) {
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([result[@"isSuccess"] intValue] == 1) {
            [self setEnterpriseListNet];
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
