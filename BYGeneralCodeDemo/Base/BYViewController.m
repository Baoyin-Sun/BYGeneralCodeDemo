//
//  BYViewController.m
//  BYGeneralCodeDemo
//
//  Created by BaoYin on 2017/5/9.
//  Copyright © 2017年 BaoYin Sun. All rights reserved.
//

#import "BYViewController.h"
#import "BYViewModel.h"

@interface BYViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;

@end

@implementation BYViewController

#pragma mark -
#pragma mark - Override Method
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BYViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController by_setupSubviews];
        [viewController by_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController by_layoutNavigation];
        [viewController by_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<BYViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setIsExtendLayout:NO];
    
    [self layoutNavigationBar:[UIImage imageWithColor:[UIColor by_colorWithHexString:c_grapefruit]] titleColor:[UIColor whiteColor] titleFont:[UIFont boldSystemFontOfSize:18] leftBarButtonItem:nil rightBarButtonItem:nil];
    
    [self changeStatusBarStyle:UIStatusBarStyleLightContent statusBarHidden:NO changeStatusBarAnimated:NO];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.view.backgroundColor = [UIColor by_colorWithHexString:c_whiteTwo];
    
    //获取所有属性 ，遍历 给属性赋值
//    NSArray *names = [NSArray getProperties:[self class]];// #import "NSArray+Extension.h" 使用分类
//    for (NSString *name in names) {
//        //如果字典中的值为空，赋值可能会出问题
//        if (self.params[name]) {
//            [self setValue:self.params[name] forKey:name];
//        }
//    }
//    
//    NSString *title = PBAvailableString(self.params[@"title"]);
//    if (!PBIsEmpty(title)) {
//        self.navigationItem.title = self.params[@"title"];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    //设置滑动回退
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self wz_removeNavgationBarLine];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //导航的rootViewController关闭右滑返回功能
    if (self.navigationController.viewControllers.count <= 1)
    {
        return NO;
    }
    return YES;
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark -
#pragma mark - Customer Method
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.statusBarStyle == UIStatusBarStyleDefault) {
        return self.statusBarStyle;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

/**
 *  去除nav 上的line
 */
- (void)wz_removeNavgationBarLine {
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle = statusBarStyle;
    self.statusBarHidden = statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden = isHide;
        }];
    } else {
        self.navigationController.navigationBarHidden = isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    } else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    } else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

#pragma mark - lazyLoad
- (UIBarButtonItem *) backItem {
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(by_handelBack)];
    }
    return _backItem;
}

#pragma mark - RAC
/**
 *  添加控件
 */
- (void)by_setupSubviews {}

/**
 *  绑定
 */
- (void)by_bindViewModel {}

/**
 *  设置navation
 */
- (void)by_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)by_getNewData {}

/**
 *  返回操作
 */
-(void)by_handelBack {}

@end
