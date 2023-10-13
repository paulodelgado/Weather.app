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
    [self prepareCachedWeatherData];
  }
  return self;
}

- (void) dealloc {
  [super dealloc];
}

- (void) awakeFromNib {
  weatherDataIsLoaded = NO;
  [self buildLoadingView];
  [window setContentView:loadingView];
  currentLocationIndex = 0;
  [self setupWeatherApi];
  [self fetchWeatherForAllLocations];
  // [self setupMenu]
}

- (void) prepareCachedWeatherData {
  cachedWeatherData = [[NSMutableArray alloc] init];
  [cachedWeatherData retain];
}

- (void) buildLoadingView {
  loadingView = [[NSView alloc] initWithFrame:[[window contentView] frame]];
  NSInteger progressIndicatorXCoord = ([window frame].size.width / 2) - 16;
  NSInteger progressIndicatorYCoord = ([window frame].size.height / 2) - 16;
  NSProgressIndicator *progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(progressIndicatorXCoord , progressIndicatorYCoord, 32, 32)];
  [progressIndicator setStyle:NSProgressIndicatorSpinningStyle];
  [progressIndicator setDisplayedWhenStopped:NO];
  [progressIndicator setIndeterminate:YES];
  [progressIndicator startAnimation:self];
  [loadingView addSubview:progressIndicator];
}

- (void) setupWeatherApi {
  api = [[GSMetNoWeather alloc] init];
}

- (void) setupMenu {
  ConfigManager *myManager = [ConfigManager defaultManager];

  NSMenu *menu = [locationsSubMenu submenu];

  NSMenuItem *m = [[NSMenuItem alloc] initWithTitle:@"" action:NULL keyEquivalent:@""];
  [m isSeparatorItem];
  [menu addItem:m];

  int i;
  for(i = 0; i < [myManager locationCount] ; i++) {
    NSDictionary *locationDict = [myManager locationAtIndex:i];
    SEL mySelector = @selector(showLocationAtIndex:); 
    NSString *key;
    if(i < 9) {
      key = [NSString stringWithFormat:@"%d", i+1];
    } else {
      key = @"";
    }
    NSString *locationName = [locationDict valueForKey:@"name"];
    NSMenuItem *m = [[NSMenuItem alloc] initWithTitle:locationName action:mySelector keyEquivalent:key];
    [menu addItem:m];
  }
}

- (void) fetchWeatherForAllLocations {
  ConfigManager *myManager = [ConfigManager defaultManager];
  [cachedWeatherData removeAllObjects];
  int i;
  for(i = 0; i < [myManager locationCount] ; i++) {
    NSDictionary *locationDict = [myManager locationAtIndex:i];
    NSString *locationName = [locationDict valueForKey:@"name"];
    double latitude  = [[locationDict valueForKey:@"latitude"] doubleValue];
    double longitude = [[locationDict valueForKey:@"longitude"] doubleValue];

    [api fetchWeatherDataForLatitude:latitude longitude:longitude compact:YES completionHandler:^(NSDictionary *data, NSError *error) {
      if(error) {
        NSLog(@"Error fetching weather data: %@", error);
      } else {
        LocationAndWeatherData *locationAndWeatherData = [[LocationAndWeatherData alloc] init];
        [locationAndWeatherData retain];
        [locationAndWeatherData setLocationName:locationName];
        [locationAndWeatherData setWeatherData:data];
        NSLog(@"Fetched weather data for %@", locationName);
        [cachedWeatherData addObject:locationAndWeatherData];

        // Now lets notify the main thread that we can display the weather for the first location
        if([cachedWeatherData count] == [myManager locationCount] && !weatherDataIsLoaded) {
          weatherDataIsLoaded = YES;
          [self performSelectorOnMainThread:@selector(displayWeatherForCurrentIndex:) withObject:nil waitUntilDone:NO];
        }
      }
    }];
  }
}

- (void) displayWeatherForCurrentIndex:(id) sender {
  LocationAndWeatherData *currentLocationAndWeatherData = [cachedWeatherData objectAtIndex:currentLocationIndex];
  [window setTitle:[NSString stringWithFormat:@"Weather - %@", [currentLocationAndWeatherData valueForKey:@"locationName"]]];
  WeatherViewController *weatherViewController = [[WeatherViewController alloc] init];
  [weatherViewController setLocationAndWeatherData:currentLocationAndWeatherData];

  NSLog(@"about to display weather for %@", [currentLocationAndWeatherData valueForKey:@"locationName"]);
  [window setContentView:weatherViewController.view];
  NSLog(@"displayed weather for %@", [currentLocationAndWeatherData valueForKey:@"locationName"]);

  NSLog(@"gonna debug here");

  // lets force redraw the window
  [window display];
}

- (void) resetView {
  [window setContentView:loadingView];
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
    [self displayWeatherForCurrentIndex:sender];
  }
}

- (void) showPreviousLocation: (id)sender {
  if(currentLocationIndex == 0) {
    return;
  } else {
    currentLocationIndex--;
    [self displayWeatherForCurrentIndex:sender];
  }
}

- (void) showLocationAtIndex:(id)sender {
  NSInteger index = [[sender keyEquivalent] integerValue] - 1;
  currentLocationIndex = index;
  [self displayWeatherForCurrentIndex:sender];
}
@end
