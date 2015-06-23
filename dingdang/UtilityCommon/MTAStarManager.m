//
//  MTAStarManager.m
//  Test_selectPathForColor
//
//  Created by Chen Jing on 14-7-29.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import "MTAStarManager.h"
#define ROOK_MOVE_COST 5
#define BISHOP_MOVE_COST 7
// costs based on the unit square and its diagonal, 1:sqrt(2) =~ 1:1.4 == 10:14 == 5:7

#define NEIGHBORHOOD_TYPE 1  // 0:Von Neumann  1:Moore

#define MAX_ITERATIONS 10000 // just incase. prevent infinite loop




@implementation MTBoardLocation

-(id)initWithX:(NSInteger)x Y:(NSInteger)y{
    self = [super init];
    if(self){
        [self setX:x];
        [self setY:y];
    }
    return self;
}

+(instancetype)pointWithCGPoint:(CGPoint)point {
    return [[MTBoardLocation alloc] initWithX:point.x Y:point.y];
}

+(instancetype)pX:(int)x Y:(int)y{
    return [[MTBoardLocation alloc] initWithX:x Y:y];
}

-(CGPoint)CGPoint {
    return CGPointMake(_x, _y);
}

-(BOOL)isEqualOtherBoardLocation:(MTBoardLocation *)other {
    if (_x == [(MTBoardLocation *)other x] && _y == [(MTBoardLocation *)other y]) {
        return 1;
    }
    return 0;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"MTBoardLocation: X:%d Y:%d",_x,_y];
}

-(NSUInteger) hash{
    return 1;
}

-(instancetype)copy {
    return [MTBoardLocation pX:self.x Y:self.y];
}

- (id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] allocWithZone:zone] init];
    [copy setX:[self x]];
    [copy setY:[self y]];
    return copy;
}

- (id)initWithCoder:(NSCoder *)decoder {

    self = [super init];

    if (!self) {
        return nil;
    }

    _x = [decoder decodeIntegerForKey:@"_x"];
    _y = [decoder decodeIntegerForKey:@"_y"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeInteger:_x forKey:@"_x"];
    [encoder encodeInteger:_y forKey:@"_y"];

}

@end





@interface MTAStarManager (){
    bool *obstacleCells;
    int obstacleCellArrayLength;

    int *hValues;  // (heuristic) manhattan distance to end point
    int *gValues;  // move cost from start point
    int *fValues;  // g + h values

    bool *openList;
    bool *closedList;

    int *parentIndex;
}
@property(nonatomic,strong)NSMutableArray * array_obstancles;
@property(nonatomic,strong)NSMutableArray * array_path;
@property(nonatomic,assign)BOOL isReady;

@end

@implementation MTAStarManager

-(instancetype)initWithObstanclesFileName:(NSString *)fileName{
    if (self = [super init]) {
        self.isReady = NO;
        self.row = 0;
        self.column = 0;
        self.array_obstancles = [NSMutableArray array];
        self.array_path = [NSMutableArray array];
        [self setObstanclesFileName:fileName];
    }
    return self;
}

-(BOOL)resourceIsReady{
    return self.isReady;
}
-(void)setObstanclesFileName:(NSString *)fileName{
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:@"plist"]];

    if (dic) {
        [self.array_obstancles removeAllObjects];
        [self.array_path removeAllObjects];
        self.row = 0;
        self.column = 0;

        [self.array_obstancles addObjectsFromArray:dic[@"obstacles"]];
        [self.array_path addObjectsFromArray:dic[@"path"]];
        self.row = [dic[@"row"] intValue];
        self.column = [dic[@"column"] intValue];
        self.sizeImageHeight = [dic[@"height"] intValue];
        self.sizeImageWidth = [dic[@"width"]intValue];
        self.isReady = YES;


        obstacleCells = (bool*)malloc(sizeof(bool)*self.column * self.row);
        hValues = (int*)malloc(sizeof(int)*self.column * self.row);
        gValues = (int*)malloc(sizeof(int)*self.column * self.row);
        fValues = (int*)malloc(sizeof(int)*self.column*self.row);
        openList = (bool*)malloc(sizeof(bool)*self.column*self.row);
        closedList = (bool*)malloc(sizeof(bool)*self.column*self.row);
        parentIndex = (int*)malloc(sizeof(int)*self.column*self.row);

        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = 0; i < self.array_obstancles.count; i++) {
            MTBoardLocation * bl = [MTBoardLocation pointWithCGPoint:CGPointFromString(self.array_obstancles[i])];
            [tempArray addObject:bl];
        }
        [self updateObstacleCells:tempArray];
    }else{
        self.isReady = NO;
    }
}


