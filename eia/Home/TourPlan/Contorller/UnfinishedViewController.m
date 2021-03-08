//
//  UnfinishedViewController.m
//  eia
//
//  Created by JimmyYue on 2020/9/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "UnfinishedViewController.h"

@interface UnfinishedViewController ()

@end

@implementation UnfinishedViewController

- (void)reloadList {  // 详情更新刷新列表
    [self setEnterpriseListNet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"ReloadList" object:nil];
    
    self.title = @"未完成";
    self.view.backgroundColor = BackgroundBlack;
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth - 10, kDeviceHeight - StatusRect - NavRect)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self setEnterpriseListNet];
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
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记为完成" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
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
                
            [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/update") parameters:@{@"entity":dic} view:self completion:^(id result) {
                    
                    if ([result[@"isSuccess"] intValue] == 1) {
                        [self setEnterpriseListNet];
                    } else {
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
                    }
                    
                } failure:^(NSError *error) {
                    NSLog(@"%@", error);
                }];
        }]];
        
        [self presentViewController:alert animated:YES completion:^{ }];
    }];
    deleteAction.backgroundColor = RGBCOLOR(26, 152, 7);
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
