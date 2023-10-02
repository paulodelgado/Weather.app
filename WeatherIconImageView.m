/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherIconImageView.h"

@implementation WeatherIconImageView

- (void) drawRect:(NSRect) dirtyRect {
  NSRect bounds = [self bounds];  


  // Clip the drawing to a rounded rectangle with a corner radius
  NSBezierPath *clipPath = [NSBezierPath bezierPathWithRoundedRect:bounds xRadius:10.0 yRadius:10.0];
  [clipPath addClip];
  
  // First, draw a white background with 50% opacity
  [[NSColor colorWithCalibratedWhite:1.0 alpha:0.1] set];
  NSRectFill(bounds);


  [super drawRect:bounds];
}

@end
