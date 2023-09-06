/*
   Project: WeatherApi

   Copyright (C) 2023 Free Software Foundation

   Author: Paulo Delgado

   Created: 2023-08-28 20:47:59 -0700 by paulo

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "WeatherApi.h"
#import "WebServices/GWSService.h"


@implementation WeatherApi

NSString *authToken;

- (id) initWithToken:(NSString *) token {
  self = [super init];
  if(self) {
    authToken = token;
  }
  return self;
}

- (LocationWeatherData *) fetchWeatherDataFor:(NSString *) location {
  NSMutableDictionary *result;
  GWSService *service = [GWSService new];
  NSString *unescapedURL = [NSString stringWithFormat:@"https://api.weatherapi.com/v1/current.json?key=%@&q=%@", authToken, location];
  NSString *urlEndpoint = [unescapedURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [service setURL: urlEndpoint];
  [service setHTTPMethod:@"GET"];

  [service setCoder: [GWSJSONCoder coder]];

  result = [service invokeMethod:@"current.json"
    parameters: nil
         order: 0
       timeout: 30];
  NSDictionary *myResult = [result valueForKey:@"GWSCoderParameters"];
  NSDictionary *weatherData = [myResult valueForKey:@"Result"];
  LocationWeatherData *data = [[LocationWeatherData alloc] initWithDictionary:weatherData];
  return data;
}
@end