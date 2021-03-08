//
//  ChooseSolidWasteViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/1.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ChooseSolidWasteViewController.h"

@interface ChooseSolidWasteViewController ()

@end

@implementation ChooseSolidWasteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"国家危废废物名录";
    self.view.backgroundColor = BackgroundBlack;
    
    UIView *chooseText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.chooseText.leftView = chooseText;
    self.chooseText.leftViewMode = UITextFieldViewModeAlways;
    
    self.array = [[NSMutableArray alloc] init];
    self.arrayResult = [[NSMutableArray alloc] init];
    self.arrayChoose = [[NSMutableArray alloc] init];
    if (self.arraySelected.count > 0) {
        self.arrayChoose = [NSMutableArray arrayWithArray:self.arraySelected];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, kDeviceHeight - StatusRect - NavRect - 180)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackgroundBlack;
    [self.view addSubview:self.tableView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(30, self.tableView.frame.origin.y + self.tableView.frame.size.height + 20, kDeviceWidth - 60, 50);
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn.layer setCornerRadius:8.0];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = TabbarBlack_S;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sureBtn];
    
    [self setNetListOne];
    
}

- (IBAction)chooseAction:(id)sender {
    ChooseIndustryClassificationView *chooseVC = [[ChooseIndustryClassificationView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    chooseVC.view = self.view;
    [chooseVC setAllowChooseIndustryClassificationViewFrame:CGRectMake(95, NavRect + StatusRect + 50, kDeviceWidth - 105, kDeviceHeight - NavRect - StatusRect - 130) array:self.array];
    [chooseVC setBlock:^(NSDictionary * _Nonnull dic) {
        self.chooseText.text = [NSString stringWithFormat:@"%@", dic[@"rubbishMenu"]];
        self.arrayResult = [NSMutableArray array];
        [self setNetListTwo:[NSString stringWithFormat:@"%@", dic[@"id"]]];
    }];
    [self.view addSubview:chooseVC];
}

- (void)sureBtnAction {
    if (self.arrayChoose.count > 0) {
        self.block(self.arrayChoose);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择污染物 !"];
    }
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayResult.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"ChooseSolidWasteTableViewCell";
    ChooseSolidWasteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChooseSolidWasteTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    cell.classLabel.text = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"industrySource"]];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"dangerCode"]];
    
    cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"dangerText"]];
    
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"dangerDot"]];
    
    for (SolidWaste *solidWaste in self.arrayChoose) {
        if ([[NSString stringWithFormat:@"%@", solidWaste.dangerCode] isEqualToString:cell.numberLabel.text]) {
            cell.chooseImageBtn.selected = YES;
        }
    }
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    ChooseSolidWasteTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.chooseImageBtn.selected == NO) {
        cell.chooseImageBtn.selected = YES;
        
        BOOL isbool = NO;
       for (SolidWaste *solidWaste in self.arrayChoose) {
           if ([[NSString stringWithFormat:@"%@", solidWaste.dangerCode] isEqualToString:self.arrayResult[indexPath.row][@"dangerCode"]]) {
               isbool = YES;
               break;
           }
       }
        
        if (isbool == NO) {
            SolidWaste *solidWaste = [[SolidWaste alloc] init];
            solidWaste.dangerBelong = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"rubbishMenu"]];
            solidWaste.dangerCode = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"dangerCode"]];
            [self.arrayChoose addObject:solidWaste];
        }
        
    } else {
        cell.chooseImageBtn.selected = NO;
        
        for (SolidWaste *solidWaste in self.arrayChoose) {
            if ([[NSString stringWithFormat:@"%@", solidWaste.dangerCode] isEqualToString:self.arrayResult[indexPath.row][@"dangerCode"]]) {
                [self.arrayChoose removeObject:solidWaste];
                break;
            }
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = [NSString stringWithFormat:@"%@", self.arrayResult[indexPath.row][@"dangerText"]];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kDeviceWidth - 245, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height + 45;
}

- (void)setNetListOne {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"dangerBasis/query") parameters:@{@"start":@"0", @"pageSize":@"1000", @"entity":@{@"kind":@"one"}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                self.array = result[@"result"][@"data"];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setNetListTwo:(NSString *)parentId {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"dangerBasis/querySubset") parameters:@{@"entity":@{@"parentId":parentId}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            if ([result[@"result"] count] > 0) {
                self.arrayResult = result[@"result"];
            }
            [self.tableView reloadData];
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
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
