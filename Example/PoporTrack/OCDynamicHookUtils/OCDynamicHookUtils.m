//
//  OCDynamicHookUtils.m
//  OCDynamicHookUtils
//
//  Created by renwei.chen on 2017/12/12.
//  Copyright © 2017年 YY.inc. All rights reserved.
//

#import "OCDynamicHookUtils.h"

#import <objc/message.h>

@implementation OCDynamicHookUtils

+(BOOL)SwizzleClass:(Class)destClass instanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector{
    Method originalMethod = class_getInstanceMethod(destClass, originalSelector);
    Method alternativeMethod = class_getInstanceMethod(destClass, newSelector);
    if(originalMethod==NULL||alternativeMethod==NULL){
        return NO;
    }

    if(class_addMethod(destClass, originalSelector, method_getImplementation(alternativeMethod), method_getTypeEncoding(alternativeMethod))) {
        class_replaceMethod(destClass, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, alternativeMethod);
    }
    return YES;
}

+(BOOL)SwizzleClass:(Class)destClass classMethod:(SEL)originalSelector withMethod:(SEL)newSelector{
    return [self SwizzleClass:object_getClass(destClass) instanceMethod:originalSelector withMethod:newSelector];
}

+(BOOL)AddClassMethod:(const char*)methodTypes toSelector:(SEL)selector implement:(IMP)imp toClass:(Class)destClass{
    return [self AddInstanceMethod:methodTypes toSelector:selector implement:imp toClass:object_getClass(destClass)];
}

+(BOOL)AddInstanceMethod:(const char*)methodTypes toSelector:(SEL)selector implement:(IMP)imp toClass:(Class)destClass{
    return class_addMethod(destClass, selector, imp, methodTypes);
}

+(BOOL)AddHookInstanceMethodImp:(OCDynamicHookUtilsImpCallback)callback toClass:(Class)destaClass toReplaceSelector:(SEL)selector{
    if(destaClass == NULL || callback == NULL || selector == NULL){
        return NO;
    }
    Method originMethod = class_getInstanceMethod(destaClass, selector);
    NSString *originSelectorName = NSStringFromSelector(selector);
    NSString *replaceSelectorName = [NSString stringWithFormat:@"%@_%@",@"rep",originSelectorName];
    SEL repSelector = NSSelectorFromString(replaceSelectorName);
    for(int i=1;[destaClass respondsToSelector:repSelector];i++){
        replaceSelectorName = [NSString stringWithFormat:@"%@%d_%@",@"rep",i,originSelectorName];
        repSelector = NSSelectorFromString(replaceSelectorName);
    }
    IMP imp = imp_implementationWithBlock(callback);

    if(!class_addMethod(destaClass, repSelector, imp , method_getTypeEncoding(originMethod))){
        return NO;
    }
    [self SwizzleClass:destaClass instanceMethod:selector withMethod:repSelector];
    return YES;
}

+(BOOL)AddHookInstanceMethodImp:(OCDynamicHookUtilsImpCallback)callback toClassName:(NSString*)className toReplaceSelectorName:(NSString*)selectorName{
    if(className==nil || selectorName==nil){
        return NO;
    }
    return [self AddHookInstanceMethodImp:callback toClass:NSClassFromString(className) toReplaceSelector:NSSelectorFromString(selectorName)];
}

+(BOOL)AddHookClassMethodImp:(OCDynamicHookUtilsImpCallback)callback toClassName:(NSString*)className toReplaceSelectorName:(NSString*)selectorName{
    if(className==nil || selectorName==nil){
        return NO;
    }
    Class aClass = NSClassFromString(className);
    SEL selector = NSSelectorFromString(selectorName);
    if(aClass==nil ){
        return NO;
    }
    return [self AddHookInstanceMethodImp:callback toClass:object_getClass(aClass) toReplaceSelector:selector];
}


@end
