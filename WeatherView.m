/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherView.h"

@implementation WeatherView

@synthesize timeOfDay;

- (void) drawRect: (NSRect)dirtyRect {

  NSRect bounds = [self bounds];
  NSGradient *gradient;
  
  if([timeOfDay isEqualToString:@"day"]) {
    gradient = [WeatherGradients defaultGradient];
  } else {
    gradient = [WeatherGradients nightGradient];
  }
  
  [gradient drawInRect:bounds angle:90];  
  [super drawRect:bounds];
}

@end
