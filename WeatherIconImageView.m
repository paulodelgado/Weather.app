/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherIconImageView.h"

@implementation WeatherIconImageView

- (void) setImage: (NSImage *)image {
  [super setImage:image];
  [self setNeedsDisplay:YES];
}

@end
