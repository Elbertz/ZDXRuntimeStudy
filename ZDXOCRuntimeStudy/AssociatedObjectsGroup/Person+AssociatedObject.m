//
//  Person+AssociatedObject.m
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/24.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import "Person+AssociatedObject.h"
#import <objc/runtime.h>

@implementation Person (AssociatedObject)

-(void)setAddress:(NSString *)address{
    objc_setAssociatedObject(self, @selector(address), address, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)address{
    return objc_getAssociatedObject(self, @selector(addObject:));
}
-(void)setHeight:(int)height{
    NSNumber *hegitNumber = [NSNumber numberWithInt:height];
    objc_setAssociatedObject(self, @selector(height), hegitNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(int)height{
    NSNumber *hegitNumber = objc_getAssociatedObject(self, @selector(addObject:));
    return hegitNumber.intValue;
}

@end
