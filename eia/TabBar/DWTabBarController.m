//
//  DWTabBarController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWTabBarController.h"
#import "DWTabBar.h"

@implementation DWTabBarController

#pragma mark -
#pragma mark - Life Cycle

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    //设置导航控制器颜色
//    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    //去除 TabBar 自带的顶部阴影
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UITabBar appearance] setShadowImage:[self imageWithColor:RGBCOLOR(235, 235, 235)]];
    
//    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:DWColor(253, 218, 68)] forBarMetrics:UIBarMetricsDefault];

}

#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    [self setValue:[[DWTabBar alloc] init] forKey:@"tabBar"];
}


/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = TabbarBlack;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = TabbarBlack_S;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
}


/**
 *  添加子控制器，我这里值添加了5个，没有占位自控制器
 */
- (void)setUpChildViewController{
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc] init]]
               WithTitle:@"首页"
               imageName:@"home"
       selectedImageName:@"home_s"];
    

    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[ParkEnterprisesViewController alloc]init]]
            WithTitle:@"巡查企业"
            imageName:@"company"
    selectedImageName:@"company_s"];
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[DataViewController alloc]init]]
                             WithTitle:@"数据中心"
                             imageName:@"data"
                     selectedImageName:@"data_s"];

    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[PersonalCenterViewController alloc]init]]
                          WithTitle:@"个人中心"
                          imageName:@"set"
                  selectedImageName:@"set_s"];
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.title = title;
    NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName:TabbarBlack, NSFontAttributeName:[UIFont systemFontOfSize:12]};
    NSDictionary *textTitleOptionsSelected = @{NSForegroundColorAttributeName:TabbarBlack_S, NSFontAttributeName:[UIFont systemFontOfSize:12]};
    [viewController.tabBarItem setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:textTitleOptionsSelected forState:UIControlStateSelected];
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    
    // 判断设备型号调整底部按钮位置
    if (DX_IS_IPhoneX_All) {
        [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
        viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(-25, 0, 0, 0);
    }
    [self addChildViewController:viewController];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        // 执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        self.tabBar.tintColor = TabbarBlack_S;
        // 添加动画
        //---将下面的代码块拷贝到此并修改最后一行addAnimation的layer对象即可---
//        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//        //通过初中物理重力公式计算出的位移y值数组
//        animation.values = @[@0.0, @-4.15, @-7.26, @-9.34, @-10.37, @-9.34, @-7.26, @-4.15, @0.0, @2.0, @-2.9, @-4.94, @-6.11, @-6.42, @-5.86, @-4.44, @-2.16, @0.0];
//        animation.duration = 0.8;
//        animation.beginTime = CACurrentMediaTime() + 1;
//        [[arry[index] layer] addAnimation:animation forKey:nil];
        
        self.indexFlag = index;
    }
}

//  这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
