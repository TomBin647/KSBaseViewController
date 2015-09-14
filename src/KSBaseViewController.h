//
//  KSBaseViewController.h
//  KSBaseViewController
//
//  Created by bing.hao on 15/9/14.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSToolkit/KSToolkit.h>
#import <KSRefresh/UIScrollView+KS.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>

@interface KSBaseViewController : UIViewController
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate,
    KSRefreshViewDelegate
>

#pragma mark - 组件初始化

/**
 * @brief 组件初始化
 */
- (void)initializationComponent;


#pragma mark - 自定义导航

/**
 * @breif 自定义导航栏
 */
- (UINavigationBar *)customNavigationbar;
/**
 * @brief 导航栏目左边按钮
 */
- (UIView *)customNavigationbarLeftButton;
/**
 * @brief 导航栏目右边按钮
 */
- (UIView *)customNavigationbarRightButton;
/**
 * 导航栏左侧按钮事件
 */
- (void)leftButtonOnClickEventHandler:(id)sender;
/**
 * 导航栏右侧按钮事件
 */
- (void)rightButtonOnClickEventHandler:(id)sender;

#pragma mark - 通知

/**
 * @brief 注册通知,在viewDidLoad方法中启动, dealloc方法销毁
 */
- (NSArray *)registerNotifications;
/**
 * @brief 接收通知
 */
- (void)receiveNotificationHandler:(NSNotification *)notice;

#pragma mark - 开启键盘监听

- (BOOL)isKeyboardListener;

#pragma mark - 扩展

/**
 * @brief 横向滑动转换在当前导航内
 */
- (void)pushWithController:(UIViewController *)vc;
- (void)pushWithController:(UIViewController *)vc animated:(BOOL)animated;
- (void)pushWithController:(Class)c params:(NSDictionary *)params;
- (void)pushWithController:(Class)c params:(NSDictionary *)params animated:(BOOL)animated;
- (void)pushWithName:(NSString *)name;
- (void)pushWithName:(NSString *)name params:(NSDictionary *)params;

/**
 * @brief 等同于UIView中的addSubView方法
 */
- (void)addChild:(UIView *)childView;
- (void)addChild:(UIView *)childView atIndex:(NSInteger)index;

- (UIView *)addChildWithClassType:(Class)classType;
- (UIView *)addChildWithClassType:(Class)classType params:(NSDictionary *)params;
- (UIView *)addChildWithClassName:(NSString *)className;
- (UIView *)addChildWithClassName:(NSString *)className params:(NSDictionary *)params;


#pragma mark - UITableView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

#pragma mark - MBProgressHUD

@property (nonatomic, strong) MBProgressHUD *hud;

/**
 * @brief 显示HUD并在XX秒后自动隐藏,并触发回调函数,默认1.5秒
 */
- (void)displayHUDAndAfterDelayHide:(void (^)(void))complete;
- (void)displayHUDAndAfterDelayHide:(NSTimeInterval)interval complete:(void (^)(void))complete;

@end
