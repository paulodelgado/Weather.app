/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherView.h"

@implementation WeatherView

@synthesize timeOfDay;

- (void) drawRect: (NSRect)rect {
/*
  NSRect bounds = [self frame];
  
  NSGradient *gradient;
  
  if([timeOfDay isEqualToString:@"day"]) {
    gradient = [WeatherGradients defaultGradient];
  } else {
    gradient = [WeatherGradients nightGradient];
  }
  
  [gradient drawInRect:bounds angle:90];  
  */
}

- (void) reDraw {
}

@end
