//
//  Day.h
//  hppletest
//
//  Created by Evgeny Lavrik on 9/21/11.
//  Copyright 2011 Sitronics Telecom Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface Day : NSObject
@property (assign) NSUInteger day;
@property (assign) NSMutableArray *events;

- (id)initWithDay: (NSUInteger)aDay;
@end
