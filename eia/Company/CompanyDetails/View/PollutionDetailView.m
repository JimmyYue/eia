//
//  PollutionDetailView.m
//  eia
//
//  Created by JimmyYue on 2020/6/18.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "PollutionDetailView.h"

@implementation PollutionDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setAllowPollutionDetailView:(NSDictionary *)dic {
    
    self.resultDic = [[NSDictionary alloc] init];
    self.resultDic = dic;
    
    self.sewageArray = [[NSMutableArray alloc] init];
    if ([[dic allKeys] containsObject:@"gasBasisList"]) {
        [self.sewageArray addObject:dic[@"gasBasisList"]];
    } else {
        [self.sewageArray addObject:@[]];
    }
    if ([[dic allKeys] containsObject:@"waterBasisList"]) {
        [self.sewageArray addObject:dic[@"waterBasisList"]];
    } else {
        [self.sewageArray addObject:@[]];
    }
    if ([[dic allKeys] containsObject:@"dangerBasisList"]) {
        [self.sewageArray addObject:dic[@"dangerBasisList"]];
    } else {
        [self.sewageArray addObject:@[]];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.indicatorStyle = UITableViewStyleGrouped;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];

    NSString *str = @"";
    if ([[dic allKeys] containsObject:@"voiceDepict"]) {
        str = dic[@"voiceDepict"];
    }
    NSDictionary *dicR = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(self.frame.size.width - 115, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicR context:nil];
    
    NSString *strS = @"";
    if ([[dic allKeys] containsObject:@"voiceEffect"]) {
        strS = dic[@"voiceEffect"];
    }
    CGRect rectS = [strS boundingRectWithSize:CGSizeMake(self.frame.size.width - 115, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicR context:nil];
    
    NSString *strT = @"";
    if ([[dic allKeys] containsObject:@"situationText"]) {
        strT = dic[@"situationText"];
    }
    CGRect rectT = [strT boundingRectWithSize:CGSizeMake(self.frame.size.width - 115, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicR context:nil];
    
    
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(5, self.tableView.frame.origin.y + self.tableView.frame.size.height + 1, self.frame.size.width - 10, 390 + rect.size.height + rectS.size.height + rectT.size.height)];
    self.tableFooterView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.tableFooterView;
    
    UILabel *noiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 35)];
    noiseLabel.text = @"噪声";
    noiseLabel.font = [UIFont systemFontOfSize:16];
    [self.tableFooterView addSubview:noiseLabel];
    
    UILabel *lineLabelF = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.frame.size.width, 1)];
    lineLabelF.backgroundColor = RGBCOLOR(249, 249, 249);
    [self.tableFooterView addSubview:lineLabelF];
    
    UILabel *titleFLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineLabelF.frame.origin.y + lineLabelF.frame.size.height + 10, 85, 35)];
    titleFLabel.text = @"噪声描述 ︲ ";
    titleFLabel.textColor = [UIColor lightGrayColor];
    titleFLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:titleFLabel];
    
    
    
    UILabel *noiseDescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, titleFLabel.frame.origin.y + 5, self.frame.size.width - 115, rect.size.height + 10)];
    noiseDescribeLabel.text = str;
    noiseDescribeLabel.numberOfLines = 0;
    noiseDescribeLabel.textColor = [UIColor lightGrayColor];
    noiseDescribeLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:noiseDescribeLabel];
    
    UILabel *lineLabelS = [[UILabel alloc] initWithFrame:CGRectMake(0, noiseDescribeLabel.frame.origin.y + noiseDescribeLabel.frame.size.height + 10, self.frame.size.width, 1)];
    lineLabelS.backgroundColor = RGBCOLOR(249, 249, 249);
    [self.tableFooterView addSubview:lineLabelS];
    
    UILabel *titleSLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineLabelS.frame.origin.y + lineLabelS.frame.size.height + 10, 85, 35)];
    titleSLabel.text = @"处理方式 ︲ ";
    titleSLabel.textColor = [UIColor lightGrayColor];
    titleSLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:titleSLabel];
    
    
    UILabel *processLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, titleSLabel.frame.origin.y + 5, self.frame.size.width - 115, rectS.size.height + 10)];
    processLabel.text = strS;
    processLabel.numberOfLines = 0;
    processLabel.textColor = [UIColor lightGrayColor];
    processLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:processLabel];
    
    UILabel *lineLabelT = [[UILabel alloc] initWithFrame:CGRectMake(0, processLabel.frame.origin.y + processLabel.frame.size.height + 10, self.frame.size.width, 10)];
    lineLabelT.backgroundColor = RGBCOLOR(249, 249, 249);
    [self.tableFooterView addSubview:lineLabelT];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineLabelT.frame.origin.y + lineLabelT.frame.size.height + 10, 100, 35)];
    userLabel.text = @"锅炉使用情况";
    userLabel.font = [UIFont systemFontOfSize:16];
    [self.tableFooterView addSubview:userLabel];
    
    UILabel *lineLabelFo = [[UILabel alloc] initWithFrame:CGRectMake(0, userLabel.frame.origin.y + userLabel.frame.size.height + 10, self.frame.size.width, 1)];
    lineLabelFo.backgroundColor = RGBCOLOR(249, 249, 249);
    [self.tableFooterView addSubview:lineLabelFo];
    
    UILabel *fuelTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineLabelFo.frame.origin.y + lineLabelFo.frame.size.height + 10, (self.frame.size.width - 30) / 2, 35)];
    fuelTypeLabel.text = @"燃料类型 ︲ ";
    if ([[dic allKeys] containsObject:@"fuelTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"fuelTypeName"]]] == NO) {
        fuelTypeLabel.text = [NSString stringWithFormat:@"燃料类型 ︲  %@", dic[@"fuelTypeName"]];
    }
    fuelTypeLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:fuelTypeLabel];
    
    UILabel *fuelUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(fuelTypeLabel.frame.origin.x + fuelTypeLabel.frame.size.width + 10, lineLabelFo.frame.origin.y + lineLabelFo.frame.size.height + 10, (self.frame.size.width - 30) / 2, 35)];
    fuelUserLabel.text = @"锅炉用途 ︲ ";
    if ([[dic allKeys] containsObject:@"boilerTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"boilerTypeName"]]] == NO) {
        fuelUserLabel.text = [NSString stringWithFormat:@"锅炉用途 ︲  %@", dic[@"boilerTypeName"]];
    }
    fuelUserLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:fuelUserLabel];
    
    UILabel *dosageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, fuelTypeLabel.frame.origin.y + fuelTypeLabel.frame.size.height, (self.frame.size.width - 30) / 2, 35)];
    dosageLabel.text = @"用        量 ︲ ";
    if ([[dic allKeys] containsObject:@"dosage"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"dosage"]]] == NO) {
        dosageLabel.text = [NSString stringWithFormat:@"用        量 ︲  %@ kw/a", dic[@"dosage"]];
    }
    dosageLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:dosageLabel];
    
    UILabel *powerLabel = [[UILabel alloc] initWithFrame:CGRectMake(fuelTypeLabel.frame.origin.x + fuelTypeLabel.frame.size.width + 10, fuelUserLabel.frame.origin.y + fuelUserLabel.frame.size.height, (self.frame.size.width - 30) / 2, 35)];
    powerLabel.text = @"锅炉功率 ︲ ";
    if ([[dic allKeys] containsObject:@"powerRate"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"powerRate"]]] == NO) {
        powerLabel.text = [NSString stringWithFormat:@"锅炉功率 ︲  %@ kw", dic[@"powerRate"]];
    }
    powerLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:powerLabel];
    
    UILabel *lineLabelFi = [[UILabel alloc] initWithFrame:CGRectMake(0, powerLabel.frame.origin.y + powerLabel.frame.size.height + 10, self.frame.size.width, 10)];
    lineLabelFi.backgroundColor = RGBCOLOR(249, 249, 249);
    [self.tableFooterView addSubview:lineLabelFi];
    
    UILabel *managementLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineLabelFi.frame.origin.y + lineLabelFi.frame.size.height + 10, 100, 35)];
    managementLabel.text = @"危废处理管理";
    managementLabel.font = [UIFont systemFontOfSize:16];
    [self.tableFooterView addSubview:managementLabel];
    
    UILabel *lineLabelSi = [[UILabel alloc] initWithFrame:CGRectMake(0, managementLabel.frame.origin.y + managementLabel.frame.size.height + 10, self.frame.size.width, 1)];
    lineLabelSi.backgroundColor = RGBCOLOR(249, 249, 249);
    [self.tableFooterView addSubview:lineLabelSi];
    
    UILabel *titleTLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineLabelSi.frame.origin.y + lineLabelSi.frame.size.height + 10, 85, 35)];
    titleTLabel.text = @"描述情况 ︲ ";
    titleTLabel.textColor = [UIColor lightGrayColor];
    titleTLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:titleTLabel];
    
    
    UILabel *caseDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, titleTLabel.frame.origin.y + 5, self.frame.size.width - 115, rectT.size.height + 10)];
    caseDescriptionLabel.text = strT;
    caseDescriptionLabel.numberOfLines = 0;
    caseDescriptionLabel.textColor = [UIColor lightGrayColor];
    caseDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [self.tableFooterView addSubview:caseDescriptionLabel];
}

