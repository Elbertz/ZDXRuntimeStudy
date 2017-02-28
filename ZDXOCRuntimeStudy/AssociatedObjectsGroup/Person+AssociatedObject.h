//
//  Person+AssociatedObject.h
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/24.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import "Person.h"

@interface Person (AssociatedObject)

/** 家庭住址 */
@property (copy, nonatomic)NSString *address;
/** 身高 */
@property (assign, nonatomic)int height;

@end
