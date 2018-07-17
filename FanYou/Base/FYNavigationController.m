//
//  FYNavigationController.m
//
//  Created by Xiaoheng on 15/1/21.
//  Copyright (c) 2015年 XH. All rights reserved.
//

#import "FYNavigationController.h"


@implementation UINavigationItem (CustomBackButton)

@end

@interface FYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation FYNavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 22);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 28);
    
    [backButton addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitle:@"返回" forState:0];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:0];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    viewController.navigationItem.leftBarButtonItem = backItem;
    viewController.title = viewController.title;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.interactivePopGestureRecognizer.delegate =  self;
    
    self.navigationBar.translucent =NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];

    [self.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      UIColorFromRGB(0x333333),NSForegroundColorAttributeName,
      [UIFont systemFontOfSize:18], NSFontAttributeName,
      nil]];

    // Do any additional setup after loading the view.
}
-(void)backto{
    [self popViewControllerAnimated:YES];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
