//
//  main.m
//  SpeechCounter
//
//  Created by Daniel Payne on 12/04/2013.
//  Copyright (c) 2013 o2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        static NSInteger count = 0;
        NSArray *voices = [NSSpeechSynthesizer availableVoices];
        NSSpeechSynthesizer *syn = [[NSSpeechSynthesizer alloc]initWithVoice:[voices objectAtIndex:2]];
        [syn setRate:300.0];
        
        CFRunLoopTimerRef timer = CFRunLoopTimerCreateWithHandler(NULL, CFAbsoluteTimeGetCurrent(), 1.0, 0, 0, ^(CFRunLoopTimerRef timer){
            NSLog(@"count = %ld", (long)count);
            
            NSString *countString = [NSString stringWithFormat:@"%ld", (long)count];
            [syn startSpeakingString:countString];
            count++;
            if (count == 121)
                count = 1;
        });
        
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes);
        CFRunLoopRun();
    }
    return 0;
}

