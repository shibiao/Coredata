# Coredata
##通过第三方库MagicalRecord写简单实现CoreData数据库文件的操作
####1.先下载第三方库[MagicalRecord](https://github.com/magicalpanda/MagicalRecord),创建项目前勾选Coredata
2.然后将第三方库文件拖入项目文件夹内如下图
####![1](https://github.com/shibiao/Coredata/blob/master/images/QQ20160429-1.png)
在将MagicalRecord框架导入项目
![2](https://github.com/shibiao/Coredata/blob/master/images/QQ20160429-2.png)
####3.操作完毕后进入coredata model文件中添加表
![3](https://github.com/shibiao/Coredata/blob/master/images/QQ20160429-3.png)

MagicalRecord中简易调用接口方法
<pre><code>
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
</code></pre>
