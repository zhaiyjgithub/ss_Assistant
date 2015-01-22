

// 1.判断是否为iPhone5的宏
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width





// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]



//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#import "BaseTabbarController.h"
#import "UIViewExt.h"

@interface BaseTabButton : UIButton
@end
@implementation BaseTabButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    CGRect frame = [self titleLabel].frame;
    frame.origin.x = 0;
    frame.origin.y = self.imageView.frame.size.height + 2;
    frame.size.width = self.frame.size.width;
    self.titleLabel.frame = frame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor=[UIColor blackColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    
}

@end
#pragma mark -BaseTab
@interface BaseTabbarController ()
@end

@implementation BaseTabbarController

/**
 *  删除自带Tabbar
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    _slideBg=[[UIImageView alloc] init];
    _slideBg.backgroundColor=[UIColor whiteColor];
    [self hideRealTabBar];
    
    [self customTabBar];
    //
    //1.通知
    
    
}


#pragma mark -TabBa隐藏
- (void)hideRealTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden = YES;
            break;
        }
    }
}
#pragma mark -自定义tabbar
#define kDockHeight 50
#define kDockWidth 64




- (void)customTabBar{
    _tabView = [[UIView alloc] init];
    _tabView.frame = CGRectMake(0, ScreenHeight-kDockHeight, ScreenWidth, kDockHeight);
    _tabView.backgroundColor=Color(251, 251, 251, 0.95);//kColor(251, 241, 251);
    [self.view addSubview:_tabView];
    //1.数组
    NSArray * tabTitles=@[@"首页",@"电话",@"我的"];
    
    
    //2.创建按钮
    int viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
    self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
    double _width = ScreenWidth / viewCount;
   // double _height = self.tabBar.frame.size.height;
    for (int i = 0; i < viewCount; i++) {
        //icon_tabbar_01_h
        NSString * normalImage = [NSString stringWithFormat:@"icon_tabbar_0%d",i+1];
        NSString * highlightImage = [NSString stringWithFormat:@"icon_tabbar_0%d_h",i+1];
        BaseTabButton *btn = [[BaseTabButton alloc]initWithFrame:CGRectMake(i*_width+25,0, kDockWidth, kDockHeight)];
        btn.imageView.contentMode=UIViewContentModeScaleToFill;
        [btn setImage:[UIImage imageNamed:normalImage]  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
        
        
        //3.文字
        [btn setTitle:tabTitles[i] forState:UIControlStateNormal];
        [btn setTitle:tabTitles[i] forState:UIControlStateSelected];

    
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.buttons addObject:btn];
        [_tabView  addSubview:btn];
       
    }
 
   
    [self selectedTab:[self.buttons objectAtIndex:0]];
   
    
}
//
//
- (void)selectedTab:(UIButton *)button{
    
  
    self.currentSelectedIndex = button.tag;
    self.selectedIndex = self.currentSelectedIndex;
   
    _selectedButton.selected = NO;
    
    // 2.选中点击的item
    button.selected = YES;
    // 3.赋值
    _selectedButton = button;
    

}
-(void)setIsBarHidden:(BOOL)isBarHidden{

    _isBarHidden =isBarHidden;
    
    if (isBarHidden==YES) {
        

        _tabView.hidden=YES;
      
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _tabView.hidden=NO;
        }];
    }
}


//#pragma mark -控制器切换
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //1.展示时候
    UIViewController * rootCtrl=navigationController.viewControllers[0];
    if (rootCtrl!=viewController) {
        CGRect frame =navigationController.view.frame;
        frame.size.height=[UIScreen mainScreen].applicationFrame.size.height+20;
        navigationController.view.frame=frame;
        
        //2.把tabbar到view下面
        [self.tabView removeFromSuperview];
        
        CGRect tabFrame =self.tabView.frame;
        tabFrame.origin.y=ScreenHeight-self.tabView.height;
        if ([rootCtrl.view isKindOfClass:[UIScrollView class]]) {
            //
            UIScrollView *scrollView =(UIScrollView*)rootCtrl.view;
            tabFrame.origin.y+=scrollView.contentOffset.y;
        }
        self.tabView.frame=tabFrame;
        [rootCtrl.view addSubview:self.tabView];
        
    }

}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //3.展示时候
    UIViewController * rootCtrl=navigationController.viewControllers[0];
    if (rootCtrl==viewController) {
        CGRect frame =navigationController.view.frame;
        frame.size.height=[UIScreen mainScreen].applicationFrame.size.height;
        navigationController.view.frame=frame;
        
        //4.把tabbar到view下面
        [self.tabView removeFromSuperview];
        self.tabView.y=self.view.height-self.tabView.height;
        [self.view addSubview:self.tabView];
    }
   
}


@end
