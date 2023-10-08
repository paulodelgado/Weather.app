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

- (void)fetchCoordinatesForLocation:(NSString *)locationQuery completionHandler:(void (^)(double, double, NSError *))completionHandler {
    NSString *urlString = [self searchURL:locationQuery];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionHandler(0.0, 0.0, error);
            return;
        }

        NSError *jsonError;
        NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError || ![results isKindOfClass:[NSArray class]] || results.count == 0) {
            completionHandler(0.0, 0.0, jsonError ?: [self customError]);
        } else {
            NSDictionary *firstResult = results.firstObject;
            double latitude = [firstResult[@"lat"] doubleValue];
            double longitude = [firstResult[@"lon"] doubleValue];
            completionHandler(latitude, longitude, nil);
        }
    }];

    [task resume];
}

- (NSError *)customError {
    return [NSError errorWithDomain:@"GeolocationServiceErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Failed to retrieve geolocation data."}];
}
@end
