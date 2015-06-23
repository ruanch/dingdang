//
//  GlobalDefine.h
//  iNews
//
//  Created by FZDC FZDC on 14-1-13.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
#define SystemVersionBelowSeven ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)

#define DOCUMENT_PATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define CACHES_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]


#ifdef DEBUG
#   define DLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#endif


#endif
