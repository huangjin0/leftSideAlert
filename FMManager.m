//
//  FMManager.m
//  Alarm1
//
//  Created by huangjin on 16/2/22.
//  Copyright © 2016年 zhixun. All rights reserved.
//

#import "FMManager.h"
#import  "FMDB.h"
#import "AlarmManager.h"

@interface FMManager()
{
    FMDatabase *_db;
}

@end
@implementation FMManager
#pragma mark--
#pragma mark Public Methond
+(id)shareInstance
{
       static FMManager*obj=nil;
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            
            obj=[[self alloc]init];
            
        });
        
        return self;
}
#pragma mark --init
-(id)init
{
    if (self=[super init]) {
        
        [self initDataBase];
    }
    return self;

}
-(void)initDataBase
{
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString*directory=[paths objectAtIndex:0];
    
    NSString *dbPath = [directory stringByAppendingString:@"/alarm.db"];// @"/tmp/tmp.db";
    
    // delete the old db.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:dbPath error:nil];
    
    NSLog(@"path:%@",dbPath);
    _db = [FMDatabase databaseWithPath:dbPath];
    if (_db==nil) {
        NSLog(@"创建数据库失败");
    }
    if ([_db open]==NO) {
        
        NSLog(@"Could not open db.");
       return;
        
    }else {
        
       //创建数据表
        bool result=[_db executeQuery:@"create table if not exists AlarmList (alarmID text, time text, enable integer,music blob,volume double,snnoze integer,enableVibration integer,enableIR integer,timeIR integer,enableTR integer,timeTR integer)"];
        if (result==NO) {
            NSLog(@"创建数据表失败");
            return;
        }
        
    }
}

-(void)insertAlarmForLocalBase:(AlarmManager*)obj

{
    [_db beginTransaction];
    [_db executeUpdate:@"insert into AlarmList values ('alarmID', 'time','enable','music','volume','snnoze','enableVibration','enableIR','timeIR','enableTR','timeTR') values (?,?,?,?,?,?,?,?,?,?,?)"];
    [_db commit];

}

-(void)deleteAlarmForLocalBaseL:(NSString*)alarmID;
{
    //delete from testTable  where testID = ?
    [_db beginTransaction];
    [_db executeUpdate:@"delete from testTable  where testID = ?"];
    [_db commit];



}
-(void)alertAlarmForLocalBase
{
    FMResultSet*rs = [_db executeQuery:@"select * from t3"];
    while ([rs next]) {
        int foo = [rs intForColumnIndex:0];
        
        int newVal = foo + 100;
        
        [_db executeUpdate:@"update t3 set a = ? where a = ?" , [NSNumber numberWithInt:newVal], [NSNumber numberWithInt:foo]];
        
        
        FMResultSet *rs2 = [_db executeQuery:@"select a from t3 where a = ?", [NSNumber numberWithInt:newVal]];
        [rs2 next];
        
        if ([rs2 intForColumnIndex:0] != newVal) {
            NSLog(@"Oh crap, our update didn't work out!");
            
        }
        
        [rs2 close];
    }


}
-(void)queryAlarmforLocalBase:(NSString*)alarmID
{
    
    FMResultSet *rs = [_db executeQuery:@"select rowid,* from test where a = ?", @"hi'"];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        NSLog(@"%d %@ %@ %@ %@ %f %f",
              [rs intForColumn:@"c"],
              [rs stringForColumn:@"b"],
              [rs stringForColumn:@"a"],
              [rs stringForColumn:@"rowid"],
              [rs dateForColumn:@"d"],
              [rs doubleForColumn:@"d"],
              [rs doubleForColumn:@"e"]);
        
        
        if (!([[rs columnNameForIndex:0] isEqualToString:@"rowid"] &&
              [[rs columnNameForIndex:1] isEqualToString:@"a"])
            ) {
            NSLog(@"WHOA THERE BUDDY, columnNameForIndex ISN'T WORKING!");
        }
    }
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.
    [rs close];


}




@end
