/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherWindow.h"

@implementation WeatherWindow

- (void) setBackgroundColor:(NSColor *)bgColor {
  [self setAlphaValue:0.5];
  NSLog(@"setting background color with %@", bgColor);
  ASSIGN(_backgroundColor, nil);
  [_wv setBackgroundColor: nil];
  
  NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor orangeColor] endingColor:[NSColor lightGrayColor]];
  NSRect windowFrame = [self frame];
  [gradient drawInRect:windowFrame angle:90];
} 

- (void)drawRect {
  NSLog(@"drawing window rect");

}

@end
