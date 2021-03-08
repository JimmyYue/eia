//
//  InThePlanViewController.m
//  eia
//
//  Created by JimmyYue on 2020/9/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "InThePlanViewController.h"

@interface InThePlanViewController ()

@end

@implementation InThePlanViewController

- (void)reloadList {  // 详情更新刷新列表
    [self setEnterpriseListNet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"ReloadList" object:nil];
    
    self.title = @"计划中 ";
    self.view.backgroundColor = BackgroundBlack;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *beforeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beforeBtn setTitle:@"前一天" forState:UIControlStateNormal];
    beforeBtn.frame = CGRectMake(10, 5, 60, 40);
    [beforeBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    beforeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [beforeBtn addTarget:self action:@selector(beforeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:beforeBtn];
    
    UIButton *afterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [afterBtn setTitle:@"后一天" forState:UIControlStateNormal];
    afterBtn.frame = CGRectMake(kDeviceWidth - 70, 5, 60, 40);
    [afterBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    afterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [afterBtn addTarget:self action:@selector(afterBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:afterBtn];
    
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY年MM月dd日"];
//    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    
    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.timeBtn setTitle:[NSString stringWithFormat:@"今天  %@", dateTime] forState:UIControlStateNormal];
    [self.timeBtn setTitle:@"计划时间" forState:UIControlStateNormal];
    self.timeBtn.frame = CGRectMake(80, 7.5, kDeviceWidth - 160, 35);
    [self.timeBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.timeBtn.layer setCornerRadius:10.0];
    self.timeBtn.layer.borderWidth = 1;
    self.timeBtn.layer.borderColor = TabbarBlack_S.CGColor;
    [self.timeBtn addTarget:self action:@selector(timeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.timeBtn];
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 51, kDeviceWidth - 10, kDeviceHeight - StatusRect - NavRect - 51)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackgroundBlack;
    [self.view addSubview:self.tableView];
    
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *dateTimeS = [formatter stringFromDate:[NSDate date]];
//    self.tourPlanTime = dateTimeS;
    
    [self setEnterpriseListNet];
    
}

- (void)beforeBtnAction {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    if ([self.timeBtn.titleLabel.text isEqualToString:@"计划时间"]) {
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];
        NSString *dateTime=[dateFormat stringFromDate:lastDay];
        [self.timeBtn setTitle:dateTime forState:UIControlStateNormal];
        self.tourPlanTime = dateTime;
        [self setEnterpriseListNet];
    } else {
        NSString *dateString=[NSString stringWithFormat:@"%@", self.timeBtn.titleLabel.text];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        NSDate *date =[dateFormat dateFromString:dateString];
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
        NSString *dateTime=[dateFormat stringFromDate:lastDay];
        [self.timeBtn setTitle:dateTime forState:UIControlStateNormal];
        self.tourPlanTime = dateTime;
        [self setEnterpriseListNet];
    }
}

- (void)afterBtnAction {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    if ([self.timeBtn.titleLabel.text isEqualToString:@"计划时间"]) {
        NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];//后一天
        NSString *dateTime=[dateFormat stringFromDate:nextDay];
        [self.timeBtn setTitle:dateTime forState:UIControlStateNormal];
        self.tourPlanTime = dateTime;
        [self setEnterpriseListNet];
    } else {
        NSString *dateString=[NSString stringWithFormat:@"%@", self.timeBtn.titleLabel.text];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        NSDate *date =[dateFormat dateFromString:dateString];
        NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
        NSString *dateTime=[dateFormat stringFromDate:nextDay];
        [self.timeBtn setTitle:dateTime forState:UIControlStateNormal];
        self.tourPlanTime = dateTime;
        [self setEnterpriseListNet];
    }
}

- (void)timeBtnAction {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        self.tourPlanTime = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [self.timeBtn setTitle:self.tourPlanTime forState:UIControlStateNormal];
        [self setEnterpriseListNet];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    datepicker.maxLimitDate = [NSDate date:@"200-01-01" WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"确认移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
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
                
            [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/update") parameters:@{@"entity":dic} view:self completion:^(id result) {
                    if ([result[@"isSuccess"] intValue] == 1) {
                        [self setEnterpriseListNet];
                        self.block(@"reload");
                    } else {
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
                    }
                    
                } failure:^(NSError *error) {
                    NSLog(@"%@", error);
                }];
            
        }]];
        [self presentViewController:alert animated:YES completion:^{ }];
    }];
    deleteAction.backgroundColor = RGBCOLOR(252, 39, 11);
    return @[deleteAction];
}
 
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (void)setEnterpriseListNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.tourPlanStatus forKey:@"tourPlanStatus"];
    if ([IsBlankString isBlankString:self.tourPlanTime] == NO) {
        [dic setObject:self.tourPlanTime forKey:@"tourPlanTime"];
    }
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/query") parameters:@{@"entity":dic} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.arrayListResult = [NSMutableArray array];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
