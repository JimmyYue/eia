//
//  BaiDuPOIResultView.m
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/31.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaiDuPOIResultView.h"

@implementation BaiDuPOIResultView

- (void)setAllowBaiDuPOIResultView {
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:self.tableView];
    
    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadMoreData {
    if ([self.delegate respondsToSelector:@selector(setLoadMoreData:)]) {
        [self.delegate setLoadMoreData:self];
    }
}

- (void)setLoadMoreData:(NSMutableArray *)result {
    self.arrayListResult = result;
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayListResult.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"AddHosueAddressTableViewCell";
    AddHosueAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddHosueAddressTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    BMKPoiInfo *poiInfoList = [[BMKPoiInfo alloc] init];
    poiInfoList = _arrayListResult[indexPath.row];
    
//    NSLog(@"名称 : %@------省 : %@------市 : %@------行政区域 : %@------地址信息 : %@------latitude : %f------longitude : %f", poiResult.poiInfoList[i].name, poiResult.poiInfoList[i].province, poiResult.poiInfoList[i].city, poiResult.poiInfoList[i].area, poiResult.poiInfoList[i].address, poiResult.poiInfoList[i].pt.latitude, poiResult.poiInfoList[i].pt.longitude);
    
    if (indexPath.row != self.chooseIndex) {
        cell.chooseImageVie.image = IMAGENAMED(@"");
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", poiInfoList.name];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", poiInfoList.address];
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    self.chooseIndex = indexPath.row;
    [self.tableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(setChooseAddress:index:)]) {
        [self.delegate setChooseAddress:self index:indexPath.row];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
