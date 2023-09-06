/*
Project: Weather

Author: Paulo Delgado

Created: 2023-08-25 16:05:06 -0700 by paulo

Application Controller
*/

#import "AppController.h"

@implementation AppController

int currentLocationIndex = 0;

+ (void) initialize {
  NSLog(@"AppController#initialize");
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init {
  NSLog(@"AppController#init");
  if ((self = [super init]))
  {
  }
  return self;
}

- (void) dealloc {
  [super dealloc];
}

- (void) awakeFromNib {
  NSLog(@"awakeFromNib");
  currentLocationIndex = 0;
  [self setupWeatherApi];
  [self fetchWeatherForCurrentIndex];
}

- (void) setupWeatherApi {
  api = [[WeatherApi alloc] initWithToken:[[ConfigManager defaultManager] fetchAuthToken]];
}

- (void) fetchWeatherForCurrentIndex {
  NSLog(@"AppController#fetchWeatherForCurrentIndex");
  
  
  NSString *savedLocationName = [[ConfigManager defaultManager] locationAtIndex:currentLocationIndex];
  NSLog(@"fetching weather for location (%@)", savedLocationName);
  LocationWeatherData *lwd = [api fetchWeatherDataFor:savedLocationName];

  [locationLabel setStringValue:[lwd locationName]];
  [temperatureLabel setStringValue:[lwd temperature]];
  [windSpeedLabel setStringValue:[lwd windSpeed]];
  [precipitationLabel setStringValue:[lwd precipitation]];
  [pressureLabel setStringValue:[lwd pressure]];
  [humidityLabel setStringValue:[lwd humidity]];
  
  NSString *iconURLString = [lwd conditionIcon];
  NSLog(@"icon url: %@", iconURLString);
  
  NSURL *iconURL = [NSURL URLWithString:iconURLString];

  [conditionIcon release];
  [imageView delete:nil];
  conditionIcon = [[NSImage alloc] initWithContentsOfURL:iconURL];
  [imageView setImage:conditionIcon];
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif {
  NSLog(@"applicationDidFinishLaunching");
}

- (BOOL) applicationShouldTerminate: (id)sender {
  return YES;
}

- (void) applicationWillTerminate: (NSNotification *)aNotif {
}

- (BOOL) application: (NSApplication *)application
            openFile: (NSString *)fileName {
  return NO;
}

- (IBAction) showPrefPanel: (id)sender {
  NSLog(@"Something triggered showPrefPanel!");
  if(!preferencesController) {
    preferencesController = [[PreferencesController alloc] initWithWindowNibName:@"Preferences"];
  }
  [preferencesController showWindow:nil];
}


- (void) showNextLocation: (id)sender {
  NSLog(@"AppController#showNextLocation");
  if(currentLocationIndex + 1 >= [[ConfigManager defaultManager] locationCount]) {
    return;
  } else {
    currentLocationIndex++;
    [self fetchWeatherForCurrentIndex];
  }
}

- (void) showPreviousLocation: (id)sender {
  NSLog(@"AppController#showPreviousLocation");
  if(currentLocationIndex == 0) {
    return;
  } else {
    currentLocationIndex--;
    [self fetchWeatherForCurrentIndex];
  }
}
@end
