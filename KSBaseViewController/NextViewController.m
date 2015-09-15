//
//  NextViewController.m
//  KSBaseViewController
//
//  Created by bing.hao on 15/9/15.
//  Copyright (c) 2015年 Bing. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initializationComponent
{
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, 64)];
    
    bar.translucent  = YES;
    bar.barStyle     = UIBarStyleBlackTranslucent;
    bar.opaque       = YES;
    bar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    bar.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:bar];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Next"];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0, 0, 44, 44)];
    [button1 setTitle:@"Back" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(navigationBarLeftButtonHandler:)];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(0, 0, 44, 44)];
    [button2 setTitle:@"View" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(navigationBarRightButtonHandler:)];
    
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    [bar pushNavigationItem:navigationItem animated:YES];
    
    
    [self.view addSubview:self.addButton];
}

- (void)navigationBarRightButtonHandler:(id)sender
{
    [self pushWithName:@"ViewController"];
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"show" forState:UIControlStateNormal];
        [_addButton setBackgroundColor:[UIColor greenColor]];
        [_addButton setFrame:CGRectMake(0, 0, 100, 44)];
        [_addButton setCenter:CGPointMake(KS_SCREEN_WIDTH / 2, KS_SCREEN_HEIGHT / 2)];
        [_addButton addTarget:self action:@selector(addButtonHandler:)];
    }
    return _addButton;
}

- (void)addButtonHandler:(id)sender
{
    
}

@end
