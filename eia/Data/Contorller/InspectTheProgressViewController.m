//
//  InspectTheProgressViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "InspectTheProgressViewController.h"

@interface InspectTheProgressViewController ()

@end

@implementation InspectTheProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"查询进度跟踪";
    self.view.backgroundColor = BackgroundBlack;
    
    self.reportEntityListF = [[NSMutableArray alloc] init];
    self.tableHeadListF = [[NSMutableArray alloc] init];
    self.reportEntityListS = [[NSMutableArray alloc] init];
    self.tableHeadListS = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth - 10, kDeviceHeight - StatusRect - NavRect)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    [self setLoad];
    [self setQueryByEtpNet];
    [self setQueryByTownparkNet];
}

- (void)setLoad {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
}

//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.tableHeadListF.count > 0) {
            return self.reportEntityListF.count + 1;
        } else {
            return self.reportEntityListF.count;
        }
    } else {
        if (self.tableHeadListS.count > 0) {
            return self.reportEntityListS.count + 1;
        } else {
            return self.reportEntityListS.count;
        }
    }
}

//  分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 110;
}

//  设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = BackgroundBlack;
    
    InspectTheProgressHeaderView *inspectTheProgressHeaderView = [[NSBundle mainBundle] loadNibNamed:@"InspectTheProgressHeaderView" owner:nil options:nil][0];
    inspectTheProgressHeaderView.frame = CGRectMake(0, 10, kDeviceWidth - 10, 100);
    [viewHeader addSubview:inspectTheProgressHeaderView];
    
    if (section == 0) {
        inspectTheProgressHeaderView.titleLabel.text = @"按环保管家统计";
        [inspectTheProgressHeaderView.starTimeBtn addTarget:self action:@selector(starTimeBtnF:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.createTimeStartF] == NO) {
            [inspectTheProgressHeaderView.starTimeBtn setTitle:self.createTimeStartF forState:UIControlStateNormal];
        }
        [inspectTheProgressHeaderView.endTimeBtn addTarget:self action:@selector(endTimeBtnF:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.createTimeEndF] == NO) {
            [inspectTheProgressHeaderView.endTimeBtn setTitle:self.createTimeEndF forState:UIControlStateNormal];
        }
    } else {
        inspectTheProgressHeaderView.titleLabel.text = @"按园区统计";
        [inspectTheProgressHeaderView.starTimeBtn addTarget:self action:@selector(starTimeBtnS:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.createTimeStartS] == NO) {
            [inspectTheProgressHeaderView.starTimeBtn setTitle:self.createTimeStartS forState:UIControlStateNormal];
        }
        [inspectTheProgressHeaderView.endTimeBtn addTarget:self action:@selector(endTimeBtnS:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.createTimeEndS] == NO) {
            [inspectTheProgressHeaderView.endTimeBtn setTitle:self.createTimeEndS forState:UIControlStateNormal];
        }
    }
    
    return viewHeader;
}

- (void)starTimeBtnF:(UIButton *)button {
    [self setChooseTimeButton:button index:@"starF"];
}

- (void)endTimeBtnF:(UIButton *)button {
    [self setChooseTimeButton:button index:@"endF"];
}

- (void)starTimeBtnS:(UIButton *)button {
    [self setChooseTimeButton:button index:@"starS"];
}

- (void)endTimeBtnS:(UIButton *)button {
    [self setChooseTimeButton:button index:@"endS"];
}

- (void)setChooseTimeButton:(UIButton *)button index:(NSString *)str {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
         [self setLoad];
        if ([str isEqualToString:@"starF"]) {
            self.createTimeStartF = date;
            [self setQueryByEtpNet];
        } else if ([str isEqualToString:@"endF"]) {
            self.createTimeEndF = date;
            [self setQueryByEtpNet];
        } else if ([str isEqualToString:@"starS"]) {
            self.createTimeStartS = date;
            [self setQueryByTownparkNet];
        } else if ([str isEqualToString:@"endS"]) {
            self.createTimeEndS = date;
            [self setQueryByTownparkNet];
        }
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

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
    sectionHeaderHeight = 45;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *str = @"DataType1TableViewCell";
         DataType1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
         if(!cell){
             cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType1TableViewCell" owner:self options:nil]objectAtIndex:0];
         }
        
        if (indexPath.row == 0) {
            cell.showName.textColor = TabbarBlack_S;
            cell.divideMete.textColor = TabbarBlack_S;
            cell.finishFollow.textColor = TabbarBlack_S;
            cell.notFollow.textColor = TabbarBlack_S;
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[0][@"label"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[1][@"label"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[2][@"label"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[3][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"showName"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"divideMete"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"finishFollow"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[0][@"notFollow"]];
            }
        } else {
            if (indexPath.row == 0) {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[0][@"label"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[1][@"label"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[2][@"label"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[3][@"label"]];
            } else {
                cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"showName"]];
                cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"etpMete"]];
                cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"finishFollow"]];
                cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[0][@"notFollow"]];
            }
        }
         
         //  取消cell选中效果
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    } else {
        static NSString *str = @"DataType2TableViewCell";
        DataType2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType2TableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        if (indexPath.section == 0) {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"showName"]];
            cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"divideMete"]];
            cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"finishFollow"]];
            cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"notFollow"]];
        } else {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"showName"]];
            cell.divideMete.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"etpMete"]];
            cell.finishFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"finishFollow"]];
            cell.notFollow.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"notFollow"]];
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


- (void)setQueryByEtpNet {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStartF] == NO) {
        [dic setObject:self.createTimeStartF  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEndF] == NO) {
        [dic setObject:self.createTimeEndF  forKey:@"createTimeEnd"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"followRate/queryByEtp") parameters:dic view:self completion:^(id result) {
        
         NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reportEntityListF = result[@"result"][@"reportEntityList"];
            self.tableHeadListF = result[@"result"][@"tableHeadList"];
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

- (void)setQueryByTownparkNet {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.createTimeStartS] == NO) {
        [dic setObject:self.createTimeStartS  forKey:@"createTimeStart"];
    }
    if ([IsBlankString isBlankString:self.createTimeEndS] == NO) {
        [dic setObject:self.createTimeEndS  forKey:@"createTimeEnd"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"followRate/queryByTownpark") parameters:dic view:self completion:^(id result) {
        
         NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            self.reportEntityListS = result[@"result"][@"reportEntityList"];
            self.tableHeadListS = result[@"result"][@"tableHeadList"];
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
