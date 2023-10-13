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
#import <GSMetNoWeather/GSMetNoWeather.h>
#import "LocationAndWeatherData.h"
#import "ConfigManager.h"
#import "PreferencesController.h"
#import "WeatherViewController.h"
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
  id window;
  id locationsSubMenu;

  id nextLocationButton;
  id previousLocationButton;

  PreferencesController *preferencesController;
  NSImage *conditionIcon;

  int currentLocationIndex;
  GSMetNoWeather *api;
  NSMutableArray *cachedWeatherData;
  NSView *loadingView;
  BOOL weatherDataIsLoaded;
}

+ (void)  initialize;

- (id) init;
- (void) dealloc;
- (void) awakeFromNib;
- (void) prepareCachedWeatherData;
- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)aNotif;
- (BOOL) application: (NSApplication *)application openFile: (NSString *)fileName;
- (IBAction) showPrefPanel: (id)sender;
- (void) showNextLocation: (id)sender;
- (void) showPreviousLocation: (id)sender;
- (void) setupWeatherApi;
- (void) fetchWeatherForAllLocations;
- (void) resetView;
- (void) showLocationAtIndex:(id)sender;

@end

#endif // _PCAPPPROJ_APPCONTROLLER_H
