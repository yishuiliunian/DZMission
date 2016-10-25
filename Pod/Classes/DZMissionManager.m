//
//  DZMissionManager.m
//  Pods
//
//  Created by stonedong on 16/10/25.
//
//

#import "DZMissionManager.h"
#import "DZAccountFileCache.h"
#import "YHAccountData.h"
#import "DZMissionTask.h"
#import <DateTools.h>
#import "DZLogger.h"
@implementation DZMissionManager
+ (DZMissionManager*) shareActiveManger
{
    return [[YHAccountData shareFactory] shareInstanceFor:[self class]];
}

- (DZFileCache*) fileCache
{
    DZCacheArrayModelCodec* codec = [[DZCacheArrayModelCodec alloc] initWithContainerClass:[DZMissionTask class]];
    return  [[DZAccountFileCache activeCache] fileCacheWithName:@"mission_cache" codec:codec];
}

- (void) tryTriggleMission
{
    DZFileCache* fileCache = [self fileCache];
    NSArray* missions = fileCache.lastCachedObject;
    
    NSDate* date = [NSDate date];
    NSMutableArray* willGoonMissions = [NSMutableArray new];
    for (DZMissionTask* task  in missions) {
        if (!task.startDate) {
            continue;
        }
        if (!task.endDate) {
            continue;
        }
        if ([task.startDate isEarlierThan:task.endDate]) {
            continue;
        }
        if ([task.endDate isEarlierThan:date]) {
            continue;
        }
        [willGoonMissions addObject:task];
    }
    
    fileCache.lastCachedObject = willGoonMissions;
    NSError* error;
    if(![fileCache flush:&error])
    {
        DDLogError(@"写入任务缓存 %@ error %@", fileCache.filePath ,error);
    }
}

- (void) addMission:(DZMissionTask*)task
{
    DZFileCache* fileCache = [self fileCache];
    NSMutableArray* array = [NSMutableArray arrayWithArray:fileCache.lastCachedObject];
    [array addObject:task];
}

- (void) registerHandler:(id<DZMissionHandler>)handler
{
    
}
@end
