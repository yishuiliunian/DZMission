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
- (void) handleMission:(DZMissionTask*)mission willComplete:(BOOL*)complete;
@end
