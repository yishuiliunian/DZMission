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
/*
 * Share Instance For Mission Manager
 */
+ (DZMissionManager*) shareActiveManger;

/*
 * Try Triggle Missions, it will operate all mission that opened. and the remove the closed missions.
 */
- (void) tryTriggleMission;

/*
 * Add a mission to the center. And it will be cache at file that be seperated by account
 */
- (void) addMission:(DZMissionTask*)task;

/*
 * Register a handler to operate mission
 */
- (void) registerHandler:(id<DZMissionHandler>)handler;

/*
 * manualy complete a mission by key.  Key is the name of mission.
 */
- (void) completeMissionByKey:(NSString*)key;
@end
