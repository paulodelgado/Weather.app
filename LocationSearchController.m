/* All rights reserved */

#import "LocationSearchController.h"

@implementation LocationSearchController

- (void) awakeFromNib {
  [self resetValues];
}

- (IBAction) startSearch:(id) sender {
  NSLog(@"startSearch");
  GSNominatim *geolocationService = [[GSNominatim alloc] init];

  NSString *locationQuery = [locationQueryTextField stringValue];
  NSLog(@"location Query: %@", locationQuery);

  NSDictionary *structuredQuery = @{@"city": locationQuery};

  [geolocationService fetchGeolocationByStructuredQuery:structuredQuery completionHandler:^(NSArray *geolocationData, NSError *error) {
    if (error) {
      NSLog(@"Error fetching geolocation data: %@", error);
    } else {
      NSLog(@"Geolocation Data: %@", geolocationData);
      lastSearchResults = geolocationData;
      [searchResultsTableView reloadData];
    }
  }];
}

- (IBAction) saveLocationData:(id) sender {
  NSLog(@"saveLocationData");
  NSInteger selectedRow = searchResultsTableView.selectedRow; 
  [[ConfigManager defaultManager] addLocation:[lastSearchResults objectAtIndex:selectedRow]];
  [self closeWindow:sender];
}


- (IBAction) closeWindow:(id) sender {
  NSLog(@"closeWindow");
  [self close];
  [self resetValues];
}


- (NSInteger) numberOfRowsInTableView:(NSTableView *) t  {
  int count = [lastSearchResults count];
  return count;
}

- (id)tableView: (NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *) column
      row:(NSInteger) row {
  NSDictionary *result = [lastSearchResults objectAtIndex:row];
  return [result valueForKey:[column identifier]];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = notification.object;
    NSInteger selectedRow = tableView.selectedRow;

    if (selectedRow >= 0) {
      [addLocationButton setEnabled:YES];
        // Handle the click on the selected row
        NSLog(@"Clicked on row: %ld", (long)selectedRow);

        // Access the data for the selected row if needed
        // YourDataModel *rowData = [yourDataSource objectAtIndex:selectedRow];
    } else {
      [addLocationButton setEnabled:NO];
      
    }
}

- (void) resetValues {
  lastSearchResults = [[NSArray alloc] init];
  [locationQueryTextField setStringValue:@"Type a city name..."];
  [searchResultsTableView reloadData];
}
@end
