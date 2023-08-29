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
GWSService *service;


- (id) initWithToken:(NSString *) token
{
  self = [super init];
  if(self) {
    authToken = token;
  }
  return self;
}

- (void) initService
{
  service = [GWSService new];
}

- (LocationWeatherData *) fetchWeatherDataFor:(NSString *) location
{
  NSDictionary *result;
  service = [GWSService new];
  [service setURL: @"http://server/path"];
  [service setCoder: [GWSJSONCoder coder]];
  result = [service invokeMethod: @"method"
    parameters: [NSDictionary new]
         order: 0
       timeout: 30];;
  LocationWeatherData *data = [LocationWeatherData initWithDictionary:result];
  return data;
}

@end
