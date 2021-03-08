//
//  UpdateSewageViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "UpdateSewageViewController.h"

@interface UpdateSewageViewController ()

@end

@implementation UpdateSewageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"排污情况";
    self.view.backgroundColor = BackgroundBlack;
    
    self.arrayWasteGas = [[NSMutableArray alloc] init];
    self.arrayWasteWater = [[NSMutableArray alloc] init];
    self.arraySolidWaste = [[NSMutableArray alloc] init];
    
    self.arrayWasteGasResult = [[NSMutableArray alloc] init];
    self.arrayWasteWaterResult = [[NSMutableArray alloc] init];
    self.arraySolidWasteResult = [[NSMutableArray alloc] init];
    
    if ([[self.dicDetail allKeys] containsObject:@"gasBasisList"]) {
        for (NSDictionary *dic in self.dicDetail[@"gasBasisList"]) {
            // 新
            WasteGas*wasteGas = [[WasteGas alloc] init];
            [wasteGas setValuesForKeysWithDictionary:dic];
            [self.arrayWasteGas addObject:wasteGas];
        }
    }
   
    if ([[self.dicDetail allKeys] containsObject:@"waterBasisList"]) {
        for (NSDictionary *dic in self.dicDetail[@"waterBasisList"]) {
            // 新
            WasteWater*wasteWater = [[WasteWater alloc] init];
            [wasteWater setValuesForKeysWithDictionary:dic];
            [self.arrayWasteWater addObject:wasteWater];
        }
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"dangerBasisList"]) {
        for (NSDictionary *dic in self.dicDetail[@"dangerBasisList"]) {
            // 新
            SolidWaste*solidWaste = [[SolidWaste alloc] init];
            [solidWaste setValuesForKeysWithDictionary:dic];
            [self.arraySolidWaste addObject:solidWaste];
        }
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"waterEffect"]) {
        self.waterEffect = [NSString stringWithFormat:@"%@", self.dicDetail[@"waterEffect"]];
    }
    if ([[self.dicDetail allKeys] containsObject:@"gasEffect"]) {
           self.gasEffect = [NSString stringWithFormat:@"%@", self.dicDetail[@"gasEffect"]];
    }
    if ([[self.dicDetail allKeys] containsObject:@"dangerEffect"]) {
        self.dangerEffect = [NSString stringWithFormat:@"%@", self.dicDetail[@"dangerEffect"]];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, kDeviceHeight - StatusRect - NavRect - 81)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth - 10, 820)];
    self.tableFooterView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.tableFooterView;
    
    self.blowdownCircumstanceView = [[NSBundle mainBundle] loadNibNamed:@"BlowdownCircumstanceView" owner:nil options:nil][0];
    self.blowdownCircumstanceView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 820);
    self.blowdownCircumstanceView.backgroundColor = [UIColor whiteColor];
    [self.tableFooterView addSubview:self.blowdownCircumstanceView];
    [self.blowdownCircumstanceView setAllowBlowdownCircumstanceView:self.dicDetail];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame = CGRectMake(30, self.tableView.frame.origin.y + self.tableView.frame.size.height + 20, kDeviceWidth - 60, 50);
    [updateBtn addTarget:self action:@selector(updateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [updateBtn.layer setCornerRadius:8.0];
    [updateBtn setTitle:@"提交并更新企业档案" forState:UIControlStateNormal];
    updateBtn.backgroundColor = TabbarBlack_S;
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:updateBtn];
    
}

//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.arrayWasteGas.count == 0) {
            return 1;
        }
        return self.arrayWasteGas.count;
    } else if (section == 1) {
        if (self.arrayWasteWater.count == 0) {
            return 1;
        }
        return self.arrayWasteWater.count;
    } else {
        if (self.arraySolidWaste.count == 0) {
            return 1;
        }
        return self.arraySolidWaste.count;
    }
}

//  分区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 87;
}

