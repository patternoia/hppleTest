//
//  Schedule.h
//  hppletest
//
//  Created by Evgeny Lavrik on 9/21/11.
//  Copyright 2011 Sitronics Telecom Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebParser : NSObject

+ (NSArray*)getScheduleByURL:(NSString*) url;
+ (NSArray*)getNewsByURL:(NSString*) url;
@end
