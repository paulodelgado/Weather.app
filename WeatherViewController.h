/* All rights reserved */

#import <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#import "LocationAndWeatherData.h"
#import "WeatherView.h"

@interface WeatherViewController : NSViewController
{
  IBOutlet NSTextField *temperatureField;
  IBOutlet NSTextField *locationField;
  IBOutlet NSTextField *pressureField;
  IBOutlet NSTextField *humidityField;
  IBOutlet NSTextField *windSpeedField;

}

@property (nonatomic, retain) LocationAndWeatherData *locationAndWeatherData;

- (void)syncView;

@end
