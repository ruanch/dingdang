//
//  INUICommonFunc.m
//  iNews
//
//  Created by FZDC FZDC on 14-2-13.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import "UICommonFunc.h"
#import "SVProgressHUD.h"
#import "StringUtil.h"

@implementation UICommonFunc


+ (void)showHideLoadingView:(BOOL)isShow
{
    if (!isShow)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
        });
    }
}

+ (void)showNotNewWork
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新界面
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
    });
}

+ (void)setAutoHeightForView:(NSString*)text view:(UIView*)view font:(UIFont*)font
{
    CGSize size = [StringUtil getTextSize:view value:text font:font];
    CGRect frame = view.frame;
    if (size.height < view.frame.size.height)
    {
        frame.size.height = size.height;
        [view setFrame:frame];
    }
    
}

+ (void)setAutoHeightForViewWithOriginHeight:(NSString*)text view:(UIView*)view font:(UIFont*)font height:(float)height
{
    CGRect frame = view.frame;
    if (frame.size.height != height)
    {
        frame.size.height = height;
        [view setFrame:frame];
    }
    [self setAutoHeightForView:text view:view font:font];
}

+ (void)clearTableSelection:(UITableView *)table
{
    if (!table) return;
    NSIndexPath *indexPath = [table indexPathForSelectedRow];
    if (!indexPath) return;
    [table deselectRowAtIndexPath:indexPath animated:NO];
}

@end
