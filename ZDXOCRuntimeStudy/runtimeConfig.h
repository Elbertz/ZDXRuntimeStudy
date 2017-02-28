//
//  runtimeConfig.h
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/27.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#ifndef runtimeConfig_h
#define runtimeConfig_h


#endif /* runtimeConfig_h */


/*
 （1）使用class_replaceMethod/class_addMethod函数在运行时对函数进行动态替换或增加新函数
 
 （2）重载forwardingTargetForSelector，将无法处理的selector转发给其他对象
 
 （3）重载resolveInstanceMethod，从而在无法处理某个selector时，动态添加一个selector
 
 （4）使用class_copyPropertyList及property_getName获取类的属性列表及每个属性的名称
 
 (5) 使用class_copyMethodList获取类的所有方法列表
 
 (6) 总结
 
 
 相关函数：
 
 增加
 增加函数:class_addMethod
 增加实例变量:class_addIvar
 增加属性:@dynamic标签，或者class_addMethod，因为属性其实就是由getter和setter函数组成
 增加Protocol:class_addProtocol (说实话我真不知道动态增加一个protocol有什么用,-_-!!)
 
 
 获取
 获取函数列表及每个函数的信息(函数指针、函数名等等):class_getClassMethod method_getName ...
 获取属性列表及每个属性的信息:class_copyPropertyList property_getName
 获取类本身的信息,如类名等：class_getName class_getInstanceSize
 获取变量列表及变量信息：class_copyIvarList
 获取变量的值
 
 
 替换
 将实例替换成另一个类：object_setClass
 将函数替换成一个函数实现：class_replaceMethod
 直接通过char *格式的名称来修改变量的值，而不是通过变量
 
 
 method函数：
 1.SEL method_getName(Method m) 由Method得到SEL
 2.IMP method_getImplementation(Method m)  由Method得到IMP函数指针
 3.const char *method_getTypeEncoding(Method m)  由Method得到类型编码信息
 4.unsigned int method_getNumberOfArguments(Method m)获取参数个数
 5.char *method_copyReturnType(Method m)  得到返回值类型名称
 6.IMP method_setImplementation(Method m, IMP imp)  为该方法设置一个新的实现
 
 
 */
