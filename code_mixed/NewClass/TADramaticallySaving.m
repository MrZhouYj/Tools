//
//  TADramaticallySaving.m
//  JLGP
//
//  Copyright © 2019 CA. All rights reserved.
//

#import "TADramaticallySaving.h"

@implementation TADramaticallySaving

@synthesize dbQueue = _dbQueue;
static TADramaticallySaving *tool_database = nil;
//单例
+ (instancetype)shareFMDBDatabase
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        tool_database = [[self alloc] init] ;
    }) ;
    return tool_database;
}

//创建数据库保存路径
+ (NSString *)dbPath
{
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"cadex.sqlite"];
    return dbpath;
}
//创建多线程安全的数据库
- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPath]];
    }
    return _dbQueue;
}

@end
