/*
Project: Weather

Copyright (C) 2023 Free Software Foundation

Author: Paulo Delgado

Created: 2023-08-25 17:25:06 -0700 by paulo

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

#import "LocationWeatherData.h"

@implementation LocationWeatherData
NSDictionary *current;
NSDictionary *location;

- (id) initWithDictionary:(NSDictionary *) dict {
  self = [super init];
  if(self) {
    [self setCurrent:[dict valueForKey:@"current"]];
    [self setLocation: [dict valueForKey:@"location"]];
  }
  return self;
}

- (NSString *) temperature {
  BOOL useMetricSystem = [[ConfigManager defaultManager] getUseMetricSystem];
  NSString *key = useMetricSystem ? @"temp_c" : @"temp_f";
  NSString *temperatureString = [current valueForKey:key];
  float temperatureFloat = [temperatureString floatValue];
  
  return [NSString stringWithFormat:@"%.01f°", temperatureFloat];
}

- (NSString *) conditionText {
  return [[self currentCondition] valueForKey:@"text"];
}

- (NSDictionary *) current {
  return current;
}

- (void) setCurrent:(NSDictionary *) newCurrent {
  current = newCurrent;
}

- (NSDictionary *) location {
  return location;
}

- (void) setLocation:(NSDictionary *) newLocation {
  location = newLocation;
}

- (NSString *) locationName {
  return [location valueForKey:@"name"];
}


- (NSDictionary *) currentCondition {
  return [current valueForKey:@"condition"];
}

- (NSString *) humidity {
  return [NSString stringWithFormat:@"%@%@", [current valueForKey:@"humidity"], @"%"];
}

- (NSString *) pressure {
  BOOL useMetricSystem = [[ConfigManager defaultManager] getUseMetricSystem];
  NSString *key =  useMetricSystem ? @"pressure_mb" : @"pressure_in";
  NSString *unit = useMetricSystem ? @"mb" : @"in";
  return [NSString stringWithFormat:@"%@%@", [current valueForKey:key], unit];
}

- (NSString *) precipitation {
  BOOL useMetricSystem = [[ConfigManager defaultManager] getUseMetricSystem];
  NSString *key = useMetricSystem ? @"precip_mm" : @"precip_in";
  NSString *unit = useMetricSystem ? @"mm" : @"in";

  return [NSString stringWithFormat:@"%@%@", [current valueForKey:key], unit];
}

- (NSString *) windSpeed {
  BOOL useMetricSystem = [[ConfigManager defaultManager] getUseMetricSystem];
  NSString *key = useMetricSystem ? @"wind_kph" : @"wind_mph";
  NSString *unit = useMetricSystem ? @"kph" : @"mph";
  return [NSString stringWithFormat:@"%@%@", [current valueForKey:key], unit];
}

- (NSString *) conditionIcon { 
  NSDictionary *currentCondition = [self currentCondition];
  NSString *icon64 = [currentCondition valueForKey:@"icon"];
  NSString *icon128 = [icon64 stringByReplacingOccurrencesOfString:@"64x64" withString:@"128x128"];
  return [NSString stringWithFormat:@"http:%@", icon128];
}
@end