//  设置view，将替代titleForFooterInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    if (section == 0) {
        titleLabel.text = @"废气";
    } else if (section == 1) {
        titleLabel.text = @"废水";
    } else if (section == 2) {
        titleLabel.text = @"固废 (危废)";
    }
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [viewHeader addSubview:titleLabel];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kDeviceWidth - 140, 11, 130, 28);
    [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn.layer setCornerRadius:14.0];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = TabbarBlack_S.CGColor;
    if (section == 0) {
        [addBtn setTitle:@"请先选择废气成分" forState:UIControlStateNormal];
    } else if (section == 1) {
        [addBtn setTitle:@"请先选择污染物" forState:UIControlStateNormal];
    } else if (section == 2) {
        [addBtn setTitle:@"请先选择污染物" forState:UIControlStateNormal];
    }
    addBtn.backgroundColor = TabbarBlack_S;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    addBtn.tag = section + 300;
    [viewHeader addSubview:addBtn];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kDeviceWidth, 1)];
    line.backgroundColor = BackgroundBlack;
    [viewHeader addSubview:line];
    
    UILabel *typeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, line.frame.origin.y + line.frame.size.height, (kDeviceWidth - 40) * 3 / 5, 35)];
    typeNameLabel.font = [UIFont systemFontOfSize:14];
    typeNameLabel.textColor = ZitiColor;
    if (section == 0) {
        typeNameLabel.text = @"废气成分";
    } else if (section == 1) {
        typeNameLabel.text = @"污染物控制项目";
    } else if (section == 2) {
        typeNameLabel.text = @"废物类别";
    }
    [viewHeader addSubview:typeNameLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(typeNameLabel.frame.origin.x + typeNameLabel.frame.size.width + 15, line.frame.origin.y + line.frame.size.height, (kDeviceWidth - 40) * 2 / 5, 35)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = ZitiColor;
    if (section == 0) {
        contentLabel.text = @"排放量 (mg/m³)";
    } else if (section == 1) {
        contentLabel.text = @"排放量 (mg/L)";
    } else if (section == 2) {
        contentLabel.text = @"废物代码";
    }
    [viewHeader addSubview:contentLabel];
    
    UILabel *lineS = [[UILabel alloc] initWithFrame:CGRectMake(0, contentLabel.frame.origin.y + contentLabel.frame.size.height, kDeviceWidth, 1)];
    lineS.backgroundColor = BackgroundBlack;
    [viewHeader addSubview:lineS];
    
    return viewHeader;
}

