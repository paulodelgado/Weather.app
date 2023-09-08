/* 
   Project: Weather
   Author: Paulo Delgado
   Created: 2023-08-25 16:05:06 -0700 by paulo
   Application Controller
*/

#ifndef _PCAPPPROJ_APPCONTROLLER_H
#define _PCAPPPROJ_APPCONTROLLER_H

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "LocationWeatherData.h"
#import "WeatherApi.h"
#import "ConfigManager.h"
#import "PreferencesController.h"
#import "WeatherView.h"


@interface AppController : NSObject {
  id temperatureLabel;
  id locationLabel;
  id windSpeedLabel;
  id precipitationLabel;
  id pressureLabel;
  id humidityLabel;
  id imageView;
  id conditionLabel;
  id weatherView;
  id window;
  id locationsSubMenu;

  id nextLocationButton;
  id previousLocationButton;

  WeatherApi *api;
  PreferencesController *preferencesController;
  NSImage *conditionIcon;
  
  int currentLocationIndex;
}

+ (void)  initialize;

- (id) init;
- (void) dealloc;
- (void) awakeFromNib;
- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)aNotif;
- (BOOL) application: (NSApplication *)application openFile: (NSString *)fileName;
- (IBAction) showPrefPanel: (id)sender;
- (void) showNextLocation: (id)sender;
- (void) showPreviousLocation: (id)sender;
- (void) setupWeatherApi;
- (void) fetchWeatherForCurrentIndex:(id) sender;
- (void) showLocationAtIndex:(id)sender;

@end

#endif
