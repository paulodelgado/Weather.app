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
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init {
  if ((self = [super init]))
  {
  }
  return self;
}

- (void) dealloc {
  [super dealloc];
}

- (void) awakeFromNib {
  currentLocationIndex = 0;
  [self setupWeatherApi];
  [self fetchWeatherForCurrentIndex];
}

- (void) setupWeatherApi {
  api = [[WeatherApi alloc] initWithToken:[[ConfigManager defaultManager] fetchAuthToken]];
}

- (void) fetchWeatherForCurrentIndex {  
  NSString *savedLocationName = [[ConfigManager defaultManager] locationAtIndex:currentLocationIndex];
  LocationWeatherData *lwd = [api fetchWeatherDataFor:savedLocationName];

  [locationLabel setStringValue:[lwd locationName]];
  [temperatureLabel setStringValue:[lwd temperature]];
  [windSpeedLabel setStringValue:[lwd windSpeed]];
  [precipitationLabel setStringValue:[lwd precipitation]];
  [pressureLabel setStringValue:[lwd pressure]];
  [humidityLabel setStringValue:[lwd humidity]];
  
  NSString *iconURLString = [lwd conditionIcon];
  
  NSURL *iconURL = [NSURL URLWithString:iconURLString];

  NSImage *newConditionIcon = [[NSImage alloc] initWithContentsOfURL:iconURL];
  [imageView setImage:newConditionIcon];
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif {
}

- (BOOL) applicationShouldTerminate: (id)sender {
  NSLog(@"applicationShouldTerminate");
  return YES;
}

- (void) applicationWillTerminate: (NSNotification *)aNotif {
  NSLog(@"applicationWillTerminate");
}

- (BOOL) application: (NSApplication *)application
            openFile: (NSString *)fileName {
  return NO;
}

- (IBAction) showPrefPanel: (id)sender {
  if(!preferencesController) {
    preferencesController = [[PreferencesController alloc] initWithWindowNibName:@"Preferences"];
  }
  [preferencesController showWindow:nil];
}


- (void) showNextLocation: (id)sender {
  if(currentLocationIndex + 1 >= [[ConfigManager defaultManager] locationCount]) {
    return;
  } else {
    currentLocationIndex++;
    [self fetchWeatherForCurrentIndex];
  }
}

- (void) showPreviousLocation: (id)sender {
  if(currentLocationIndex == 0) {
    return;
  } else {
    currentLocationIndex--;
    [self fetchWeatherForCurrentIndex];
  }
}
@end