-(NSArray *)pathWithStartGridPoint:(MTBoardLocation *)startPoint endGridPoint:(MTBoardLocation *)endPoint {
    NSMutableArray *pathArray = [NSMutableArray array];

//    int subImageWith = myImage.size.width / self.column;
//    int subImageHeight = myImage.size.height / self.row;
//
//    return CGPointMake(px/subImageWith, py/subImageHeight);



    int A = startPoint.x + startPoint.y*self.column;
    int B = endPoint.x + endPoint.y*self.column;
    bool found;
    if(A == B){
        found = true;
        [pathArray addObject:[self LocationFromIndex:A]];
        return pathArray;
    }

    found = false;

    for(int i = 0; i < self.column*self.row; i++){
        openList[i] = false;
        closedList[i] = false;
    }
    //    int start[2] = {A%self.column, (int)A/self.column};
    int end[2] = {B%self.column, (int)B/self.column};
    for(int c = 0; c < self.column; c++){
        for(int r = 0; r < self.row; r++){
            hValues[c+r*self.column] = abs(end[0]-c) + abs(end[1]-r);
        }
    }
    //    printf("\n");
    //    for(int c = 0; c < self.column; c++){
    //        for(int r = 0; r < rows; r++){
    //            printf("%d ",hValues[c+r*self.column]);
    //        }
    //        printf("\n");
    //    }

    // check neighbors, add children to cell, when finished, close this cell
    int step, stepRow, stepColumn, neighborIndex[8];
    gValues[A] = 0;
    openList[A] = true;

    step = A;
    int iterations = 0;
    while(!found && iterations < MAX_ITERATIONS){
        // check if neighbors exist, or are out of bounds.
        MTBoardLocation *stepLocation = [self LocationFromIndex:step];
        stepColumn = stepLocation.x;
        stepRow = stepLocation.y;
        neighborIndex[0] = -1;
        neighborIndex[1] = -1;
        neighborIndex[2] = -1;
        neighborIndex[3] = -1;
        neighborIndex[4] = -1;
        neighborIndex[5] = -1;
        neighborIndex[6] = -1;
        neighborIndex[7] = -1;
        if(stepColumn > 0) neighborIndex[0] = step - 1;
        if(stepColumn < self.column-1) neighborIndex[1] = step + 1;
        if(stepRow > 0) neighborIndex[2] = step - self.column;
        if(stepRow < self.row-1) neighborIndex[3] = step + self.column;
        if(stepColumn > 0 && stepRow > 0) neighborIndex[4] = step - self.column - 1;
        if(stepColumn > 0 && stepRow < self.row-1) neighborIndex[5] = step + self.column - 1;
        if(stepColumn < self.column-1 && stepRow > 0) neighborIndex[6] = step - self.column + 1;
        if(stepColumn < self.column-1 && stepRow < self.row-1) neighborIndex[7] = step + self.column + 1;
        // if neighbors exist, and are on the open list, calculate cost and set their parent
        for(int i = 0; i < 4+NEIGHBORHOOD_TYPE*4; i++){
            if(neighborIndex[i] != -1 && !openList[neighborIndex[i]] && !closedList[neighborIndex[i]] && !obstacleCells[neighborIndex[i]] ){
                if(i < 4)
                    gValues[neighborIndex[i]] = gValues[step] + ROOK_MOVE_COST;
                else
                    gValues[neighborIndex[i]] = gValues[step] + BISHOP_MOVE_COST;
                fValues[neighborIndex[i]] = gValues[neighborIndex[i]] + hValues[neighborIndex[i]];
                parentIndex[neighborIndex[i]] = step;
                openList[neighborIndex[i]] = true;
            }
        }
        openList[step] = false;
        closedList[step] = true;
        int smallestFValue = INT_MAX;
        int smallestIndex = -1;
        for(int i = 0; i < self.column*self.row; i++){
            if(openList[i] && fValues[i] < smallestFValue){
                smallestFValue = fValues[i];
                smallestIndex = i;
            }
        }
        // repeat with step = smallestIndex;
        if(smallestIndex == -1) {
            printf("fail: cannot reach target cell\n");
            return nil;
        }
        step = smallestIndex;
        if(smallestIndex == B){
            //            printf("\n*******\n FOUND\n*******\n");
            // trace parents back to point A, build a list along the way
            int i = 0;
            int pathIndex = B;
            do {
                [pathArray addObject:[self LocationFromIndex:pathIndex]];
                //                pathArray[i] = pathIndex;
                pathIndex = parentIndex[pathIndex];
                i++;
            } while (pathIndex != A && i < MAX_ITERATIONS);
            //            *sizeOfArray = i;
            return pathArray;
        }
        iterations++;
    }

    printf("returning cause iterations got to %d\n",iterations);
    return nil;

}



