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
  NSString *authToken = [[ConfigManager defaultManager] fetchAuthToken];
  
  
  [tokenTextField setObjectValue:authToken];
  [useMetricSystemButton setState:[[ConfigManager defaultManager] getUseMetricSystem]];
}

- (IBAction) setApiToken:(id) sender {
  NSLog(@"PreferencesController#setApiToken");

}

- (IBAction) setUseMetricSystem:(id) sender {
  NSLog(@"PreferencesController#setUseMetricSystem");
  [[ConfigManager defaultManager] setUseMetricSystem:[useMetricSystemButton state]];
}

- (IBAction) addLocation:(id) sender {
  [[ConfigManager defaultManager] addLocation:@""];
  [locationsTableView reloadData];
}

- (IBAction) removeLocation:(id) sender {
  NSInteger row = [locationsTableView selectedRow];
  if(row != -1) {
    [[ConfigManager defaultManager] removeLocationAt:row];
    [locationsTableView reloadData];
  }
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *) t  {
  return [[ConfigManager defaultManager] locationCount];
}

- (id)tableView: (NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *) column
      row:(NSInteger) row {
  return [[ConfigManager defaultManager] locationAtIndex:row];
}

- (void)tableView: (NSTableView *)tableView setObjectValue:(id) object
      forTableColumn:(NSTableColumn *) column 
      row:(NSInteger) row {
    [[ConfigManager defaultManager] setLocationName:object atIndex:row]; 
}
@end
