//
//  ViewController.m
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/23.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setFrame:CGRectMake(20, 10, 80, 50)];
    [button1 setTitle:@"test Runtime" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(handleButton1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    [self runtimeFromTransProsAndMethodsOfClassToModel];
    
    
    [self isOrNotSomeClass_OC];
    //[self isOrNotSomeClass_Runtime];
    
    [self getInstanceVariableOfSomeclass];
    
}

- (void)handleButton1Action:(UIButton *)sender{
    NSLog(@"handleButton1Action");
}

void anotherAction(id self, SEL _cmd){
    NSLog(@"11111111111");
}

//该方法在OC消息转发生效前被调用
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(handleButton1Action:)) {
        //向[self class]中新加入返回为void的实现，SEL名字为aSEL，实现的具体内容为dynamicMethodIMP
        //class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, “v@:”);
        
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


#pragma - -
//runtime 动态获取某个类的属性或者函数等，可以用来做很多事情，如json 解析、数据库结果解析、判断某个类的子类等

//1.解析、转化为Model
- (void)runtimeFromTransProsAndMethodsOfClassToModel{
    unsigned int outCount,i;
    objc_property_t *properties = class_copyPropertyList([Person class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        //获取属性类型等参数
        NSString *proprtyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        NSLog(@"%d %@--%@",i,propertyName,proprtyType);
        //unsigned 无符号的数值类型对应类型是大写，as TC、TI、TS等
        /*
        0 aChar--Tc,N,V_aChar
        1 aInt--Ti,N,V_aInt
        2 aShort--Ts,N,V_aShort
        3 aLong--Tq,N,V_aLong
        4 aLLong--Tq,N,V_aLLong
        5 aFloat--Tf,N,V_aFloat
        6 aDouble--Td,N,V_aDouble
        7 aBool--TB,N,V_aBool
        8 aString--T@"NSString",&,N,V_aString
        9 aMString--T@"NSMutableString",&,N,V_aMString
        10 aArray--T@"NSArray",&,N,V_aArray
        11 aMArray--T@"NSMutableArray",&,N,V_aMArray
        12 aDictionary--T@"NSDictionary",&,N,V_aDictionary
        13 aMDictionary--T@"NSMutableDictionary",&,N,V_aMDictionary
        14 aLabel--T@"UILabel",&,N,V_aLabel
        15 aButton--T@"UIButton",&,N,V_aButton
        16 aView--T@"UIView",&,N,V_aView
        */
        
        
        
        //要判断某个属性的类型，只需要[propertyType hasPrefix:@"Ti"]
        //这代表它是不是 int 类型
        BOOL bResult = [proprtyType hasPrefix:@"Ti"];
        if (bResult) {
            NSLog(@"%@ is int type",propertyName);
        } else {
            NSLog(@"%@ is not int type",propertyName);
        }
        
    }
    
    //千万不要忘记释放
    free(properties);
    
}


//2.判断某个类的子类
- (void)isOrNotSomeClass_OC{
    if ([Person superclass] == [NSObject class]) {
        NSLog(@"Person's superclass is NSObject");
    } else {
        NSLog(@"Person's superclass is not NSObject");
    }
    
    if (class_getSuperclass([Person class]) == [NSObject class]) {
        NSLog(@"class_getSuperclass(Person) is NSObject");
    } else {
        NSLog(@"class_getSuperclass(Person) is not NSObject");
    }
    
}
- (void)isOrNotSomeClass_Runtime{
    int numClasses;
    numClasses = objc_getClassList(NULL, 0);
    
    Class *classes = NULL;
    
    if (numClasses > 0) {
        //申请numClasses个Classc的内存
        classes = (__unsafe_unretained Class*)malloc(sizeof(Class)*numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            if (class_getSuperclass(classes[i]) == [NSObject class]) {
                id class = classes[i];
                
                //执行某个方法 或者 做其他事情
                //[class performSelector:@selector(fffff) withObject:nil];
                
                NSLog(@"%d--%@",i,class);
            }
            
        }
        
        free(classes);
    }
    
}
- (void)fffff{
    
}

//3.获取某个类的实例变量
- (void)getInstanceVariableOfSomeclass{
    unsigned int outCount,i;
    
    Ivar *ivaries = class_copyIvarList([Person class], &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar ivar = ivaries[i];
        
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
        
        NSLog(@"%d--名称:%@--类型：%@",i,ivarName,ivarType);
    }
    
    
    free(ivaries);

}

//4.获取某个类的方法
- (void)getMethodFormClass{
    unsigned int outMethodCount,i;
    Method *methods = class_copyMethodList([Person class], &outMethodCount);
    
    for (i = 0; i < outMethodCount; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        
        if (selector) {
            NSString *methodsName = [NSString stringWithCString:sel_getName(selector) encoding:NSUTF8StringEncoding];
            
            NSLog(@"方法:%@",methodsName);
        }
        
    }
    
    free(methods);
}


//4.运行时动态创建一个类
//来创建一个MyClass 类。项目中并不存在叫MyClass 的类文件
- (void)createClass{
    Class MyClass = objc_allocateClassPair([NSObject class], "MyClass", 0);
    //1.添加一个叫name 类型为NSString的实例变量，第四个参数是对其方式，第五个参数是参数类型
    if (class_addIvar(MyClass, "name", sizeof(NSString *), 0, "@")) {
        NSLog(@"add ivar success");
    }
    
    // 2.添加一个property
    // 这里需要注意，添加property之前需要先添加一个与之对应的实例变量
    if (class_addIvar(MyClass, "_address", sizeof(NSString *), 0, "@")) {
        NSLog(@"add ivar success");
    }
    objc_property_attribute_t type = {"T","@\"NSString\""};
    objc_property_attribute_t ownership = {"C",""};
    objc_property_attribute_t backingivar = {"V","_address"};
    objc_property_attribute_t attrs[] = {type,ownership,backingivar};
    class_addProperty(MyClass, "address", attrs, 2);
    
    //3.添加函数， myclasstest是已经实现的函数，"v@:"这种写法见参数类型连接
    class_addMethod(MyClass, @selector(myclasstest:), (IMP)myclasstest, "v@:");
    // 4.注册这个类到runtime系统中就可以使用他了
    objc_registerClassPair(MyClass);
    
    //5.生成了一个实例化对象
    id myobj = [[MyClass alloc]init];
    NSString *str = @"name";
    
    // 6.给刚刚添加的变量赋值
    //    object_setInstanceVariable(myobj, "itest", (void *)&str);在ARC下不允许使用
    [myobj setValue:str forKey:@"name"];
    [myobj setValue:@"address is Earth" forKey:@"address"];
    
    //7.调用myclasstest方法，也就是给myobj这个接受者发送myclasstest这个消息
    [myobj myclasstest:10];
    
    
    
    
}

//这个方法实际上没有被调用,但是必须实现否则不会调用下面的方法
- (void)myclasstest:(int)a
{
    NSLog(@"啊啊啊啊啊");
}

//调用的是这个方法
static void myclasstest(id self, SEL _cmd, int a) //self和_cmd是必须的，在之后可以添加其他参数
{
    Ivar v = class_getInstanceVariable([self class], "name");
    //返回名为name的ivar的变量的值
    id o = object_getIvar(self, v);
    //成功打印出结果
    NSLog(@"name is %@", o);
    NSLog(@"参数 a is %d", a);
    
    
    objc_property_t property = class_getProperty([self class], "address");
    NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
    id value = [self valueForKey:propertyName];
    NSLog(@"address is %@", value);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
