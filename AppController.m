/*
Project: Weather

Author: Paulo Delgado

Created: 2023-08-25 16:05:06 -0700 by paulo

Application Controller
*/

#import "AppController.h"

@implementation AppController


id temperatureLabel;
id locationLabel;
id imageView;
id nextLocationButton;
id previousLocationButton;

int currentLocationIndex = 0;
int savedLocationsCount;

ConfigService *configService;
WeatherApi *api;

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
  [self setupConfigService];
  [self setupWeatherApi];
  [self fetchWeatherForCurrentIndex];
}

- (void) setupWeatherApi {
  api = [[WeatherApi alloc] initWithToken:[configService fetchAuthToken]];
}

- (void) setupConfigService {
  configService = [[ConfigService alloc] init];
  savedLocationsCount = [configService locationCount];
}

- (void) fetchWeatherForCurrentIndex {
  NSLog(@"AppController#fetchWeatherForCurrentIndex");
  
  NSLog(@"configService: %@", configService);
  
  NSString *savedLocationName = [configService locationAtIndex:currentLocationIndex];
  NSLog(@"fetching weather for location (%@)", savedLocationName);
  LocationWeatherData *lwd = [api fetchWeatherDataFor:savedLocationName];

  [locationLabel setStringValue:[lwd locationName]];
  [temperatureLabel setStringValue:[lwd temperature]];
  
  NSString *iconURLString = [lwd icon];
  NSLog(@"icon url: %@", iconURLString);
  
  NSURL *iconURL = [NSURL URLWithString:iconURLString];
  
  NSImage *icon = [[NSImage alloc] initWithContentsOfURL:iconURL];
  [imageView setImage:icon];
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

- (void) showPrefPanel: (id)sender {
  NSLog(@"Something triggered showPrefPanel!");
  PreferencesPaneController *prefPaneController = [[PreferencesPaneController alloc] initWithWindowNibName:@"yermom"];
  [prefPaneController showWindow:sender];
}


- (void) showNextLocation: (id)sender {
  NSLog(@"AppController#showNextLocation");
  if(currentLocationIndex + 1 >= savedLocationsCount) {
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