- (void)addBtnAction:(UIButton *)button {
    
    if (button.tag == 300) {
        ChooseSewageViewController *chooseVC = [[ChooseSewageViewController alloc] init];
        chooseVC.titleStr = @"大气污染物名录";
        chooseVC.arraySelected = self.arrayWasteGas;
        [chooseVC setBlock:^(NSMutableArray * _Nonnull array) {
            //  新
            self.arrayWasteGasResult = self.arrayWasteGas;
            
            self.arrayWasteGas = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:chooseVC animated:YES];
    } else if (button.tag == 301) {
        ChooseSewageViewController *chooseVC = [[ChooseSewageViewController alloc] init];
        chooseVC.titleStr = @"污水污染物";
        chooseVC.arraySelected = self.arrayWasteWater;
        [chooseVC setBlock:^(NSMutableArray * _Nonnull array) {
            //  新
            self.arrayWasteWaterResult = self.arrayWasteWater;
            
            self.arrayWasteWater = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:chooseVC animated:YES];
    } else if (button.tag == 302) {
        ChooseSolidWasteViewController *chooseVC = [[ChooseSolidWasteViewController alloc] init];
        chooseVC.arraySelected = self.arraySolidWaste;
        [chooseVC setBlock:^(NSMutableArray * _Nonnull array) {
            //  新
            self.arraySolidWasteResult = self.arraySolidWaste;
            
            self.arraySolidWaste = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
            
        }];
        [self.navigationController pushViewController:chooseVC animated:YES];
    }
}

//  分区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 140;
}

//  设置view，将替代titleForFooterInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *viewFooter = [[UIView alloc] init];
    viewFooter.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 35)];
    if (section == 0) {
        titleLabel.text = @"废气处理方式";
    } else if (section == 1) {
        titleLabel.text = @"废水处理方式";
    } else if (section == 2) {
        titleLabel.text = @"废物处理方式";
    }
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [viewFooter addSubview:titleLabel];
    
    if (section == 0) {
        _wasteGasText = [XBTextView textViewWithPlaceHolder:@""];
        _wasteGasText.frame = CGRectMake(10, 35, kDeviceWidth - 20, 80);
        _wasteGasText.maxTextCount = 2000;
        _wasteGasText.textView.backgroundColor = BackgroundBlack;
        _wasteGasText.layer.cornerRadius = 8.0f;
        _wasteGasText.textView.font = [UIFont systemFontOfSize:15];
        _wasteGasText.textCountLabel.hidden = YES;
        _wasteGasText.backgroundColor = BackgroundBlack;
        if ([IsBlankString isBlankString:self.gasEffect] == NO) {
            _wasteGasText.text = self.gasEffect;
        }
        _wasteGasText.delegate = self;
        [viewFooter addSubview:_wasteGasText];
    } else if (section == 1) {
        _wasteWaterText = [XBTextView textViewWithPlaceHolder:@""];
        _wasteWaterText.frame = CGRectMake(10, 35, kDeviceWidth - 20, 80);
        _wasteWaterText.maxTextCount = 2000;
        _wasteWaterText.textView.backgroundColor = BackgroundBlack;
        _wasteWaterText.layer.cornerRadius = 8.0f;
        _wasteWaterText.textView.font = [UIFont systemFontOfSize:15];
        _wasteWaterText.textCountLabel.hidden = YES;
        _wasteWaterText.backgroundColor = BackgroundBlack;
        if ([IsBlankString isBlankString:self.waterEffect] == NO) {
            _wasteWaterText.text = self.waterEffect;
        }
        _wasteWaterText.delegate = self;
        [viewFooter addSubview:_wasteWaterText];
    } else if (section == 2) {
        _wasteText = [XBTextView textViewWithPlaceHolder:@""];
        _wasteText.frame = CGRectMake(10, 35, kDeviceWidth - 20, 80);
        _wasteText.maxTextCount = 2000;
        _wasteText.textView.backgroundColor = BackgroundBlack;
        _wasteText.layer.cornerRadius = 8.0f;
        _wasteText.textView.font = [UIFont systemFontOfSize:15];
        _wasteText.textCountLabel.hidden = YES;
        _wasteText.backgroundColor = BackgroundBlack;
        if ([IsBlankString isBlankString:self.dangerEffect] == NO) {
            _wasteText.text = self.dangerEffect;
        }
        _wasteText.delegate = self;
        [viewFooter addSubview:_wasteText];
    }
    
    UILabel *lineS = [[UILabel alloc] initWithFrame:CGRectMake(0,125, kDeviceWidth, 15)];
    lineS.backgroundColor = BackgroundBlack;
    [viewFooter addSubview:lineS];
    
    return viewFooter;
}

