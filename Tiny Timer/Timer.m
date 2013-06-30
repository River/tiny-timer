//
//  Timer.m
//  Reading Speed
//
//  Created by River Jiang on 12-08-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//  Basic timer class
//  Doesn't require a NSTimer that constantly updates; separates the timer functionality from the main interface loop
//  Make sure lapSecondsElapsed (the main method) is only called once per interface loop to avoid wasting resources
//  lapSecondsElapsed returns a NSTimeInterval, which is essentially an integer of seconds elapsed with some extra methods
//  Uses simple datetime arithmetic to keep track of time elapsed

#import "Timer.h"

@implementation Timer

//  Main methods to call: startTimer, pauseTimer, resetTimer to control the timer
//  secondsElapsed, formatTimeElapsed to check on the timer state

//  Starts and resumes the timer (after both pauses and resets)
- (void) startTimer {
    // make sure not to reset count when stopwatch is running
    if (!stopwatchRunning) {
        startDate = [NSDate date];
        stopwatchRunning = TRUE;
        lapTimeInterval = 0.0;
    }
}

//  Pauses timer but allows resumption later (keeps timer data)
- (void) pauseTimer {
    if (stopwatchRunning) {
        timeInterval += [self lapSecondsElapsed];
		lapTimeInterval = 0.0;
        stopwatchRunning = FALSE;
    }    
}

//  Stops the timer and resets timer data
- (void) resetTimer {
    stopwatchRunning = FALSE;
    startDate = nil;
    timeInterval = lapTimeInterval = 0.0;
}

- (bool) running {
	return stopwatchRunning;
}

//  Returns seconds elapsed since last resumption as NSTimeInterval; can be treated as a double
//  This is the main function that calculates the time elapsed; make sure this is only called once per second (any more is unnecessary)
- (NSTimeInterval) lapSecondsElapsed {
    if (stopwatchRunning) {
        NSDate *currentDate = [NSDate date];
        lapTimeInterval = [currentDate timeIntervalSinceDate:startDate];
        
        // make sure this is called only once per second to save resources
        // NSLog([NSString stringWithFormat:@"%f", lapTimeInterval]);
    }
    
    return lapTimeInterval;
}

//  Returns total seconds elapsed (excluding pauses) as NSTimeInterval; can be treated as a double
- (NSTimeInterval) secondsElapsed {
    [self lapSecondsElapsed]; // update lapTimeInterval
    return timeInterval + lapTimeInterval;
}

//  Formats time elapsed as "00:00:00"
- (NSString*) formatTimeElapsed: (NSTimeInterval)secondsElapsed {
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:secondsElapsed];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    return [dateFormatter stringFromDate:timerDate];
}

@end