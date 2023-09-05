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
    NSLog(@"in AppController#init self = %@", self);
  }
  return self;
}

- (void) dealloc {
  [super dealloc];
}

- (void) awakeFromNib {
  NSLog(@"awakeFromNib");
  currentLocationIndex = 0;
  [self setupConfigService];
  [self setupWeatherApi];
  [self fetchWeatherForCurrentIndex];
}

- (void) setupWeatherApi {
  api = [[WeatherApi alloc] initWithToken:[configService fetchAuthToken]];
}

- (void) setupConfigService {
  configService = [[ConfigService alloc] init];
  [configService retain];
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

- (IBAction) showPrefPanel: (id)sender {
  NSLog(@"Something triggered showPrefPanel!");
  if(!preferencesController) {
    preferencesController = [[PreferencesController alloc] initWithWindowNibName:@"Preferences"];
    [preferencesController setConfigService:configService];
  }
  [preferencesController showWindow:nil];
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
