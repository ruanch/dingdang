//
//  MMBMNavBarViewController.m
//  makeMoney
//
//  Created by zwd on 14-8-21.
//  Copyright (c) 2014年 zwd. All rights reserved.
//

#import "DDBMNavBarViewController.h"

@interface DDBMNavBarViewController ()
{
    NSString *navTitle;
}

@end

@implementation DDBMNavBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initNavigate:(NSString*)title
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        // Custom initialization
        navTitle = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.btnLeft.hidden = YES;
    self.btnRight.hidden = YES;
    self.btnSecondLeft.hidden = YES;
    self.btnSecondRight.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    self.labTitle.text = navTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
