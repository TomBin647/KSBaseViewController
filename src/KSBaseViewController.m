//
//  KSBaseViewController.m
//  KSBaseViewController
//
//  Created by bing.hao on 15/9/14.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import "KSBaseViewController.h"

@interface KSBaseViewController ()

@end

@implementation KSBaseViewController

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInit];
    }
    return self;
}

- (void)myInit
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)dealloc
{
    if (_hud)        _hud        = nil;
    if (_tableView)  _tableView  = nil;
    if (_dataSource) _dataSource = nil;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    if (self.navigationController) {
        UIView *leftView  = [self customNavigationbarLeftButton];
        UIView *rightView = [self customNavigationbarRightButton];
        if (leftView) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
        }
        if (rightView) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
        }
    }
    //组件初始化
    [self initializationComponent];
    //注册通知
    [[self registerNotifications] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [KS_NOTIFY addObserver:self selector:@selector(receiveNotificationHandler:) name:obj object:nil];
    }];
}

#pragma mark - 组件初始化

- (void)initializationComponent
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self isKeyboardListener]) {
        [KS_NOTIFY addObserver:self selector:@selector(receiveNotificationHandler:) name:UIKeyboardWillShowNotification object:nil];
        [KS_NOTIFY addObserver:self selector:@selector(receiveNotificationHandler:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self isKeyboardListener]) {
        [KS_NOTIFY removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [KS_NOTIFY removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    [super viewWillDisappear:animated];
}


#pragma mark - 自定义导航

/**
 * @breif 自定义导航栏
 */
- (UINavigationBar *)customNavigationbar
{
    return nil;
}
/**
 * @brief 导航栏目左边按钮
 */
- (UIView *)customNavigationbarLeftButton
{
    return nil;
}
/**
 * @brief 导航栏目右边按钮
 */
- (UIView *)customNavigationbarRightButton
{
    return nil;
}
/**
 * 导航栏左侧按钮事件
 */
- (void)leftButtonOnClickEventHandler:(id)sender
{
    
}
/**
 * 导航栏右侧按钮事件
 */
- (void)rightButtonOnClickEventHandler:(id)sender
{
    
}

#pragma mark - 通知

/**
 * @brief 注册通知,在viewDidLoad方法中启动, dealloc方法销毁
 */
- (NSArray *)registerNotifications
{
    return nil;
}
/**
 * @brief 接收通知
 */
- (void)receiveNotificationHandler:(NSNotification *)notice
{
    
}

#pragma mark - 开启键盘监听

- (BOOL)isKeyboardListener
{
    return NO;
}

#pragma mark - 扩展

- (void)pushWithController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushWithController:(UIViewController *)vc animated:(BOOL)animated
{
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)pushWithController:(Class)c params:(NSDictionary *)params
{
    [self pushWithController:c params:params animated:YES];
}

- (void)pushWithController:(Class)c params:(NSDictionary *)params animated:(BOOL)animated
{
    UIViewController * vc = [c new];
    if (params) {
        for (NSString * key in params.allKeys) {
            [vc setValue:[params objectForKey:key] forKeyPath:key];
        }
    }
    [self pushWithController:vc animated:animated];
}

- (void)pushWithName:(NSString *)name
{
    [self pushWithName:name params:nil];
}

- (void)pushWithName:(NSString *)name params:(NSDictionary *)params
{
    UIViewController * vc = KS_NEW_OBJECT(name);
    if (params) {
        for (NSString * key in params.allKeys) {
            [vc setValue:[params objectForKey:key] forKeyPath:key];
        }
    }
    [self pushWithController:vc];
}


- (void)addChild:(UIView *)childView
{
    [self.view addSubview:childView];
}
- (void)addChild:(UIView *)childView atIndex:(NSInteger)index
{
    [self.view insertSubview:childView atIndex:index];
}

- (UIView *)addChildWithClassType:(Class)classType
{
    return [self addChildWithClassType:classType params:nil];
}

- (UIView *)addChildWithClassType:(Class)classType params:(NSDictionary *)params
{
    id obj = [classType new];
    if (params) {
        for (NSString *key in params.allKeys) {
            [obj setValue:[params objectForKey:key] forKeyPath:key];
        }
    }
    [self addChild:obj];
    return obj;
}

- (UIView *)addChildWithClassName:(NSString *)className
{
    return [self addChildWithClassType:NSClassFromString(className) params:nil];
}

- (UIView *)addChildWithClassName:(NSString *)className params:(NSDictionary *)params
{
    return [self addChildWithClassType:NSClassFromString(className) params:params];
}


#pragma mark - UITableView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame          = CGRectMake(0, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT);
        _tableView.delegate       = self;
        _tableView.dataSource     = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if (self.navigationController && self.navigationController.navigationBarHidden == NO) {
            _tableView.height -= (self.navigationController.navigationBar.height + 20);
        }
        if (self.tabBarController && self.hidesBottomBarWhenPushed == NO) {
            _tableView.height -= self.tabBarController.tabBar.height;
        }
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

#pragma mark - MBProgressHUD

- (MBProgressHUD *)hud
{
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        [_hud setHidden:YES];
        [self addChild:_hud];
    }
    return _hud;
}

- (void)displayHUDAndAfterDelayHide:(void (^)(void))complete
{
    [self displayHUDAndAfterDelayHide:1.5f complete:complete];
}

- (void)displayHUDAndAfterDelayHide:(NSTimeInterval)interval complete:(void (^)(void))complete
{
    KS_WS(ws);
    
    KS_DISPATCH_MAIN_QUEUE(^{
        [ws.hud show:YES];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        KS_DISPATCH_MAIN_QUEUE(^{
            [ws.hud setHidden:YES];
        });
    });
}

@end










