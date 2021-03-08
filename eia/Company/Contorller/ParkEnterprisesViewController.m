//
//  ParkEnterprisesViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ParkEnterprisesViewController.h"

@interface ParkEnterprisesViewController ()

@end

@implementation ParkEnterprisesViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
}

- (void)reloadList {  // 详情更新或重新登录刷新列表
    [self loadNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"ReloadList" object:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.view.backgroundColor = BackgroundBlack;
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, StatusRect, kDeviceWidth, NavRect)];
    self.searchView.backgroundColor = TabbarBlack_S;
    [self.view addSubview:self.searchView];
    
    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(10, NavRect - 40, kDeviceWidth - 160, 30)];
    self.searchText.textColor = [UIColor blackColor];
    self.searchText.font = [UIFont systemFontOfSize:15];
    self.searchText.backgroundColor = [UIColor whiteColor];
    [self.searchText.layer setMasksToBounds:YES];
    self.searchText.delegate = self;
    self.searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchText.placeholder = @"输入企业名称可快速查询";
    _searchText.returnKeyType = UIReturnKeySearch; //变为搜索按钮
    [self.searchText.layer setCornerRadius:8.0];
    [self.searchView addSubview:self.searchText];
    UIView *serviceChargeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    self.searchText.leftView = serviceChargeView;
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageViewSearch = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 24, 24)];
    imageViewSearch.image = IMAGENAMED(@"search");
    [self.searchText addSubview:imageViewSearch];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, NavRect - 40, 30, 30);
    [btn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:btn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:IMAGENAMED(@"company_search") forState:UIControlStateNormal];
    [searchBtn setTitle:@"筛选" forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(self.searchText.frame.origin.x + self.searchText.frame.size.width + 10, self.searchText.frame.origin.y, 60, 30);
    [searchBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn.layer setCornerRadius:8.0];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBtn addTarget:self action:@selector(searchSBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:searchBtn];
    
    UIButton *sortingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortingBtn setImage:IMAGENAMED(@"company_ sorting") forState:UIControlStateNormal];
    [sortingBtn setTitle:@"排序" forState:UIControlStateNormal];
    sortingBtn.frame = CGRectMake(searchBtn.frame.origin.x + searchBtn.frame.size.width + 10, self.searchText.frame.origin.y, 60, 30);
    [sortingBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    sortingBtn.backgroundColor = [UIColor whiteColor];
    [sortingBtn.layer setCornerRadius:8.0];
    sortingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sortingBtn addTarget:self action:@selector(sortingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:sortingBtn];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init]; //(这儿取你当前tabBarVC的实例)
    CGFloat tabBarHeight = tabBarVC.tabBar.frame.size.height;
    
    if ([[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone X"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone XS"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone XS MAX"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone XR"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone 11"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone 11 Pro"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone 11 Pro MAX"] || [[DeviceIdentifier getDeviceIdentifier] isEqualToString:@"iPhone Simulator"]) {
        tabBarHeight = tabBarVC.tabBar.frame.size.height + 34;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, StatusRect + NavRect, kDeviceWidth - 10, kDeviceHeight - StatusRect - NavRect - tabBarHeight - 41)];
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
    self.companyBottomView.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, kDeviceWidth, 41);
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

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [self searchBtnAction];
    [textField resignFirstResponder];
    return YES;
}

- (void)searchBtnAction {  // 查找
    self.start = 1;
    [self setEnterpriseListNet];
}

- (void)searchSBtnAction {  // 筛选
    CommpanySearchViewController *searchVC = [[CommpanySearchViewController alloc] init];
    searchVC.dicSearch = self.searchDic;
    [searchVC setBlock:^(NSMutableDictionary * _Nonnull dic) {
        if (dic.count > 0) {
            self.searchDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            self.start = 1;
            [self setEnterpriseListNet];
        } else {
            self.searchDic = [NSMutableDictionary dictionary];
            self.start = 1;
            [self setEnterpriseListNet];
        }
    }];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
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

- (void)sortingBtnAction {  // 排序
    SortView *sortView = [[SortView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    sortView.view = self.view;
    [sortView setAllowSortView:NavRect index:self.sortsIndex];
    [sortView setBlock:^(NSString * _Nonnull orderBy, NSString * _Nonnull sortsIndex) {
        self.orderBy = orderBy;
        self.sortsIndex = sortsIndex;
        self.start = 1;
        [self setEnterpriseListNet];
    }];
    [self.view addSubview:sortView];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 155;
}

- (void)setEnterpriseListNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    NSMutableDictionary *dicP = [[NSMutableDictionary alloc] init];
    [dicP setObject:@"20" forKey:@"pageSize"];
    [dicP setObject:[NSString stringWithFormat:@"%d", (self.start - 1) * 20] forKey:@"start"];
    if (self.searchDic.count > 0) {
        [dicP setObject:self.searchDic forKey:@"entity"];
    } else {
        [dicP setObject:@{} forKey:@"entity"];
    }
    if ([IsBlankString isBlankString:self.searchText.text] == NO) {
        [dicP setObject:self.searchText.text forKey:@"keyword"];
    }
    if ([IsBlankString isBlankString:self.orderBy] == NO) {
        [dicP setObject:self.orderBy forKey:@"orderBy"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/query") parameters:dicP view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.arrayListResult = [NSMutableArray array];
            
            self.totalPageCount = [NSString stringWithFormat:@"%@", result[@"result"][@"totalPageCount"]];
            self.companyBottomView.pageLabel.text = [NSString stringWithFormat:@"%d/%@页", self.start, self.totalPageCount];
            
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                array = [[result objectForKey:@"result"] objectForKey:@"data"];
                
                for (NSMutableDictionary *dic in array) {
                    WorkModel*workModel = [[WorkModel alloc] init];
                    [workModel setValuesForKeysWithDictionary:dic];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
