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
  [self fetchWeatherForCurrentIndex:nil];
  ConfigManager *myManager = [ConfigManager defaultManager];

  NSMenu *menu = [locationsSubMenu submenu];

  NSMenuItem *m = [[NSMenuItem alloc] initWithTitle:@"" action:NULL keyEquivalent:@""];
  [m isSeparatorItem];
  [menu addItem:m];

  int i;
  for(i = 0; i < [myManager locationCount] ; i++) {
    NSString *locationName = [myManager locationAtIndex:i];
    SEL mySelector = @selector(showLocationAtIndex:); 
    NSString *key;
    if(i < 9) {
      key = [NSString stringWithFormat:@"%d", i+1];
    } else {
      key = @"";
    }
    NSMenuItem *m = [[NSMenuItem alloc] initWithTitle:locationName action:mySelector keyEquivalent:key];
    [menu addItem:m];
  }
}

- (void) setupWeatherApi {
  api = [[WeatherApi alloc] initWithToken:[[ConfigManager defaultManager] fetchAuthToken]];
}

- (void) fetchWeatherForCurrentIndex:(id) sender {  
  NSString *savedLocationName = [[ConfigManager defaultManager] locationAtIndex:currentLocationIndex];
  LocationWeatherData *lwd = [api fetchWeatherDataFor:savedLocationName];

  [locationLabel setStringValue:[lwd locationName]];
  [temperatureLabel setStringValue:[lwd temperature]];
  [windSpeedLabel setStringValue:[lwd windSpeed]];
  [precipitationLabel setStringValue:[lwd precipitation]];
  [pressureLabel setStringValue:[lwd pressure]];
  [humidityLabel setStringValue:[lwd humidity]];
  [conditionLabel setStringValue:[lwd conditionText]];

  NSString *timeOfDay = currentLocationIndex % 2 == 0 ? @"day" : @"night";
  [weatherView setTimeOfDay:timeOfDay];
  NSString *iconURLString = [lwd conditionIcon];
  NSURL *iconURL = [NSURL URLWithString:iconURLString];
  NSImage *newConditionIcon = [[NSImage alloc] initWithContentsOfURL: iconURL];
  [imageView setImage:newConditionIcon];
  [window display];
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif {
}

- (BOOL) applicationShouldTerminate: (id)sender {
  return YES;
}

- (void) applicationWillTerminate: (NSNotification *)aNotif {
  [[ConfigManager defaultManager] saveConfig];
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
    [self fetchWeatherForCurrentIndex:sender];
  }
}

- (void) showPreviousLocation: (id)sender {
  if(currentLocationIndex == 0) {
    return;
  } else {
    currentLocationIndex--;
    [self fetchWeatherForCurrentIndex:sender];
  }
}

- (void) showLocationAtIndex:(id)sender {
  NSInteger index = [[sender keyEquivalent] integerValue] - 1;
  currentLocationIndex = index;
  [self fetchWeatherForCurrentIndex:sender];
}
@end
