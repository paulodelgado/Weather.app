/*
  Project MetNoWeather
*/

#import "GSMetNoWeather.h"


@implementation GSMetNoWeather

static NSString *const MET_NO_BASE_URL = @"https://api.met.no/weatherapi/";

- (NSString *) locationForecastURL:(float) latitude
                         longitude:(float) longitude {
  return [
    [NSString stringWithFormat:@"%@locationforecast/2.0/compact?lat=%f&long=%f", MET_NO_BASE_URL, latitude, longitude]
    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
  ];
}

- (NSDictionary *) locationForecast:(float) latitude
                          longitude:(float) longitude {

  NSMutableDictionary *result;
  GWSService *service = [GWSService new];
  [service setURL: [self locationForecastURL:latitude longitude:longitude]];
  [service setHTTPMethod:@"GET"];

  [service setCoder: [GWSJSONCoder coder]];

  result = [service invokeMethod:@"locationforecast"
    parameters: nil
         order: 0
       timeout: 30];
  NSDictionary *myResult = [result valueForKey:@"GWSCoderParameters"];
  NSDictionary *weatherData = [myResult valueForKey:@"Result"];
  return weatherData;
}
@end
