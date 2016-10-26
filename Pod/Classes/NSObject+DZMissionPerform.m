//
//  NSObject+DZMissionPerform.m
//  Pods
//
//  Created by baidu on 16/10/26.
//
//

#import "NSObject+DZMissionPerform.h"
#import <objc/runtime.h>
static void * DZMissionOperating__ = &DZMissionOperating__;
@implementation NSObject (DZMissionPerform)

- (void) setOperatingMissionDZ:(DZMissionTask *)operatingMissionDZ
{
    objc_setAssociatedObject(self, DZMissionOperating__, operatingMissionDZ, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DZMissionTask*) operatingMissionDZ
{
    return objc_getAssociatedObject(self, DZMissionOperating__);
}
@end
