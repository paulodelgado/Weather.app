/*
Project: Weather

Author: Paulo Delgado

Created: 2023-08-25 16:05:06 -0700 by paulo

Application Controller
*/

#import "AppController.h"

@implementation AppController

LocationWeatherData *lwd;
id temperatureLabel;
id locationLabel;
id imageView;
ConfigService *configService;


+ (void) initialize
{
  NSLog(@"AppController#initialize");
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init
{
  NSLog(@"AppController#init");
  if ((self = [super init]))
  {
    [locationLabel setStringValue:@"Hello World"];
  }
  return self;
}

- (void) dealloc
{
  [super dealloc];
}

- (void) awakeFromNib
{
  NSLog(@"awakeFromNib");
  configService = [[ConfigService alloc] init];

  NSLog(@"We have a configService: %@", configService);

  WeatherApi *api = [[WeatherApi alloc] initWithToken:[configService fetchAuthToken]];
  NSString *defaultLocation = [configService selectedLocation];
  LocationWeatherData *lwd = [api fetchWeatherDataFor:defaultLocation];

  [locationLabel setStringValue:[lwd locationName]];
  [temperatureLabel setStringValue:[lwd temperature]];
  
  NSString *iconURLString = [lwd icon];
  NSLog(@"icon url: %@", iconURLString);
  
  NSURL *iconURL = [NSURL URLWithString:iconURLString];
  
  NSImage *icon = [[NSImage alloc] initWithContentsOfURL:iconURL];
  [imageView setImage:icon];
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif
{
  NSLog(@"applicationDidFinishLaunching");
}

- (BOOL) applicationShouldTerminate: (id)sender
{
  return YES;
}

- (void) applicationWillTerminate: (NSNotification *)aNotif
{
}

- (BOOL) application: (NSApplication *)application
            openFile: (NSString *)fileName
{
  return NO;
}

- (void) showPrefPanel: (id)sender
{
  NSLog(@"Something triggered showPrefPanel!");
  PreferencesPaneController *prefPaneController = [[PreferencesPaneController alloc] initWithWindowNibName:@"yermom"];
  [prefPaneController showWindow:sender];
}

- (ConfigService *) configService
{
  return configService;
}

- (void) setConfigService:(ConfigService *) newService
{
  configService = newService;
}

@end
