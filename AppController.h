/* 
   Project: Weather
   Author: Paulo Delgado
   Created: 2023-08-25 16:05:06 -0700 by paulo
   Application Controller
*/

#ifndef _PCAPPPROJ_APPCONTROLLER_H
#define _PCAPPPROJ_APPCONTROLLER_H

#import <AppKit/AppKit.h>
#import "LocationWeatherData.h"
#import "WeatherApi.h"

@interface AppController : NSObject
{
}

+ (void)  initialize;

- (id) init;
- (void) dealloc;

- (void) awakeFromNib;

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)aNotif;
- (BOOL) application: (NSApplication *)application
  openFile: (NSString *)fileName;

- (void) showPrefPanel: (id)sender;

@end

#endif