-(void) updateObstacleCells:(NSArray*)obstacles{
    for(int i = 0; i < self.column * self.row; i++)
        obstacleCells[i] = false;

    for(MTBoardLocation *obstacle in obstacles)
        obstacleCells[ obstacle.x + obstacle.y*self.column ] = true;
}

-(MTBoardLocation*)LocationFromIndex:(int)index{
    return [MTBoardLocation pX:index%self.column Y:(int)index/self.column];
}


-(NSArray*) cellsAccesibleFrom:(MTBoardLocation*)location{

    int A = location.x + location.y*self.column;
    bool found;
    found = false;
    for(int i = 0; i < self.column*self.row; i++){
        openList[i] = false;
        closedList[i] = false;
    }
    // check neighbors, add children to cell, when finished, close this cell
    int step, stepRow, stepColumn, neighborIndex[8];
    gValues[A] = 0;
    openList[A] = true;

    step = A;
    int iterations = 0;
    while(!found && iterations < MAX_ITERATIONS){
        // check if neighbors exist, or are out of bounds.
        MTBoardLocation *stepLocation = [self LocationFromIndex:step];
        stepColumn = stepLocation.x;
        stepRow = stepLocation.y;
        neighborIndex[0] = -1;
        neighborIndex[1] = -1;
        neighborIndex[2] = -1;
        neighborIndex[3] = -1;
        neighborIndex[4] = -1;
        neighborIndex[5] = -1;
        neighborIndex[6] = -1;
        neighborIndex[7] = -1;
        if(stepColumn > 0) neighborIndex[0] = step - 1;
        if(stepColumn < self.column-1) neighborIndex[1] = step + 1;
        if(stepRow > 0) neighborIndex[2] = step - self.column;
        if(stepRow < self.row-1) neighborIndex[3] = step + self.column;
        if(stepColumn > 0 && stepRow > 0) neighborIndex[4] = step - self.column - 1;
        if(stepColumn > 0 && stepRow < self.row-1) neighborIndex[5] = step + self.column - 1;
        if(stepColumn < self.column-1 && stepRow > 0) neighborIndex[6] = step - self.column + 1;
        if(stepColumn < self.column-1 && stepRow < self.row-1) neighborIndex[7] = step + self.column + 1;
        // if neighbors exist, and are on the open list, calculate cost and set their parent
        for(int i = 0; i < 4+NEIGHBORHOOD_TYPE*4; i++){
            if(neighborIndex[i] != -1 && !openList[neighborIndex[i]] && !closedList[neighborIndex[i]] && !obstacleCells[neighborIndex[i]] ){
                parentIndex[neighborIndex[i]] = step;
                openList[neighborIndex[i]] = true;
            }
        }
        openList[step] = false;
        closedList[step] = true;
        int nextAvailableIndex = -1;
        int i = 0;
        do {
            if(openList[i] ){
                nextAvailableIndex = i;
            }
            i++;
        } while (nextAvailableIndex == -1 && i < self.column*self.row);

        if(nextAvailableIndex == -1) {
            //            printf("\ncompleted. all reachable cells have been checked.\n");
            NSMutableArray *checked = [NSMutableArray array];
            for(int i = 0; i < self.column*self.row; i++)
                if(closedList[i])
                    [checked addObject:[self LocationFromIndex:i]];
            return checked;
        }
        step = nextAvailableIndex;
        iterations++;
    }
    printf("returning to prevent infinite loop, iterations got to %d\n",iterations);
    printf("if this failed too soon, get rid of the safety switch 'iterations'\n");
    return nil;
}

-(void) dealloc{
    free(obstacleCells);
    free(hValues);
    free(gValues);
    free(fValues);
    free(openList);
    free(closedList);
    free(parentIndex);
}

@end
