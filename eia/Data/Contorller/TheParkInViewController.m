//
//  TheParkInViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "TheParkInViewController.h"

@interface TheParkInViewController ()

@end

@implementation TheParkInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"园区入驻企业行业分类统计";
    self.view.backgroundColor = BackgroundBlack;
    
    self.arrayF = [[NSMutableArray alloc] init];
    self.arrayP = [[NSMutableArray alloc] init];
    
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
    
    [self setNetOne];
    [self setNetTownpark];
    
    [self setLoad];
    [self setQueryByFirstLevelNet];
    [self setQueryByTwoLevelNet];
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
    if (section == 0) {
        return 53;
    }
    return 110;
}

//  设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = BackgroundBlack;
    
    if (section == 0) {
        
        ParkInHeaderView *parkInHeaderView = [[NSBundle mainBundle] loadNibNamed:@"ParkInHeaderView" owner:nil options:nil][0];
        parkInHeaderView.frame = CGRectMake(0, 1, kDeviceWidth - 10, 51);
        [viewHeader addSubview:parkInHeaderView];
        
        [parkInHeaderView.chooseParkBtn addTarget:self action:@selector(chooseParkBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.parkNameF] == NO) {
            [parkInHeaderView.chooseParkBtn setTitle:self.parkNameF forState:UIControlStateNormal];
        }
        
    } else {
        
        InspectTheProgressHeaderView *inspectTheProgressHeaderView = [[NSBundle mainBundle] loadNibNamed:@"InspectTheProgressHeaderView" owner:nil options:nil][0];
        inspectTheProgressHeaderView.frame = CGRectMake(0, 9, kDeviceWidth - 10, 100);
        inspectTheProgressHeaderView.toLabel.hidden = YES;
        [viewHeader addSubview:inspectTheProgressHeaderView];
        
        inspectTheProgressHeaderView.titleLabel.text = @"分类数据";
        
        [inspectTheProgressHeaderView.starTimeBtn addTarget:self action:@selector(starTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.parkName] == NO) {
            [inspectTheProgressHeaderView.starTimeBtn setTitle:self.parkName forState:UIControlStateNormal];
        } else {
            [inspectTheProgressHeaderView.starTimeBtn setTitle:@"全部工业园区" forState:UIControlStateNormal];
        }
        [inspectTheProgressHeaderView.endTimeBtn addTarget:self action:@selector(endTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([IsBlankString isBlankString:self.industryName] == NO) {
            [inspectTheProgressHeaderView.endTimeBtn setTitle:self.industryName forState:UIControlStateNormal];
        } else {
            [inspectTheProgressHeaderView.endTimeBtn setTitle:@"全部行业分类" forState:UIControlStateNormal];
        }
    }
    
    return viewHeader;
}

- (void)chooseParkBtn:(UIButton *)button {
    if (self.arrayP.count > 0) {
        ChooseIndustryClassificationView *chooseVC = [[ChooseIndustryClassificationView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        chooseVC.view = self.view;
        [chooseVC setAllowChooseIndustryClassificationViewFrame:CGRectMake(10, NavRect + StatusRect + 10, kDeviceWidth - 20, kDeviceHeight - NavRect - StatusRect - 80) array:self.arrayP];
        [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
            [button setTitle:[NSString stringWithFormat:@"%@", dic[@"parkName"]] forState:UIControlStateNormal];
            self.parkIdF = [NSString stringWithFormat:@"%@", dic[@"id"]];
            self.parkNameF = [NSString stringWithFormat:@"%@", dic[@"parkName"]];
            [self setLoad];
            [self setQueryByFirstLevelNet];
        }];
        [self.view addSubview:chooseVC];
    }
}

- (void)starTimeBtn:(UIButton *)button {
    if (self.arrayP.count > 0) {
        ChooseIndustryClassificationView *chooseVC = [[ChooseIndustryClassificationView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        chooseVC.view = self.view;
        [chooseVC setAllowChooseIndustryClassificationViewFrame:CGRectMake(10, NavRect + StatusRect + 10, kDeviceWidth - 20, kDeviceHeight - NavRect - StatusRect - 80) array:self.arrayP];
        [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
            [button setTitle:[NSString stringWithFormat:@"%@", dic[@"parkName"]] forState:UIControlStateNormal];
            self.parkId = [NSString stringWithFormat:@"%@", dic[@"id"]];
             self.parkName = [NSString stringWithFormat:@"%@", dic[@"parkName"]];
            [self setLoad];
            [self setQueryByTwoLevelNet];
        }];
        [self.view addSubview:chooseVC];
    }
}

- (void)endTimeBtn:(UIButton *)button {
    if (self.arrayF.count > 0) {
        ChooseIndustryClassificationView *chooseVC = [[ChooseIndustryClassificationView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        chooseVC.view = self.view;
        [chooseVC setAllowChooseIndustryClassificationViewFrame:CGRectMake(10, NavRect + StatusRect + 10, kDeviceWidth - 20, kDeviceHeight - NavRect - StatusRect - 80) array:self.arrayF];
        [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
            [button setTitle:[NSString stringWithFormat:@"%@", dic[@"industryName"]] forState:UIControlStateNormal];
            self.industryId = [NSString stringWithFormat:@"%@", dic[@"id"]];
            self.industryName = [NSString stringWithFormat:@"%@", dic[@"industryName"]];
            [self setLoad];
            [self setQueryByTwoLevelNet];
        }];
        [self.view addSubview:chooseVC];
    }
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
  
    sectionHeaderHeight = 100;

    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *str = @"DataType5TableViewCell";
         DataType5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
         if(!cell){
             cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType5TableViewCell" owner:self options:nil]objectAtIndex:0];
         }
        
        if (indexPath.section == 0) {
            cell.showName.text = [NSString stringWithFormat:@"%@", self.tableHeadListF[0][@"label"]];
            cell.etpCount.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[1][@"label"]];
            cell.etpRate.text = [NSString stringWithFormat:@"%@",self.tableHeadListF[2][@"label"]];
        } else {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[0][@"label"]];
            cell.etpCount.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[1][@"label"]];
            cell.etpRate.text = [NSString stringWithFormat:@"%@",self.tableHeadListS[2][@"label"]];
        }
         
         //  取消cell选中效果
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    } else {
        static NSString *str = @"DataType6TableViewCell";
        DataType6TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DataType6TableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.number.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        
        if (indexPath.section == 0) {
            cell.showName.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"showName"]];
            cell.etpCount.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"etpCount"]];
            cell.etpRate.text = [NSString stringWithFormat:@"%@",self.reportEntityListF[indexPath.row -1][@"etpRate"]];
        } else {
            cell.showName.text = [NSString stringWithFormat:@"%@", self.reportEntityListS[indexPath.row -1][@"showName"]];
            cell.etpCount.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"etpCount"]];
            cell.etpRate.text = [NSString stringWithFormat:@"%@",self.reportEntityListS[indexPath.row -1][@"etpRate"]];
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

- (void)setNetOne {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"industryBasis/query") parameters:@{@"start":@"0", @"pageSize":@"1000", @"entity":@{@"kind":@"one"}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                self.arrayF = [NSMutableArray arrayWithArray:result[@"result"][@"data"]];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setNetTownpark {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"townpark/query") parameters:@{@"findRange":@"my", @"pageSize":@"10000", @"start":@"0", @"entity":@{}} view:self completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                self.arrayP = [NSMutableArray arrayWithArray:result[@"result"][@"data"]];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)setQueryByFirstLevelNet {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.parkIdF] == NO) {
        [dic setObject:self.parkIdF  forKey:@"parkId"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"industryRate/queryByFirstLevel") parameters:@{@"entity":dic} view:self completion:^(id result) {
        
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

- (void)setQueryByTwoLevelNet {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.parkId] == NO) {
        [dic setObject:self.parkId  forKey:@"parkId"];
    }
    if ([IsBlankString isBlankString:self.industryId] == NO) {
        [dic setObject:self.industryId  forKey:@"industryId"];
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"industryRate/queryByTwoLevel") parameters:@{@"entity":dic} view:self completion:^(id result) {
        
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
