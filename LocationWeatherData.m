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
  NSLog(@"LocationWeatherData#initWithDictionary");
  self = [super init];
  if(self) {
    NSLog(@"retrieving Data from Dictionary");
    NSLog(@"keys: %@", [dict allKeys]);
    [self setCurrent:[dict valueForKey:@"current"]];
    [self setLocation: [dict valueForKey:@"location"]];
  }
  return self;
}

- (NSString *) temperature {
  NSLog(@"LocationWeatherData#temperature");
  NSString *temperatureString = [current valueForKey:@"temp_f"];
  NSInteger temperatureInteger = [temperatureString integerValue];
  
  return [NSString stringWithFormat:@"%d°", temperatureInteger];
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
  return [NSString stringWithFormat:@"%@%@", [current valueForKey:@"pressure_in"], @" in"];
}

- (NSString *) precipitation {
  return [NSString stringWithFormat:@"%@%@", [current valueForKey:@"precip_in"], @" in"];
}

- (NSString *) windSpeed {
  return [NSString stringWithFormat:@"%@%@", [current valueForKey:@"wind_mph"], @" mph"];
}

- (NSString *) conditionIcon { 
  NSDictionary *currentCondition = [self currentCondition];
  NSString *icon64 = [currentCondition valueForKey:@"icon"];
  NSString *icon128 = [icon64 stringByReplacingOccurrencesOfString:@"64x64" withString:@"128x128"];
  return [NSString stringWithFormat:@"http:%@", icon128];
}
@end