-(void)xbTextViewShouldEndEditing:(XBTextView *)xbTextView {
    //  新
    self.gasEffect = self.wasteGasText.text;
    self.waterEffect = self.wasteWaterText.text;
    self.dangerEffect = self.wasteText.text;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 80;//头
    CGFloat sectionFooterHeight = 135;//脚
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height){
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"SewageTableViewCell";
    SewageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SewageTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    if (indexPath.section == 0) {
        
        if (self.arrayWasteGas.count > 0) {
            
            cell.contentText.tag = 200 + indexPath.row;
            cell.contentText.delegate  = self;
            
            //  新
            WasteGas *wasteGas = [[WasteGas alloc] init];
            wasteGas = self.arrayWasteGas[indexPath.row];
            [cell.typeChooseBtn setTitle:[NSString stringWithFormat:@"%@", wasteGas.gasBelong] forState:UIControlStateNormal];
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", wasteGas.gasAmount]] == NO) {
                cell.contentText.text = [NSString stringWithFormat:@"%@", wasteGas.gasAmount];
            }
            for (WasteGas *wasteGasS in self.arrayWasteGasResult) {
                if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", wasteGasS.gasBelong]] == NO) {
                     if ([[NSString stringWithFormat:@"%@", wasteGasS.gasBelong] isEqualToString:[NSString stringWithFormat:@"%@", wasteGas.gasBelong]]) {
                         if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", wasteGasS.gasAmount]] == NO) {
                             cell.contentText.text = [NSString stringWithFormat:@"%@", wasteGasS.gasAmount];
                             wasteGas.gasAmount = wasteGasS.gasAmount;
                         } else {
                             cell.contentText.text = @"";
                         }
                     }
                }
            }
            
        }
    } else if (indexPath.section == 1) {
        
        if (self.arrayWasteWater.count > 0) {
            
            cell.contentText.tag = 300 + indexPath.row;
            cell.contentText.delegate  = self;
            
            //  新
            WasteWater *wasteWater = [[WasteWater alloc] init];
            wasteWater = self.arrayWasteWater[indexPath.row];
            [cell.typeChooseBtn setTitle:[NSString stringWithFormat:@"%@", wasteWater.waterBelong] forState:UIControlStateNormal];
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", wasteWater.waterAmount]] == NO) {
                cell.contentText.text = [NSString stringWithFormat:@"%@", wasteWater.waterAmount];
            }
            for (WasteWater *wasteWaterS in self.arrayWasteWaterResult) {
                if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", wasteWaterS.waterBelong]] == NO) {
                     if ([[NSString stringWithFormat:@"%@", wasteWaterS.waterBelong] isEqualToString:[NSString stringWithFormat:@"%@", wasteWater.waterBelong]]) {
                         if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", wasteWaterS.waterAmount]] == NO) {
                             cell.contentText.text = [NSString stringWithFormat:@"%@", wasteWaterS.waterAmount];
                             wasteWater.waterAmount = wasteWaterS.waterAmount;
                         } else {
                             cell.contentText.text = @"";
                         }
                     }
                }
            }
            
        }
    } else if (indexPath.section == 2) {
        cell.contentText.enabled = NO;
        if (self.arraySolidWaste.count > 0) {
            
            SolidWaste *solidWaste = [[SolidWaste alloc] init];
            solidWaste = self.arraySolidWaste[indexPath.row];
            
            [cell.typeChooseBtn setTitle:[NSString stringWithFormat:@"%@", solidWaste.dangerBelong] forState:UIControlStateNormal];
            cell.contentText.text = [NSString stringWithFormat:@"%@", solidWaste.dangerCode];
            
        }
    }
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag > 299) {
        WasteWater *wasteWater = [[WasteWater alloc] init];
        wasteWater = self.arrayWasteWater[textField.tag - 300];
        wasteWater.waterAmount = textField.text;
    } else {
        WasteGas *wasteGas = [[WasteGas alloc] init];
        wasteGas = self.arrayWasteGas[textField.tag - 200];
        wasteGas.gasAmount = textField.text;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 60;
}

