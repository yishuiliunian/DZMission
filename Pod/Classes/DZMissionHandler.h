//
//  DZMissionHandler.h
//  Pods
//
//  Created by stonedong on 16/10/25.
//
//

#import <Foundation/Foundation.h>

@class DZMissionTask;

/*
 * the mission handler delegate, it will be store at DZMissionManager. and operation the mission.
 */
@protocol DZMissionHandler <NSObject>

- (void) handleMission:(DZMissionTask*)mission willComplete:(BOOL*)complete;
@end
