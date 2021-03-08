//
//  ChooseLocationViewController.m
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ChooseLocationViewController.h"

@interface ChooseLocationViewController ()

@end

@implementation ChooseLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择区域";
    self.view.backgroundColor = BackgroundBlack;
    
    _chooseLocationTopView = [[NSBundle mainBundle] loadNibNamed:@"ChooseLocationTopView" owner:nil options:nil][0];
    _chooseLocationTopView.frame = CGRectMake(0, 0, kDeviceWidth, 160);
    _chooseLocationTopView.delegate = self;
    [self.view addSubview:_chooseLocationTopView];
    [_chooseLocationTopView setAllowChooseLocationTopView];
    
    self.letterArray = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    
    self.bATableView = [[BATableView alloc] initWithFrame:CGRectMake(0, 175, kDeviceWidth, kDeviceHeight - StatusRect - NavRect - 235)];
    self.bATableView.delegate = self;
    [self.view addSubview:self.bATableView];
    
    [self setBook];
    
    _chooseLocationCustomView = [[NSBundle mainBundle] loadNibNamed:@"ChooseLocationCustomView" owner:nil options:nil][0];
    _chooseLocationCustomView.frame = CGRectMake(0, kDeviceHeight, kDeviceWidth, kDeviceHeight - NavRect - StatusRect);
    _chooseLocationCustomView.delegate = self;
    [self.view addSubview:_chooseLocationCustomView];
    [_chooseLocationCustomView setAllowChooseLocationCustomView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(40, kDeviceHeight - 60 - NavRect - StatusRect, kDeviceWidth - 80, 45);
    [sureBtn setTitle:@"确认选择" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn.layer setMasksToBounds:YES];
    [sureBtn.layer setCornerRadius:22.5];
    sureBtn.backgroundColor = TabbarBlack_S;
    [self.view addSubview:sureBtn];
    
    self.chooseDic = [[NSMutableDictionary alloc] init];  // 选择的dic
}

- (void)setCloseBtnAction:(ChooseLocationCustomView *)view {
    [UIView animateWithDuration:0.3 animations:^{
        self->_chooseLocationCustomView.frame = CGRectMake(0, kDeviceHeight, kDeviceWidth, kDeviceHeight - NavRect - StatusRect);
    }];
}

- (void)sureBtnAction {  // 确认选择
    if (self.chooseDic.count > 0) {
        if ([self.chooseLevel isEqualToString:@"street"]) {
            if ([[self.chooseDic allKeys] containsObject:@"street"]) {
                [self setChooseRegionDic];
            } else {
                [SVProgressHUD showInfoWithStatus:@"请选择街道/镇!"];
            }
        } else if ([self.chooseLevel isEqualToString:@"region"]) {
            if ([[self.chooseDic allKeys] containsObject:@"region"]) {
                [self setChooseRegionDic];
            } else {
                [SVProgressHUD showInfoWithStatus:@"请选择区域!"];
            }
        } else {
            [self setChooseRegionDic];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择位置!"];
    }
}

- (void)setChooseRegionDic {
    NSMutableArray *array = [NSMutableArray arrayWithArray:[XYCommon GetUserDefault:@"HistoryArray"]];
    BOOL isbool = [array containsObject:self.chooseDic];
    if (isbool == NO) {
        if (array.count == 6) {
            [array removeObjectAtIndex:0];
        }
        [array addObject:self.chooseDic];
        [XYCommon SetUserDefault:@"HistoryArray" byValue:array];
    }
    self.block(self.chooseDic);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    return self.letterArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.letterArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.letterArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataSource [indexPath.section] [indexPath.row] [@"name"]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    [_chooseLocationCustomView setChooseCityName:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row][@"name"]] cityCode:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row][@"areaCode"]]];
    [self.chooseDic setObject:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row][@"name"]] forKey:@"cityName"];
    [self.chooseDic setObject:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row][@"areaCode"]] forKey:@"city"];
    [self.chooseDic setObject:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row][@"longitude"]] forKey:@"longitude"];
    [self.chooseDic setObject:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.section][indexPath.row][@"latitude"]] forKey:@"latitude"];
    [UIView animateWithDuration:0.3 animations:^{
        self->_chooseLocationCustomView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - NavRect - StatusRect);
    }];
}

- (void)setBook { // 字母排序开放城市
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"cpyArea/queryByLetterBook") parameters:@{@"entity":@{}} view:self completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([[NSString stringWithFormat:@"%@", [result objectForKey:@"isSuccess"]] isEqualToString:@"1"]) {
            
            NSMutableDictionary *dicData = [[NSMutableDictionary alloc] init];
            dicData = [result objectForKey:@"result"];
            
            NSArray *array = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
            
            for (int i = 0; i < array.count; i++) {
                if ([dicData [array[i]] count] > 0) {
                    [self.letterArray addObject:array[i]];
                    [self.dataSource addObject:dicData [array[i]]];
                }
            }
            
            NSLog(@"%@", self.dataSource);
            
            [self.bATableView reloadData];
        }
    } failure:^(NSError *error) {
    }];
}


- (void)setChooseCode:(ChooseLocationTopView *)view dic:(NSMutableDictionary *)dic {
    self.chooseDic = [NSMutableDictionary dictionaryWithDictionary:dic];
}

- (void)setChooseLocationCode:(ChooseLocationCustomView *)view dic:(NSMutableDictionary *)dic {
    self.chooseDic = [NSMutableDictionary dictionaryWithDictionary:dic];
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
