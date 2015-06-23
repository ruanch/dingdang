//
//  MMBMBaseViewController.m
//  makeMoney
//
//  Created by zwd on 14-8-21.
//  Copyright (c) 2014年 zwd. All rights reserved.
//

#import "DDBMBaseViewController.h"
#import "SVProgressHUD.h"
typedef void (^btnAction)(void);

@interface DDBMBaseViewController ()
{
    btnAction leftBtnAction;
    btnAction rightBtnAction;
//    UFBMNavBarViewController * barViewControl;
}
@end

@implementation DDBMBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStyle:) name:kChangeStyle object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)changeStyle:(NSNotification *)notification{
    NSLog(@"....");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNavigatorTitle:(NSString*)title
{
    [self addNavigatorTitle:title parent:self.view];
}


- (void)addNavigatorTitle:(NSString*)title parent:(UIView*)parent
{
    self.barViewControl = [[DDBMNavBarViewController alloc]initNavigate:title];
    if (parent)
        [parent addSubview:self.barViewControl.view];
    else
        [self.view addSubview:self.barViewControl.view];
    [self addChildViewController:self.barViewControl];
    [self.barViewControl didMoveToParentViewController:self];
}

- (void)setNavTitle:(NSString*)title
{
    self.barViewControl.labTitle.text = title;
}

- (void)setBtnAction:(UIButton*) btn action:(void (^)(void))action isLeft:(BOOL)isLeft
{
    if (isLeft)
    {
        leftBtnAction = nil;
        leftBtnAction = [action copy];
        [btn addTarget:self action:@selector(btnLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        rightBtnAction = nil;
        rightBtnAction = [action copy];
        [btn addTarget:self action:@selector(btnRightClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setBtnImage:(UIButton*) btn title:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action isLeft:(BOOL)isLeft
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selected] forState:UIControlStateHighlighted];
    [self setBtnAction:btn action:action isLeft:isLeft];
    btn.hidden = NO;
}

- (void)btnLeftClick:(id)sender
{
    if (leftBtnAction)
        leftBtnAction();
}

- (void)btnRightClick:(id)sender
{
    if (rightBtnAction)
        rightBtnAction();
}

- (void)AddSecondLeftBtnAction:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action
{
    if (!self.barViewControl) return;
    [self setBtnImage:self.barViewControl.btnSecondLeft title:title normal:normal selected:selected action:action isLeft:NO];
}
- (void)AddSecondRightBtnAction:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action
{
    if (!self.barViewControl) return;
    [self setBtnImage:self.barViewControl.btnSecondRight title:title normal:normal selected:selected action:action isLeft:NO];
}

- (void)AddLeftBtnAction:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action
{
    if (!self.barViewControl) return;
    [self setBtnImage:self.barViewControl.btnLeft title:title normal:normal selected:selected action:action isLeft:YES];
}

- (void)AddRightBtnAction:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action
{
    if (!self.barViewControl) return;
    [self setBtnImage:self.barViewControl.btnRight title:title normal:normal selected:selected action:action isLeft:NO];
}

- (void)setBtnBackgroundImage:(UIButton*) btn title:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action  isLeft:(BOOL)isLeft
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateHighlighted];
    [self setBtnAction:btn action:action isLeft:isLeft];
    btn.hidden = NO;
}

- (void)AddLeftBtnBacgroundAction:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action
{
    if (!self.barViewControl) return;
    [self setBtnBackgroundImage:self.barViewControl.btnLeft title:title normal:normal selected:selected action:action isLeft:YES];
}

- (void)AddRightBtnBacgroundAction:(NSString*) title normal:(NSString*)normal selected:(NSString*)selected action:(void (^)(void))action
{
    if (!self.barViewControl) return;
    [self setBtnBackgroundImage:self.barViewControl.btnRight title:title normal:normal selected:selected action:action isLeft:NO];
}

- (void)dealloc
{
    NSLog(@"----> %s,%d",__FUNCTION__,__LINE__);
    leftBtnAction = nil;
    rightBtnAction = nil;
}


-(void) showHUD:(NSString*) text
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.mode = MBProgressHUDAnimationFade;
    _HUD.labelText = @"";
    _HUD.detailsLabelText = text;
    [_HUD show:YES];
}
-(void) hideHUD
{
    if(_HUD != nil)
    {
        [_HUD removeFromSuperview];
        _HUD.delegate = nil;
        _HUD = nil;
    }
}
-(void)delayHUD:(NSString *)text
{
    [self showHUD:text];
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.0];
    [self hideHUD];
}

-(void)createUI
{
    
}
-(void)createData
{
    
}

@end
