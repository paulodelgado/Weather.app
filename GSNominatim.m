/*
   Project: GSNominatim

   A wrapper to the Nominatim Geolocation web API

   Copyright (C) 2023 Free Software Foundation

   Author: Paulo Delgado

   Created: 2023-10-07 by Paulo Delgado

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

#import "GSNominatim.h"


@implementation GSNominatim

static NSString *const NOMINATIM_BASE_URL = @"https://nominatim.openstreetmap.org/";

- (NSString *) searchURL:(NSString *) query {
  return [
    [NSString stringWithFormat:@"%@search?q=%@&format=json", NOMINATIM_BASE_URL, query]
    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
  ];
}

- (NSDictionary *) coordsFromQuery:(NSString *) query {

  NSMutableDictionary *result;
  GWSService *service = [GWSService new];
  [service setURL: [self searchURL:query]];
  [service setHTTPMethod:@"GET"];

  [service setCoder: [GWSJSONCoder coder]];

  result = [service invokeMethod:@"search"
    parameters: nil
         order: 0
       timeout: 30];
  NSDictionary *myResult = [result valueForKey:@"GWSCoderParameters"];
  NSDictionary *locationData = [myResult valueForKey:@"Result"];
  return locationData;
}
@end
