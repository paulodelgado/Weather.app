/*
   Project: Weather

   Author: Paulo Delgado

   Created: 2023-08-25 16:05:06 -0700 by paulo

   Application Controller
*/

#import "AppController.h"
#import "LocationWeatherData.h"

@implementation AppController

LocationWeatherData *lwd;

+ (void) initialize
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

  /*
   * Register your app's defaults here by adding objects to the
   * dictionary, eg
   *
   * [defaults setObject:anObject forKey:keyForThatObject];
   *
   */
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
}

- (id) init
{
  if ((self = [super init]))
    {
    }
  return self;
}

- (void) dealloc
{
  [super dealloc];
}

- (void) awakeFromNib
{
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif
{
  NSLog(@"Fetching Config");
  NSString *authToken = @"foo";
  WeatherApi *api = [[WeatherApi alloc] initWithToken:authToken];
  NSString *defaultLocation = @"Cupertino, CA";
  LocationWeatherData *lwd = [api fetchWeatherDataFor:defaultLocation];
  NSLog(@"Temperature:",  [lwd temperature]);
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
}

@end
