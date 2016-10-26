//
//  DZWeakProxy.h
//  Pods
//
//  Created by baidu on 16/10/26.
//
//

#import <Foundation/Foundation.h>

/*
 * the weak proxy for any object, if you send a SEL to it, it will transform the SEL to target
 */

@interface DZWeakProxy : NSObject
/**
 The proxy target.
 */
@property (nullable, nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;
@end
