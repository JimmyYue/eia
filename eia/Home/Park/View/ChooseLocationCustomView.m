//
//  ChooseLocationCustomView.m
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ChooseLocationCustomView.h"

@implementation ChooseLocationCustomView

- (void)setAllowChooseLocationCustomView {
    
    self.chooseType = @"region";
    self.chooseCodeDic = [[NSMutableDictionary alloc] init];
    
    self.arrayRegion = [[NSMutableArray alloc] init];
    self.arrayStreet = [[NSMutableArray alloc] init];
    self.arrayCommunity = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackgroundBlack;
    
    [self.regionBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    self.streetBtn.hidden = YES;
    self.communityBtn.hidden = YES;
    
    _line = [[UILabel alloc] initWithFrame:CGRectMake((self.regionBtn.frame.size.width - 50) / 2, 29, 50, 1)];
    _line.backgroundColor = TabbarBlack_S;
    [_regionBtn addSubview:_line];
}

- (void)setChooseCityName:(NSString *)name cityCode:(NSString *)code {
    [self.cityBtn setTitle:name forState:UIControlStateNormal];
    [self.chooseCodeDic setObject:code forKey:@"city"];
    [self.chooseCodeDic setObject:name forKey:@"cityName"];
    [self setNetAreacode:code level:@"3"];
}

- (void)setNetAreacode:(NSString *)code level:(NSString *)level {
    
    NSDictionary *dic = @{@"entity":@{@"parentCode":code, @"level":level}};
    NSString *https = API_BASE_URL(@"cpyArea/queryNoPage");
    
    [NetworkHandler requestPostWithUrl:https parameters:dic view:nil completion:^(id result) {
        
        if ([level isEqualToString:@"3"]) {
            self.arrayRegion = [NSMutableArray array];
            self.arrayRegion = [result objectForKey:@"result"];
            [self->_regionBtn setTitle:@"请选择" forState:UIControlStateNormal];
            self->_line.frame = CGRectMake((self.regionBtn.frame.size.width - 50) / 2, 29, 50, 1);
            [self->_regionBtn addSubview:self->_line];
            [self->_regionBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
        } else if ([level isEqualToString:@"4"]) {
            self.arrayStreet = [NSMutableArray array];
            self.arrayStreet = [result objectForKey:@"result"];
            if (self.arrayStreet.count > 0) {
                self.streetBtn.hidden = NO;
                [self.streetBtn setTitle:@"请选择" forState:UIControlStateNormal];
                 self->_line.frame = CGRectMake((self.streetBtn.frame.size.width - 50) / 2, 29, 50, 1);
                [self->_streetBtn addSubview:self->_line];
                [self->_streetBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
            }
        } else if ([level isEqualToString:@"5"]) {
            self.arrayCommunity = [NSMutableArray array];
            self.arrayCommunity = [result objectForKey:@"result"];
            if (self.arrayCommunity.count > 0) {
                self.communityBtn.hidden = NO;
                [self.communityBtn setTitle:@"请选择" forState:UIControlStateNormal];
                self->_line.frame = CGRectMake((self.communityBtn.frame.size.width - 50) / 2, 29, 50, 1);
                [self->_communityBtn addSubview:self->_line];
                [self->_communityBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
            } else {
                self.communityBtn.hidden = YES;
                self.chooseType = @"street";
                [self.streetBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
            }
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.chooseType isEqualToString:@"region"]) {
        return self.arrayRegion.count;
    } else if ([self.chooseType isEqualToString:@"street"]) {
        return self.arrayStreet.count;
    } else if ([self.chooseType isEqualToString:@"community"]) {
        return self.arrayCommunity.count;
    }
    return 0;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellName = @"ChooseLocationUITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.backgroundColor = BackgroundBlack;
    
    if ([self.chooseType isEqualToString:@"region"]) {
        cell.textLabel.text = self.arrayRegion[indexPath.row][@"name"];
    } else if ([self.chooseType isEqualToString:@"street"]) {
        cell.textLabel.text = self.arrayStreet[indexPath.row][@"name"];
    } else if ([self.chooseType isEqualToString:@"community"]) {
        cell.textLabel.text = self.arrayCommunity[indexPath.row][@"name"];
    }
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    if ([self.chooseType isEqualToString:@"region"]) {
        if ([[self.chooseCodeDic allKeys] containsObject:@"region"]) { // 已选择区域
            [self.chooseCodeDic removeObjectForKey:@"street"];
            [self.chooseCodeDic removeObjectForKey:@"streetName"];
            [self.chooseCodeDic removeObjectForKey:@"community"];
            [self.chooseCodeDic removeObjectForKey:@"communityName"];
            self.communityBtn.hidden = YES;
        }
        [self.regionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.regionBtn setTitle:self.arrayRegion[indexPath.row][@"name"] forState:UIControlStateNormal];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayRegion[indexPath.row][@"areaCode"]] forKey:@"region"];
        [self.chooseCodeDic setObject:self.arrayRegion[indexPath.row][@"name"] forKey:@"regionName"];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayRegion[indexPath.row][@"latitude"]] forKey:@"latitude"];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayRegion[indexPath.row][@"longitude"]] forKey:@"longitude"];
        self.chooseType = @"street";
        [self setNetAreacode:[NSString stringWithFormat:@"%@", self.arrayRegion[indexPath.row][@"areaCode"]] level:@"4"];
    } else if ([self.chooseType isEqualToString:@"street"]) {
        if ([[self.chooseCodeDic allKeys] containsObject:@"street"]) { // 已选择街道/镇
            [self.chooseCodeDic removeObjectForKey:@"community"];
            [self.chooseCodeDic removeObjectForKey:@"communityName"];
        }
        [self.streetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.streetBtn setTitle:self.arrayStreet[indexPath.row][@"name"] forState:UIControlStateNormal];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayStreet[indexPath.row][@"areaCode"]] forKey:@"street"];
        [self.chooseCodeDic setObject:self.arrayStreet[indexPath.row][@"name"] forKey:@"streetName"];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayStreet[indexPath.row][@"latitude"]] forKey:@"latitude"];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayStreet[indexPath.row][@"longitude"]] forKey:@"longitude"];
        self.chooseType = @"community";
        [self setNetAreacode:[NSString stringWithFormat:@"%@", self.arrayStreet[indexPath.row][@"areaCode"]] level:@"5"];
    } else if ([self.chooseType isEqualToString:@"community"]) {
        [self.communityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.communityBtn setTitle:self.arrayCommunity[indexPath.row][@"name"] forState:UIControlStateNormal];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayCommunity[indexPath.row][@"areaCode"]] forKey:@"community"];
        [self.chooseCodeDic setObject:self.arrayCommunity[indexPath.row][@"name"] forKey:@"communityName"];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayCommunity[indexPath.row][@"latitude"]] forKey:@"latitude"];
        [self.chooseCodeDic setObject:[NSString stringWithFormat:@"%@", self.arrayCommunity[indexPath.row][@"longitude"]] forKey:@"longitude"];
    }
    if ([self.delegate respondsToSelector:@selector(setChooseLocationCode:dic:)]) {
        [self.delegate setChooseLocationCode:self dic:self.chooseCodeDic];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (IBAction)closeBtnAction:(id)sender {
    [self setCloseView];
}

- (IBAction)cityBtnAction:(id)sender {
    [self setCloseView];
}

- (void)setCloseView {
    self.chooseCodeDic = [NSMutableDictionary dictionary];
    self.chooseType = @"region";
    self.streetBtn.hidden = YES;
    self.communityBtn.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(setCloseBtnAction:)]) {
        [self.delegate setCloseBtnAction:self];
    }
}

- (IBAction)regionBtnAction:(id)sender {
    self.chooseType = @"region";
    self->_line.frame = CGRectMake((self.regionBtn.frame.size.width - 50) / 2, 29, 50, 1);
    [self->_regionBtn addSubview:self->_line];
    [self->_regionBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    [self->_streetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self->_communityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.tableView reloadData];
}

- (IBAction)streetBtnAction:(id)sender {
     self.chooseType = @"street";
    self->_line.frame = CGRectMake((self.streetBtn.frame.size.width - 50) / 2, 29, 50, 1);
    [self->_streetBtn addSubview:self->_line];
    [self->_streetBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    [self->_regionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self->_communityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.tableView reloadData];
}

- (IBAction)communityBtnAction:(id)sender {
    self.chooseType = @"community";
    self->_line.frame = CGRectMake((self.communityBtn.frame.size.width - 50) / 2, 29, 50, 1);
    [self->_communityBtn addSubview:self->_line];
    [self->_communityBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    [self->_regionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self->_streetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

@end
