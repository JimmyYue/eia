//
//  AddPlanViewController.m
//  eia
//
//  Created by JimmyYue on 2020/9/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "AddPlanViewController.h"

@interface AddPlanViewController ()

@end

@implementation AddPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"巡查计划";
    self.view.backgroundColor = BackgroundBlack;
    
    self.parkInHeaderView = [[NSBundle mainBundle] loadNibNamed:@"ParkInHeaderView" owner:nil options:nil][0];
    self.parkInHeaderView.frame = CGRectMake(5, 5, kDeviceWidth - 10, 51);
    [self.view addSubview:self.parkInHeaderView];
    
    self.parkInHeaderView.nameLabel.text = @"计划时间";
    [self.parkInHeaderView.chooseParkBtn addTarget:self action:@selector(chooseParkBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.parkInHeaderView.chooseParkBtn setTitle:@"选择计划审查的时间" forState:UIControlStateNormal];
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, self.parkInHeaderView.frame.origin.y + self.parkInHeaderView.frame.size.height + 5, kDeviceWidth - 10, kDeviceHeight - (self.parkInHeaderView.frame.origin.y + self.parkInHeaderView.frame.size.height + 55) - StatusRect - NavRect)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加计划巡查的企业名单" forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, kDeviceWidth * 2 / 3 - 1, 50);
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.backgroundColor = TabbarBlack_S;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认新增" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(addBtn.frame.origin.x + addBtn.frame.size.width + 1, self.tableView.frame.origin.y + self.tableView.frame.size.height, kDeviceWidth / 3, 50);
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor = TabbarBlack_S;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
}

- (void)chooseParkBtn {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [self.parkInHeaderView.chooseParkBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.minLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    datepicker.maxLimitDate = [NSDate date:@"2050-01-01" WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

- (void)addBtnAction {
    AddEnterprisePlanViewController *addVC = [[AddEnterprisePlanViewController alloc] init];
    addVC.chooseArray = self.arrayListResult;
    [addVC setBlock:^(NSMutableArray * _Nonnull array) {
        self.arrayListResult = array;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)sureBtnAction {  // 确认新增
    
    NSMutableDictionary *dicP = [[NSMutableDictionary alloc] init];
    
    if (![self.parkInHeaderView.chooseParkBtn.titleLabel.text isEqualToString:@"选择计划审查的时间"]) {
        [dicP setObject:self.parkInHeaderView.chooseParkBtn.titleLabel.text forKey:@"tourPlanTime"];
        
        if (self.arrayListResult.count > 0) {
            WorkModel *workModel = [[WorkModel alloc] init];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.arrayListResult.count; i++) {
                workModel = self.arrayListResult[i];
                [array addObject:@{@"enterpriseId":[NSString stringWithFormat:@"%@", workModel.Id]}];
            }
            [dicP setObject:array forKey:@"etpRelationTourPlanList"];
            
            [self setNetAdd:dicP];
        } else {
            [SVProgressHUD showInfoWithStatus:@"请选择计划巡查的企业!"];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择计划巡查的时间!"];
    }
}

- (void)setNetAdd:(NSMutableDictionary *)dic {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud.label.text = @"提交中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpTourPlan/create") parameters:@{@"entity":dic} view:self completion:^(id result) {
         
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
         if ([result[@"isSuccess"] intValue] == 1) {
             self.block(@"reload");
             [self.navigationController popViewControllerAnimated:YES];
         }
        
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
         
     } failure:^(NSError *error) {
         NSLog(@"%@", error);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
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
    
    cell.updateBtn.hidden = YES;
    [cell.addBtn setTitle:@"取消加入" forState:UIControlStateNormal];
    [cell.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag = 320 + indexPath.section;
   
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)addBtnAction:(UIButton *)button {
    [self.arrayListResult removeObjectAtIndex:button.tag - 320];
    [self.tableView reloadData];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
