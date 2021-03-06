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
#import "DZWeakProxy.h"
#import "DZMissionHandler.h"
@interface DZMissionManager ()
{
    NSMutableArray* _proxyCache;
}
@end


@implementation DZMissionManager
+ (DZMissionManager*) shareActiveManger
{
    return [[YHAccountData shareFactory] shareInstanceFor:[self class]];
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _proxyCache = [NSMutableArray new];
    return self;
}

- (DZFileCache*) fileCache
{
    DZCacheArrayModelCodec* codec = [[DZCacheArrayModelCodec alloc] initWithContainerClass:[DZMissionTask class]];
    return  [[DZAccountFileCache activeCache] fileCacheWithName:@"mission_cache" codec:codec];
}

- (void) handleMission:(DZMissionTask*)task
{
    for (NSObject<DZMissionHandler>* handler in _proxyCache) {
        if ([handler respondsToSelector:@selector(handleMission:willComplete:)]) {
            BOOL willStop = NO;
            if([handler handleMission:task willComplete:&willStop]) {
                NSMutableArray* dateSerial = [NSMutableArray arrayWithArray:task.triggleDates];
                [dateSerial addObject:[NSDate date]];
                task.triggleDates = dateSerial;
            }
            if (willStop) {
                task.endDate = [NSDate dateWithTimeInterval:-100 sinceDate:task.startDate];
            }
        }
    }
}

- (void) tryTriggleMission
{
    DZFileCache* fileCache = [self fileCache];
    NSArray* missions = fileCache.lastCachedObject;
    
    NSDate* date = [NSDate date];
    NSMutableArray* willGoonMissions = [NSMutableArray new];
    for (DZMissionTask* task  in missions) {
        //check task is opened ?
        if (!task.opened) {
            for(NSObject <DZMissionHandler>* handler in _proxyCache) {
                if ([handler respondsToSelector:@selector(handleMissionTriggleCompletion:)]) {
                    [handler handleMissionTriggleCompletion:task];
                }
            }
            continue;
        }
        //handle mission maybe complete the task
        [self handleMission:task];
        //check is the task opened again , if not it will be removed
        if (!task.opened) {
            continue;
        }
        [willGoonMissions addObject:task];
    }
    
    fileCache.lastCachedObject = willGoonMissions;
    NSError* error;
    //flush the file
    if(![fileCache flush:&error])
    {
        DDLogError(@"写入任务缓存 %@ error %@", fileCache.filePath ,error);
    }
}

- (void) addMission:(DZMissionTask*)task
{
    DZFileCache* fileCache = [self fileCache];
    NSMutableArray* array = [NSMutableArray arrayWithArray:fileCache.lastCachedObject];
    NSArray* oldArray = [array copy];
    for (DZMissionTask* m  in oldArray) {
        if ((task.exclusive || m.exclusive) && [m.name isEqualToString:task.name]) {
            [array removeObject:m];
        }
    }
    [array addObject:task];
    fileCache.lastCachedObject = array;
    NSError* error;
    if(![fileCache flush:&error])
    {
        DDLogError(@"写入任务缓存 %@ error %@", fileCache.filePath ,error);
    }
}

- (void) registerHandler:(id<DZMissionHandler>)handler
{
    if (!handler) {
        return;
    }
    [_proxyCache addObject:[DZWeakProxy proxyWithTarget:handler]];
}

- (void) completeMissionByKey:(NSString *)key
{
    DZFileCache* fileCache = [self fileCache];
    NSMutableArray* array = [NSMutableArray arrayWithArray:fileCache.lastCachedObject];
    NSArray* oldArray = [array copy];
    BOOL changed = NO;
    for (DZMissionTask* m  in oldArray) {
        if ( [m.name isEqualToString:key]) {
            for(NSObject <DZMissionHandler>* handler in _proxyCache) {
                if ([handler respondsToSelector:@selector(handleMissionTriggleCompletion:)]) {
                    [handler handleMissionTriggleCompletion:m];
                }
            }
            [array removeObject:m];
            changed = YES;
        }
    }
    if (!changed) {
        return;
    }

    NSError* error;
    fileCache.lastCachedObject = array;
    if(![fileCache flush:&error])
    {
        DDLogError(@"写入任务缓存失败 %@ error %@", fileCache.filePath ,error);
    }
}
@end
