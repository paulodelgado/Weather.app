/*
   Project: Weather

   Copyright (C) 2023 Free Software Foundation

   Author: Paulo Delgado

   Created: 2023-08-31 15:05:44 -0700 by paulo

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

#import "PreferencesController.h"

@implementation PreferencesController

- (void) awakeFromNib {
  NSLog(@"PreferencesController#awakeFromNib");
  NSLog(@"in awakeFromNib self = %@", self);
  NSString *authToken = [configService fetchAuthToken];
  NSLog(@"setting tokenTextField with: %@", authToken);
  [tokenTextField setObjectValue:authToken];
}

- (void) setConfigService:(ConfigService *) service {
  NSLog(@"in setConfigService => self: %@", self);
  configService = service;
}

- (IBAction) setApiToken:(id) sender {
  NSLog(@"PreferencesController#setApiToken");

}

- (IBAction) setUseMetricSystem:(id) sender {
  NSLog(@"PreferencesController#setUseMetricSystem");

}

- (IBAction) addLocation:(id) sender {
  NSLog(@"PreferencesController#addLocation");

}

- (IBAction) removeLocation:(id) sender {
  NSLog(@"PreferencesController#removeLocation");

}
@end
