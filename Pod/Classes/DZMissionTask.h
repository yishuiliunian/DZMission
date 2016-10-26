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
@property (nonatomic, assign) BOOL exclusive;
@property (nonatomic, assign, readonly) BOOL opened;
@end
