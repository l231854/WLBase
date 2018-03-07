//
//  NavigationController.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "NavigationController.h"
#import "NavigationInteractiveTransition.h"

#define WINDOW  [[UIApplication sharedApplication] keyWindow]
#define SCREEN_VIEW_WIDTH  self.view.bounds.size.width

@interface NavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
{
    CGPoint startTouch; //拖动开始时位置
    BOOL isMoving;      //是否在拖动中
    UIView *blackMask;
    //The snapshot
    UIImageView *lastScreenShotView;
}
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@property (nonatomic, strong) UIImage* topScreenShotImage;
@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong) UIImageView* screenShotImageview;
@property (nonatomic) CGPoint startLocation;

@end

@implementation NavigationController

- (id)init
{
    self = [self init];
    if (self) {
        //        // 只少2个 头一个肯定是顶级的界面
        //        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isMoving = NO;
    
    self.delegate = self;
    
    //适配
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    self.removeView = gestureView;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    self.popRemoveRecognizer = popRecognizer;
    
       //#elif USE_方案二
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}


#pragma mark 第三种实现全屏原生动画返回的方式，截了一张全凭图，贴在被滑动的view上面，为了解决前后页面导航栏不一致颜色产生的导航栏与下面的view分裂行为, 因为不想全部每个页面自定义navigationBar
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.topView = self.topViewController.view;
}


- (UIImage *)ViewRenderImageBy:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer translationInView:self.view];
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue] && (point.x>0 /*&& abs(point.y) < 20*/);
}

@end
