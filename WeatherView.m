/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherView.h"

@implementation WeatherView

- (void) drawRect: (NSRect)rect {
  NSGradient *gradient = [WeatherGradients defaultGradient];
  [gradient drawInRect:rect angle:90];
}


@end
