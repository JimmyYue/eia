//
//  PatrolDetailViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "PatrolDetailViewController.h"

@interface PatrolDetailViewController ()

@end

@implementation PatrolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"巡查详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.arrayImage = [[NSMutableArray alloc] init];
    
    //  UICollectionView 的使用
    UICollectionViewFlowLayout *flowlayoutS = [[UICollectionViewFlowLayout alloc] init];
    flowlayoutS.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayoutS.itemSize = CGSizeMake((self.view.frame.size.width - 50) / 4, (self.view.frame.size.width - 50) / 4);
    flowlayoutS.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, kDeviceHeight - NavRect - StatusRect) collectionViewLayout:flowlayoutS];
    self.photoCollectionView.backgroundColor = [UIColor whiteColor];
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    [self.view addSubview: self.photoCollectionView];
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"PhotographCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotographCollectionViewCell"];
    
    [self setNetDetail];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayImage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *indtifer = @"PhotographCollectionViewCell";
    PhotographCollectionViewCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:indtifer forIndexPath:indexPath];
    
    cell.chooseBtn.hidden = YES;
    [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.arrayImage[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 50) / 4, (self.view.frame.size.width - 50) / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ImagePreview *imagePreview = [[ImagePreview alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    [imagePreview setImagePreview];
    [imagePreview setFileCode:[NSString stringWithFormat:@"%@", self.arrayImage[indexPath.row]]];
}

// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 425 + self.height);
    return size;
}
 
// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
       UICollectionReusableView *reusableView = nil;
    
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
             [collectionView registerNib:[UINib nibWithNibName:@"PatrolDetailHearerView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PatrolDetailHearerView"];
            
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PatrolDetailHearerView" forIndexPath:indexPath];
            self.headerView.backgroundColor = [UIColor lightTextColor];
            
            reusableView = self.headerView;
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            // 底部视图
        }
        return reusableView;
}

- (void)setNetDetail {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpFollow/detail") parameters:@{@"entity":@{@"id":self.Id}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.headerView.patrolPurposeLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"purpose"]];
            
            self.headerView.engageTypeNameLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"engageTypeName"]];
            
            self.headerView.resultsTypeNameLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"resultsTypeName"]];
            
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"resultsText"]]] == NO) {
                NSString *str = [NSString stringWithFormat:@"%@", result[@"result"][@"resultsText"]];
                NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
                CGRect rect = [str boundingRectWithSize:CGSizeMake(kDeviceWidth - 100, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                self.height = rect.size.height + 20;
                
                self.headerView.resultsTextLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"resultsText"]];
            }
            
             self.headerView.lastUpdateNameLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"lastUpdateName"]];
            
            self.headerView.createTimeLabel.text = [[NSString stringWithFormat:@"%@", result[@"result"][@"createTime"]] timeToyyyy_MM_dd];
            
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"result"][@"signatureImg"]]] == NO) {
                [self.headerView.signatureImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, result[@"result"][@"signatureImg"]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
            }
            
            self.arrayImage = [NSMutableArray arrayWithArray:result[@"result"][@"followFileList"]];
            [self.photoCollectionView reloadData];
            
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
