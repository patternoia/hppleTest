//
//  Day.m
//  hppletest
//
//  Created by Evgeny Lavrik on 9/21/11.
//  Copyright 2011 Sitronics Telecom Solutions. All rights reserved.
//

#import "Day.h"

@implementation Day
@synthesize day;
@synthesize events;

- (id)initWithDay: (NSUInteger)aDay
{
    self = [super init];
    if (self) {
        day = aDay;
        events = [[NSMutableArray alloc] init];
        // Initialization code here.
    }
    
    return self;
}



@end
