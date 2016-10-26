//
//  DZMissionTask.m
//  Pods
//
//  Created by stonedong on 16/10/25.
//
//

#import "DZMissionTask.h"
#import <DateTools.h>
@implementation DZMissionTask

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _exclusive = NO;
    return self;

}
- (BOOL) opened
{
    if (!self.startDate) {
        return NO;
    }
    
    if (!self.endDate) {
        return NO;
    }

    if (![self.startDate isEarlierThan:self.endDate]) {
        return NO;
    }
    if (![self.endDate isLaterThan:[NSDate date]]) {
        return NO;
    }

    return YES;
}

@end
