//
//  PatrolRecordView.m
//  eia
//
//  Created by JimmyYue on 2020/7/13.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "PatrolRecordView.h"

@implementation PatrolRecordView

- (void)setUpdatePatrolRecordView {
    [self loadNewData];
}

- (void)setAllowPatrolRecordView:(NSString *)Id {
    
    self.arrayListResult = [[NSMutableArray alloc] init];
    
    self.Id = Id;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
       
    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
       
       self.refreshStr = @"down";
       self.start = @"0";
       self.pageSize = @"20";
       [self setNetList];
}

- (void)loadNewData {
    self.refreshStr = @"down";
    self.start = @"0";
    [self setNetList];
}

- (void)loadMoreData {
    self.refreshStr = @"up";
    self.start = [NSString stringWithFormat:@"%lu", (unsigned long)self.arrayListResult.count];
    [self setNetList];
}

//  设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayListResult.count;
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
}

//  分区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 5;
}

//  设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = BackgroundBlack;
    return viewHeader;
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight;
        sectionHeaderHeight = 5;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"PatrolRecordTableViewCell";
    PatrolRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PatrolRecordTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"purpose"]]] == NO) {
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"purpose"]];
    }
    if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"engageTypeName"]]] == NO) {
        cell.engageTypeNameLabel.text = [NSString stringWithFormat:@"企业状况 ︲ %@", self.arrayListResult[indexPath.section][@"engageTypeName"]];
    }
    if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"resultsTypeName"]]] == NO) {
        cell.resultsTypeNameLabel.text = [NSString stringWithFormat:@"环保手续 ︲ %@", self.arrayListResult[indexPath.section][@"resultsTypeName"]];
    }
    if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"resultsText"]]] == NO) {
        cell.resultsTextLabel.text = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"resultsText"]];
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ 更新于 %@", self.arrayListResult[indexPath.section][@"lastUpdateName"], [[NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"lastUpdateTime"]] timeToyyyy_MM_dd]];
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    PatrolDetailViewController *patrolDetailVC = [[PatrolDetailViewController alloc] init];
    patrolDetailVC.Id = [NSString stringWithFormat:@"%@", self.arrayListResult[indexPath.section][@"id"]];
    [self.view.navigationController pushViewController:patrolDetailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

- (void)setNetList {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpFollow/query") parameters:@{@"pageSize":self.pageSize, @"start":self.start,@"entity":@{@"etpId":self.Id}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            if ([self.refreshStr isEqualToString:@"down"]) {
                self.arrayListResult = [NSMutableArray array];
            }
            
            if ([result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                array = [[result objectForKey:@"result"] objectForKey:@"data"];
                
                for (NSMutableDictionary *dic in array) {
                    [self.arrayListResult addObject:dic];
                }
            }
            if ([self.refreshStr isEqualToString:@"down"] || [result[@"result"][@"dataSizeOfCurrentPage"] integerValue] > 0) {
                [self.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
