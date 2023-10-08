/*
  Project MetNoWeather
*/

#import "GSMetNoWeather.h"


@implementation GSMetNoWeather

static NSString *const MET_NO_BASE_URL = @"https://api.met.no/weatherapi/";

- (NSString *) locationForecastURL:(double) latitude
                         longitude:(double) longitude {
  return [
    [NSString stringWithFormat:@"%@locationforecast/2.0/compact?lat=%f&long=%f", MET_NO_BASE_URL, latitude, longitude]
    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
  ];
}

- (void)fetchWeatherDataForLatitude:(double)latitude longitude:(double)longitude completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {
    NSString *urlString = [self locationForecastURL:latitude longitude:longitude];

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }

        NSError *jsonError;
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completionHandler(nil, jsonError);
        } else {
            completionHandler(weatherData, nil);
        }
    }];

    [task resume];
}
@end
