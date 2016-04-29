//
//  ViewController.m
//  MGR
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 shibiao. All rights reserved.
//

#import "ViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSHomeDirectory());

    [self mgicalRecord];
}
-(void)mgicalRecord
{
    //1.初始化MagicalRecord,一般放在程序启动的地方
    [MagicalRecord setupCoreDataStack];
    
    //2.开始操作coredata
    [self insert];
    [self update];
    [self delete];
    [self select];
    
    
    //3.结束的时候需要清理对象,一般放在程序结束的地方
    [MagicalRecord cleanUp];
}
- (void)select
{
    // 4.查询
    NSArray *result = [Person MR_findAllSortedBy:@"age" ascending:YES];//查询所有,根据age排序
    NSLog(@"%@",result);
    [Person MR_findAll]; //查找所有
    [Person MR_findFirst]; //查询第一个
    NSPredicate *p = [NSPredicate predicateWithFormat:@"age = %ld", 18];
    [Person MR_findAllWithPredicate:p];//根据条件查询
    [Person MR_findAllSortedBy:@"age" ascending:YES withPredicate:p];//根据条件查询，结果按照age排序
}

- (void)delete
{
    // 3.删除
    NSPredicate *pe2 = [NSPredicate predicateWithFormat:@"name = %@", @"李四"];
    [Person MR_deleteAllMatchingPredicate:pe2];
    //保存
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context MR_saveToPersistentStoreAndWait];
}

- (void)update
{
    
    // 2.修改
    //  a)先查找
    NSPredicate *pe1 = [NSPredicate predicateWithFormat:@"name = %@", @"张三"];
    NSArray *result = [Person MR_findAllWithPredicate:pe1];
    
    Person *p2 = [result firstObject];
    p2.name = @"李四";
    
    NSLog(@"%ld", result.count);
    //保存
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context MR_saveToPersistentStoreAndWait];
    
}

- (void)insert
{
    // 1.插入
    
    Person *p1 = [Person MR_createEntity];
    p1.name = @"张三";
    p1.age = @(18);
    
    //保存
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    [context MR_saveToPersistentStoreAndWait];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
