/* All rights reserved */

#include <AppKit/AppKit.h>
#include "WeatherView.h"

@implementation WeatherView

- (id) initWithFrame: (NSRect)frame {
  if ((self = [super initWithFrame:frame])) {
    NSLog(@"initWithFrame");
  }
  return self;
}

- (id) initWithCoder: (NSCoder *)coder {
  if ((self = [super initWithCoder:coder])) {
    NSLog(@"initWithCoder");
  }
  return self;
}

- (void) awakeFromNib {
  NSLog(@"awakeFromNib");
}

- (void) drawRect: (NSRect)dirtyRect {
  NSLog(@"drawRect");
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
