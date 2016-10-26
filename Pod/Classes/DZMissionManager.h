//
//  DZMissionManager.h
//  Pods
//
//  Created by stonedong on 16/10/25.
//
//

#import <Foundation/Foundation.h>

@class DZMissionTask;
@protocol DZMissionHandler;
@interface DZMissionManager : NSObject
+ (DZMissionManager*) shareActiveManger;
- (void) tryTriggleMission;
- (void) addMission:(DZMissionTask*)task;
- (void) registerHandler:(id<DZMissionHandler>)handler;
- (void) completeMissionByKey:(NSString*)key;
@end
