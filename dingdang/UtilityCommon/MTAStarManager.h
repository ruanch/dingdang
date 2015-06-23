//
//  MTAStarManager.h
//  Test_selectPathForColor
//
//  Created by Chen Jing on 14-7-29.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MTBoardLocation : NSObject<NSCopying, NSCoding>
@property NSInteger x;
@property NSInteger y;

+(instancetype)pX:(int)x Y:(int)y;
+(instancetype)pointWithCGPoint:(CGPoint)point;
-(id)initWithX:(NSInteger)x Y:(NSInteger)y;
-(CGPoint)CGPoint;
-(BOOL)isEqualOtherBoardLocation:(MTBoardLocation *)point;
@end



@interface MTAStarManager : NSObject

-(instancetype)initWithObstanclesFileName:(NSString *)fileName;

-(BOOL)resourceIsReady;

/**
 *  返回路径
 *
 *  @param startPoint 起点  MTBoardLocation
 *  @param endPoint   终点  MTBoardLocation
 *
 *  @return 数组中每个元素都是 MTBoardLocation 类型
 */
-(NSArray *)pathWithStartGridPoint:(MTBoardLocation *)startPoint endGridPoint:(MTBoardLocation *)endPoint;

@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)NSInteger column;
@property(nonatomic,assign)NSInteger sizeImageWidth;
@property(nonatomic,assign)NSInteger sizeImageHeight;
@end