- (void)updateBtnAction {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%@", self.dicDetail[@"id"]]  forKey:@"id"];
    
    if (self.arrayWasteGas.count > 0) {
        NSMutableArray *arrayG = [[NSMutableArray alloc] init];
        for (WasteGas *wasteGas in self.arrayWasteGas) {
            NSMutableDictionary *dicG = [[NSMutableDictionary alloc] init];
            [dicG setObject:[NSString stringWithFormat:@"%@", wasteGas.gasBelong] forKey:@"gasBelong"];
            [dicG setObject:[NSString stringWithFormat:@"%@", wasteGas.gasAmount] forKey:@"gasAmount"];
            [arrayG addObject:dicG];
        }
        [dic setObject:arrayG forKey:@"gasBasisList"];
    }
    
    if (self.arrayWasteWater.count > 0) {
        NSMutableArray *arrayW = [[NSMutableArray alloc] init];
        for (WasteWater *wasteWater in self.arrayWasteWater) {
            NSMutableDictionary *dicW = [[NSMutableDictionary alloc] init];
            [dicW setObject:[NSString stringWithFormat:@"%@", wasteWater.waterBelong] forKey:@"waterBelong"];
            [dicW setObject:[NSString stringWithFormat:@"%@", wasteWater.waterAmount] forKey:@"waterAmount"];
            [arrayW addObject:dicW];
        }
        [dic setObject:arrayW forKey:@"waterBasisList"];
    }
    
    if (self.arraySolidWaste.count > 0) {
        NSMutableArray *arrayS = [[NSMutableArray alloc] init];
        for (SolidWaste *solidWaste in self.arraySolidWaste) {
            NSMutableDictionary *dicS = [[NSMutableDictionary alloc] init];
            [dicS setObject:[NSString stringWithFormat:@"%@", solidWaste.dangerBelong] forKey:@"dangerBelong"];
            [dicS setObject:[NSString stringWithFormat:@"%@", solidWaste.dangerCode] forKey:@"dangerCode"];
            [arrayS addObject:dicS];
        }
        [dic setObject:arrayS forKey:@"dangerBasisList"];
    }
    
    if ([IsBlankString isBlankString:self.wasteWaterText.text] == NO) {
           [dic setObject:self.wasteWaterText.text forKey:@"waterEffect"];
    }
    if ([IsBlankString isBlankString:self.wasteGasText.text] == NO) {
        [dic setObject:self.wasteGasText.text forKey:@"gasEffect"];
    }
    if ([IsBlankString isBlankString:self.wasteText.text] == NO) {
        [dic setObject:self.wasteText.text forKey:@"dangerEffect"];
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.noiseText.text] == NO) {
        [dic setObject:self.blowdownCircumstanceView.noiseText.text forKey:@"voiceDepict"];
    }
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.noiseHandlingText.text] == NO) {
        [dic setObject:self.blowdownCircumstanceView.noiseHandlingText.text forKey:@"voiceEffect"];
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.fuelType] == NO) {
        [dic setObject:self.blowdownCircumstanceView.fuelType forKey:@"fuelType"];
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.boilerType] == NO) {
        [dic setObject:self.blowdownCircumstanceView.boilerType forKey:@"boilerType"];
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.dosageText.text] == NO) {
        [dic setObject:self.blowdownCircumstanceView.dosageText.text forKey:@"dosage"];
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.powerText.text] == NO) {
        [dic setObject:self.blowdownCircumstanceView.powerText.text forKey:@"powerRate"];
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.hasDangerAllow] == NO) {
        if ([self.blowdownCircumstanceView.hasDangerAllow isEqualToString:@"true"]) {
            [dic setObject:@(true) forKey:@"hasDangerAllow"];
        } else {
            [dic setObject:@(false) forKey:@"hasDangerAllow"];
        }
    }
    
    if ([IsBlankString isBlankString:self.blowdownCircumstanceView.describeText.text] == NO) {
        [dic setObject:self.blowdownCircumstanceView.describeText.text forKey:@"situationText"];
    }
    
//    NSLog(@"dic---------------%@", dic);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"提交中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/update") parameters:@{@"entity":dic} view:nil completion:^(id result) {
        
//        NSLog(@"%@", result);
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reloadBlock(@"success");
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"message"]];
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
