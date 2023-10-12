/* All rights reserved */

#include <AppKit/AppKit.h>
#import "LocationAndWeatherData.h"
#import "WeatherGradients.h"

@interface WeatherView : NSView
{
}

@property (nonatomic, retain) LocationAndWeatherData *locationAndWeatherData;

@end
