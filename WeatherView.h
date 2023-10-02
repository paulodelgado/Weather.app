/* All rights reserved */

#include <AppKit/AppKit.h>
#import "WeatherGradients.h"

@interface WeatherView : NSView
{
  NSString *timeOfDay;
}


@property (nonatomic, retain) NSString *timeOfDay;

@end
