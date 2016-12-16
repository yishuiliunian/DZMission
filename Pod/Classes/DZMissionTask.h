//
//  DZMissionTask.h
//  Pods
//
//  Created by stonedong on 16/10/25.
//
//

#import <Foundation/Foundation.h>

@interface DZMissionTask : NSObject
@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;
@property (nonatomic, strong) NSString* name;
/*是否排他，当为YES的时候，当前任务队列中只能存在唯一的一个该任务,默认为NO*/
@property (nonatomic, assign) BOOL exclusive;
@property (nonatomic, assign, readonly) BOOL opened;
/*任务相关信息，以Key-Value的形式承载*/
@property  (nonatomic, strong) NSDictionary * additions;
/*该任务被触发的时序列表*/
@property  (nonatomic, strong) NSArray * triggleDates;
@end
