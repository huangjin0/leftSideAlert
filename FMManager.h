//
//  FMManager.h
//  Alarm1
//
//  Created by huangjin on 16/2/22.
//  Copyright © 2016年 zhixun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMManager : NSObject
+(id)shareInstance;
-(void)insertAlarmForLocalBase;
-(void)deleteAlarmForLocalBase;
-(void)alertAlarmForLocalBase;
-(void)queryAlarmforLocalBase;

@end
