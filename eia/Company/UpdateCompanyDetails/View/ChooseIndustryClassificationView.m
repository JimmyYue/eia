//
//  ChooseIndustryClassificationView.m
//  eia
//
//  Created by JimmyYue on 2020/6/30.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ChooseIndustryClassificationView.h"

@implementation ChooseIndustryClassificationView

- (void)setAllowChooseIndustryClassificationViewFrame:(CGRect)frame array:(NSMutableArray *)array{
    
    self.array = [NSMutableArray arrayWithArray:array];
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    [self addSubview:view];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [view addGestureRecognizer:labelTapGestureRecognizer];
    
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.borderWidth = 1.0f;
    self.tableView.layer.borderColor = [ZitiColor CGColor];
    [self addSubview:self.tableView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view.window addSubview:self];
        //  弹出
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.3;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [self.layer addAnimation:animation forKey:nil];
    });
    
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    [self setRemoveView];
}

- (void)setRemoveView {
    [UIView animateWithDuration:0.5 animations:^{
        //  时间内执行的代码
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        //  过了这个时间后执行的代码
        [self removeFromSuperview];
        
    }];
}

//  每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if ([[self.array[indexPath.row] allKeys] containsObject:@"industryName"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.array[indexPath.row][@"industryName"]];
    }
    
    if ([[self.array[indexPath.row] allKeys] containsObject:@"rubbishMenu"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.array[indexPath.row][@"rubbishMenu"]];
    }
    
    if ([[self.array[indexPath.row] allKeys] containsObject:@"parkName"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.array[indexPath.row][@"parkName"]];
    }
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    self.block(self.array[indexPath.row]);
     [self setRemoveView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
