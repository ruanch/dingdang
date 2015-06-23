//
//  INUICommonFunc.h
//  iNews
//
//  Created by FZDC FZDC on 14-2-13.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICommonFunc : NSObject

+ (void)showHideLoadingView:(BOOL)isShow;

+ (void)showNotNewWork;

+ (void)setAutoHeightForView:(NSString*)text view:(UIView*)view font:(UIFont*)font;
+ (void)setAutoHeightForViewWithOriginHeight:(NSString*)text view:(UIView*)view font:(UIFont*)font height:(float)height;

+ (void)clearTableSelection:(UITableView *)table;

@end
