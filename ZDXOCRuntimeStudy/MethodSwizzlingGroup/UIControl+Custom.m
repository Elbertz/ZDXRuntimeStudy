//
//  UIControl+Custom.m
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/27.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import "UIControl+Custom.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic,assign) NSTimeInterval custom_acceptEventTime;//记录上一次点击的时间间隔

@end

@implementation UIControl (Custom)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSEL = @selector(sendAction:to:forEvent:);
        Method sysMethod = class_getInstanceMethod(self, sysSEL);
        
        SEL customSEL = @selector(custom_sendAction:to:forEvent:);
        Method customMethod = class_getInstanceMethod(self, customSEL);
        
        BOOL addmethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
        
        if (addmethod) {
            class_replaceMethod(self, customSEL, method_getImplementation(sysMethod), method_getTypeEncoding(sysMethod));
        } else {
            method_exchangeImplementations(sysMethod, customMethod);
        }
        
        
    });
}

//属性方法
-(void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    NSLog(@"%s---%d",__FUNCTION__,__LINE__);
    objc_setAssociatedObject(self, @selector(custom_acceptEventInterval), @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(NSTimeInterval)custom_acceptEventInterval{
    NSLog(@"%s---%d",__FUNCTION__,__LINE__);
    return [objc_getAssociatedObject(self, @selector(addObject:)) doubleValue];
}

-(void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    NSLog(@"%s---%d",__FUNCTION__,__LINE__);
    NSNumber *num = [NSNumber numberWithDouble:custom_acceptEventTime];
    objc_setAssociatedObject(self, @selector(custom_acceptEventTime), num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)custom_acceptEventTime{
    NSLog(@"%s---%d",__FUNCTION__,__LINE__);
    NSNumber *num = objc_getAssociatedObject(self, @selector(addObject:));
    return num.doubleValue;
}

/*
- (NSTimeInterval )custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
*/


#pragma - - 
-(void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    NSLog(@"%s---%d",__FUNCTION__,__LINE__);
    
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，会影响UISwitch,如果想统一设置，又不想影响UISwitch，建议将UIControl分类，改成UIButton分类，实现方法是一样的
    // if (self.custom_acceptEventInterval <= 0) {
    //     // 如果没有自定义时间间隔，则默认为2秒
    //    self.custom_acceptEventInterval = 2;
    // }
    
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = ([NSDate date].timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        
        self.custom_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
    
    
}






@end
