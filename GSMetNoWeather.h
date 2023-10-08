/*
   Project: MetNoWeather

   Copyright (C) 2023 Free Software Foundation

   Author: Paulo Delgado

   Created: 2023-10-05 by Paulo Delgado

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

#import "WebServices/GWSService.h"

#ifndef _GNUSTEP_MET_NO_WEATHER_H_
#define _GNUSTEP_MET_NO_WEATHER_H_

#import <Foundation/Foundation.h>

@interface GSMetNoWeather : NSObject
{
}

- (NSString *) locationForecastURL:(double) latitude
                         longitude:(double) longitude;
- (void)fetchWeatherDataForLatitude:(double)latitude
    longitude:(double)longitude
    completionHandler:(void (^)(NSDictionary *weatherData, NSError *error))completionHandler;

@end

#endif // _GNUSTEP_MET_NO_WEATHER_H_
