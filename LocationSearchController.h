/* All rights reserved */

#ifndef LocationSearchController_H_INCLUDE
#define LocationSearchController_H_INCLUDE

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface LocationSearchController : NSWindowController
{
  IBOutlet NSTextField *validLocationIndicator;
  IBOutlet NSButton *addLocationButton;
  IBOutlet NSButton *startSearchButton;
  id window;


}

- (IBAction) startSearch:(id) sender;
- (IBAction) saveLocationData:(id) sender;
- (IBAction) closeWindow:(id) sender;


@end

#endif // LocationSearchController_H_INCLUDE
