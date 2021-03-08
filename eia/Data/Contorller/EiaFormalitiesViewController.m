//
//  EiaFormalitiesViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "EiaFormalitiesViewController.h"

@interface EiaFormalitiesViewController ()

@end

@implementation EiaFormalitiesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"环保手续办理情况统计";
    self.view.backgroundColor = BackgroundBlack;
    
    InspectTheProgressHeaderView *inspectTheProgressHeaderView = [[NSBundle mainBundle] loadNibNamed:@"InspectTheProgressHeaderView" owner:nil options:nil][0];
    inspectTheProgressHeaderView.frame = CGRectMake(0, 10, kDeviceWidth, 100);
    [self.view addSubview:inspectTheProgressHeaderView];
    inspectTheProgressHeaderView.titleLabel.text = @"按园区统计";
    [inspectTheProgressHeaderView.starTimeBtn addTarget:self action:@selector(starTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [inspectTheProgressHeaderView.endTimeBtn addTarget:self action:@selector(endTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 111, kDeviceWidth -10, kDeviceHeight - StatusRect - NavRect - 111)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self setQueryByHandyNet];
}

- (void)starTimeBtn:(UIButton *)button {
    [self setChooseTimeButton:button index:@"star"];
}

- (void)endTimeBtn:(UIButton *)button {
    [self setChooseTimeButton:button index:@"end"];
}

- (void)setChooseTimeButton:(UIButton *)button index:(NSString *)str {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        if ([str isEqualToString:@"star"]) {
            self.createTimeStart = date;
        } else if ([str isEqualToString:@"end"]) {
            self.createTimeEnd = date;
        }
        [self setQueryByHandyNet];
        [button setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.maxLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.tableHeadListF.count > 0) {
            return self.reportEntityListF.count + 1;
        } else {
            return self.reportEntityListF.count;
        }
    } else if (section == 1) {
        if (self.tableHeadListS.count > 0) {
            return self.reportEntityListS.count + 1;
        } else {
            return self.reportEntityListS.count;
        }
    } else {
        if (self.tableHeadListT.count > 0) {
            return self.reportEntityListT.count + 1;
        } else {
            return self.reportEntityListT.count;
        }
    }
}

//  分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 60;
}

//  设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = BackgroundBlack;
    
    float y = 10;
    if (section == 0) {
        y = 0;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kDeviceWidth - 10, 50)];
    if (section == 0) {
        label.text = @"   环评手续";
    } else if (section == 1) {
        label.text = @"   环保验收";
    } else if (section == 2) {
        label.text = @"   危废/固废处理";
    }
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor whiteColor];
    [viewHeader addSubview:label];
    
    return viewHeader;
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
  
    sectionHeaderHeight = 60;

    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *str = @"DataType3TableViewCell";
         DataType3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
         if(!cell){
             cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType3TableViewCell" owner:self options:nil]objectAtIndex:0];
         }
        
        if (indexPath.row == 0) {
            cell.showName.textColor = TabbarBlack_S;
            cell.over.textColor = TabbarBlack_S;
            cell.notYet.textColor = TabbarBlack_S;
            cell.process.textColor = TabbarBlack_S;
            cell.notNeed.textColor = TabbarBlack_S;
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[0][@"label"]];
                cell.over.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[1][@"label"]];
                cell.notYet.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[2][@"label"]];
                cell.process.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[3][@"label"]];
                cell.notNeed.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[4][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"showName"]];
                cell.over.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"over"]];
                cell.notYet.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"notYet"]];
                cell.process.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"process"]];
                cell.notNeed.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"notNeed"]];
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[0][@"label"]];
                cell.over.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[1][@"label"]];
                cell.notYet.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[2][@"label"]];
                cell.process.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[3][@"label"]];
                cell.notNeed.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[4][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"showName"]];
                cell.over.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"over"]];
                cell.notYet.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"notYet"]];
                cell.process.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"process"]];
                cell.notNeed.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"notNeed"]];
            }
        } else {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListT[0][@"label"]];
                cell.over.text = [NSString stringWithFormat:@"%@",self.tableHeadListT[1][@"label"]];
                cell.notYet.text = [NSString stringWithFormat:@"%@",self.tableHeadListT[2][@"label"]];
                cell.process.text = [NSString stringWithFormat:@"%@",self.tableHeadListT[3][@"label"]];
                cell.notNeed.text = [NSString stringWithFormat:@"%@",self.tableHeadListT[4][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[0][@"showName"]];
                cell.over.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[0][@"over"]];
                cell.notYet.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[0][@"notYet"]];
                cell.process.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[0][@"process"]];
                cell.notNeed.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[0][@"notNeed"]];
            }
        }
         
         //  取消cell选中效果
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
        
    } else {
        static NSString *str = @"DataType4TableViewCell";
        DataType4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType4TableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        if (indexPath.section == 0) {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row - 1][@"showName"]];
            cell.over.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row - 1][@"over"]];
            cell.notYet.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row - 1][@"notYet"]];
            cell.process.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row - 1][@"process"]];
            cell.notNeed.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row - 1][@"notNeed"]];
        } else if (indexPath.section == 1) {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row - 1][@"showName"]];
            cell.over.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row - 1][@"over"]];
            cell.notYet.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row - 1][@"notYet"]];
            cell.process.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row - 1][@"process"]];
            cell.notNeed.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row - 1][@"notNeed"]];
        } else {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[indexPath.row - 1][@"showName"]];
            cell.over.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[indexPath.row - 1][@"over"]];
            cell.notYet.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[indexPath.row - 1][@"notYet"]];
            cell.process.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[indexPath.row - 1][@"process"]];
            cell.notNeed.text = [NSString stringWithFormat:@"%@",self.reportEntityListT[indexPath.row - 1][@"notNeed"]];
        }
        
        //  取消cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)setQueryByHandyNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStart] == NO) {
        [dic setObject:self.createTimeStart  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEnd] == NO) {
        [dic setObject:self.createTimeEnd  forKey:@"createTimeEnd"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"eiaDealRate/queryByHandy") parameters:dic view:self completion:^(id result) {
        
         NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reportEntityListF = result[@"result"][@"reportEntityList"];
            self.tableHeadListF = result[@"result"][@"tableHeadList"];
            
            [self setQueryByLookAtNet];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setQueryByLookAtNet {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStart] == NO) {
        [dic setObject:self.createTimeStart  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEnd] == NO) {
        [dic setObject:self.createTimeEnd  forKey:@"createTimeEnd"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"eiaDealRate/queryByLookAt") parameters:dic view:self completion:^(id result) {
        
         NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reportEntityListS = result[@"result"][@"reportEntityList"];
            self.tableHeadListS = result[@"result"][@"tableHeadList"];
            
            [self setQueryByDealNet];
            
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setQueryByDealNet {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStart] == NO) {
        [dic setObject:self.createTimeStart  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEnd] == NO) {
        [dic setObject:self.createTimeEnd  forKey:@"createTimeEnd"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"eiaDealRate/queryByDeal") parameters:dic view:self completion:^(id result) {
        
         NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reportEntityListT = result[@"result"][@"reportEntityList"];
            self.tableHeadListT = result[@"result"][@"tableHeadList"];
            [self.tableView reloadData];
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
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
