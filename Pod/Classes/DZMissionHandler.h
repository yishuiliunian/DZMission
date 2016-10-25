//
//  DZMissionHandler.h
//  Pods
//
//  Created by stonedong on 16/10/25.
//
//

#import <Foundation/Foundation.h>

@class DZMissionTask;
@protocol DZMissionHandler <NSObject>
- (BOOL) canHandleMission:(DZMissionTask*)mission;
- (void) handleMission:(DZMissionTask*)mission;
@end
