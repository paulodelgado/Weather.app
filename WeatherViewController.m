/* All rights reserved */

#ifndef _WEATHERVIEWCONTROLLER_H
#define _WEATHERVIEWCONTROLLER_H

#include "WeatherViewController.h"

@implementation WeatherViewController

@synthesize locationAndWeatherData;

- (id) init {
  NSLog(@"WeatherViewController#init");
  if ((self = [super init])) {
    NSLog(@"init");
    [self initView];
  }
  return self;
}

- (void) initView {
  NSLog(@"WeatherViewController#initView");
  NSNib *nib = [[NSNib alloc] initWithNibNamed:@"WeatherView" bundle:nil];
  NSArray *topLevelObjects;
  if([nib instantiateNibWithOwner:self topLevelObjects:&topLevelObjects]) {
    NSLog(@"instantiateNibWithOwner");
    for(id topLevelObject in topLevelObjects) {
      NSLog(@"topLevelObject is %@", topLevelObject);
      if([topLevelObject isKindOfClass:[WeatherView class]]) {
        NSLog(@"topLevelObject is WeatherView");
        self.view = topLevelObject;
        break;
      }
    }
  }
}

- (void) syncView {
}

@end

#endif // _WEATHERVIEWCONTROLLER_H
