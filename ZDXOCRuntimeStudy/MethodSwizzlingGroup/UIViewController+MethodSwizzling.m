//
//  UIViewController+MethodSwizzling.m
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/24.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import "UIViewController+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (MethodSwizzling)


+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method(类方法), use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(ZDX_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledmethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledmethod), method_getTypeEncoding(swizzledmethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledmethod);
        }
        
    });
}


//-(void)viewWillAppear:(BOOL)animated{
//    NSLog(@"%p",__FUNCTION__);
//}

#pragma mark - Method Swizzling
-(void)ZDX_viewWillAppear:(BOOL)animated{
    NSLog(@"xxx_viewWillAppear: %@", self);
    // 在这里，我们可以发送一个消息到服务器，或者做其他事情等。
}

-(void)ZDX_viewWillDisappear:(BOOL)animated{
    
}




@end
