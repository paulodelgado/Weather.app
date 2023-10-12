/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherView.h"

@implementation WeatherView


- (void) drawRect: (NSRect)dirtyRect {
  NSRect bounds = [self bounds];
  NSString *timeOfDay = [[NSUserDefaults standardUserDefaults] stringForKey:@"timeOfDay"];
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