//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sewageArray[section] count] + 3;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.sewageArray[indexPath.section] count] + 2) {
        
        static NSString *str = @"ContentTableViewCell";
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ContentTableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        NSString *content = @"";
        if (indexPath.section == 0) {
             if ([[self.resultDic allKeys] containsObject:@"gasEffect"]) {
                 content = [NSString stringWithFormat:@"%@", self.resultDic[@"gasEffect"]];
             }
        } else if (indexPath.section == 1) {
             if ([[self.resultDic allKeys] containsObject:@"waterEffect"]) {
                 content = [NSString stringWithFormat:@"%@", self.resultDic[@"waterEffect"]];
             }
        } else if (indexPath.section == 2) {
             if ([[self.resultDic allKeys] containsObject:@"dangerEffect"]) {
                 content = [NSString stringWithFormat:@"%@", self.resultDic[@"dangerEffect"]];
             }
         }
        
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.text = content;
        
        //  取消cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        static NSString *str = @"PollutionTableViewCell";
        PollutionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PollutionTableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.font = [UIFont systemFontOfSize:16];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.unitLabel.hidden = YES;
            if (indexPath.section == 0) {
                cell.titleLabel.text = @"废气";
            } else if (indexPath.section == 1) {
                cell.titleLabel.text = @"废水";
            } else if (indexPath.section == 2) {
                cell.titleLabel.text = @"固废 (危废)";
            }
        } else if (indexPath.row == 1) {
            if (indexPath.section == 0) {
                cell.titleLabel.text = @"废气成分";
                cell.unitLabel.text = @"排放量 (mg/m³)";
            } else if (indexPath.section == 1) {
                cell.titleLabel.text = @"污染物控制项目";
                cell.unitLabel.text = @"排放量 (mg/L)";
            } else if (indexPath.section == 2) {
                cell.titleLabel.text = @"污染物控制项目";
                cell.unitLabel.text = @"废物代码";
            }
        } else {
            cell.titleLabel.textColor = [UIColor blackColor];
            if (indexPath.section == 0) {
                cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"gasBelong"]];
                if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"gasAmount"]]] == NO) {
                    cell.unitLabel.text = [NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"gasAmount"]];
                }
            } else if (indexPath.section == 1) {
                cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"waterBelong"]];
                if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"waterAmount"]]] == NO) {
                    cell.unitLabel.text = [NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"waterAmount"]];
                }
            } else if (indexPath.section == 2) {
                cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"dangerBelong"]];
                if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"dangerCode"]]] == NO) {
                    cell.unitLabel.text = [NSString stringWithFormat:@"%@", self.sewageArray[indexPath.section][indexPath.row - 2][@"dangerCode"]];
                }
            }
        }
        
        //  取消cell选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.sewageArray[indexPath.section] count] + 2) {
        NSString *str;
        if (indexPath.section == 0) {
            if ([[self.resultDic allKeys] containsObject:@"gasEffect"]) {
                str = [NSString stringWithFormat:@"%@", self.resultDic[@"gasEffect"]];
            }
        } else if (indexPath.section == 1) {
            if ([[self.resultDic allKeys] containsObject:@"waterEffect"]) {
                str = [NSString stringWithFormat:@"%@", self.resultDic[@"waterEffect"]];
            }
        } else if (indexPath.section == 2) {
            if ([[self.resultDic allKeys] containsObject:@"dangerEffect"]) {
                str = [NSString stringWithFormat:@"%@", self.resultDic[@"dangerEffect"]];
            }
        }
        
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(self.frame.size.width - 115, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        if (rect.size.height > 0) {
            return rect.size.height + 25;
        } else {
            return 40;
        }
    } else {
        if (indexPath.row == 0) {
            return  50;
        } else {
            return 40;
        }
    }
    return 0;
}
@end
