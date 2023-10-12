/* All rights reserved */

#ifndef LocationSearchController_H_INCLUDE
#define LocationSearchController_H_INCLUDE

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <GSNominatim/GSNominatim.h>
#import "ConfigManager.h"

@interface LocationSearchController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>

{
  IBOutlet NSTextField *locationQueryTextField;
  IBOutlet NSButton *addLocationButton;
  IBOutlet NSButton *startSearchButton;
  IBOutlet NSTableView *searchResultsTableView;
  id window;
  NSArray *lastSearchResults;
}

- (IBAction) startSearch:(id) sender;
- (IBAction) saveLocationData:(id) sender;
- (IBAction) closeWindow:(id) sender;
- (void) resetValues;


@end

#endif // LocationSearchController_H_INCLUDE
