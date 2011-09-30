//
//  Schedule.m
//  hppletest
//
//  Created by Evgeny Lavrik on 9/21/11.
//  Copyright 2011 Sitronics Telecom Solutions. All rights reserved.
//

#import "WebParser.h"
#import "Day.h"
#import "Event.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "News.h"

@interface WebParser (hidden)

+ (Event*)getEventFromElements:(NSArray *)elements withPosition:(NSUInteger) position;

@end

@implementation WebParser

+ (NSArray*)getScheduleByURL:(NSString*) url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements  = [xpathParser searchWithXPathQuery:@"//div[@class='dayCell'] | //div[@class='dayItem']/b | //div[@class='dayItem']/sup/u"];
    
    for (id element in elements) {
        NSLog(@"%@", element);
    }
    
    NSMutableArray *days = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < [elements count]; i++)
    {
        if ((i + 2) > [elements count])
            break;
        if([[[elements objectAtIndex:i] tagName] isEqualToString:@"div"])
        {
            Day *day = [[[Day alloc] initWithDay:(uint)[[[elements objectAtIndex:i]content] doubleValue]] autorelease];
            [days addObject:day];
            int offset = 0;
            while(([[[elements objectAtIndex:i + offset + 1] tagName] isEqualToString:@"b"]))
            {
                Event *event = [self getEventFromElements:elements withPosition:i + offset];
                [day.events addObject:event];
                offset += 4;
                
                if ((i + 2 + offset) > [elements count])
                    break;
            }
            
            i += offset;
        }
    }
    
    [xpathParser release];
    
    return days;
}

+ (Event*)getEventFromElements:(NSArray *)elements withPosition:(NSUInteger) position
{
    Event *event = [[[Event alloc] init] autorelease];
    event.startTime = [NSString stringWithFormat:@"%@:%@", [[elements objectAtIndex:position+1] content], [[elements objectAtIndex:position+2] content]];
    event.endTime = [NSString stringWithFormat:@"%@:%@", [[elements objectAtIndex:position+3] content], [[elements objectAtIndex:position+4] content]];
    
    return event;
}

+ (NSArray*)getNewsByURL:(NSString*) url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements  = [xpathParser searchWithXPathQuery:@"//div[@class='blogdate'] | //div[@class='blogtext']/a"];
    
    NSMutableArray* news = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i < [elements count]; i+=2)
    {
        if ((i + 2) > [elements count])
            break;
        
        News* item = [[[News alloc] init] autorelease];
        item.head = [[elements objectAtIndex:i] content];
        item.body = [[elements objectAtIndex:i+1] content];
        item.href = [url stringByAppendingString:[[[elements objectAtIndex:i+1] attributes] valueForKey:@"href"]];
        
        [news addObject:item];
    }
    
    [xpathParser release];
    
    return news;
}

@end
