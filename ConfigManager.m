/*
Project: Weather

Copyright (C) 2023 Free Software Foundation

Author: Paulo Delgado

Created: 2023-08-30 14:50:36 -0700 by paulo

This application is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This application is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU General Public
License along with this library; if not, write to the Free
Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "ConfigManager.h"

@implementation ConfigManager

static NSString *relativeDirectoryPath = @"/.config/Weather.app/";
static NSString *configFileName = @"config.plist";
static ConfigManager *defaultManager;

+ (void) initialize {
  static BOOL isInitialized = NO;
  if(!isInitialized) {
    defaultManager = [[ConfigManager alloc] init];
    isInitialized = YES;
  }
}

+ (ConfigManager *) defaultManager {
  return defaultManager;
}

- (id) init {
  self = [super init];
  if(self) {
    [self createConfigFileIfMissing];
    [self setupDictionary];
  }

  return self;
}

- (NSString *) fetchAuthToken {
  return [configDictionary valueForKey:@"api_key"];
}

- (BOOL) getUseMetricSystem {
  return [[configDictionary valueForKey:@"use_metric_system"] boolValue];
}

- (void) setUseMetricSystem:(BOOL) newValue {
  NSString *stringValue = (newValue ? @"true" : @"false");
  [configDictionary setObject:stringValue forKeyedSubscript:@"use_metric_system"];
}

- (NSMutableDictionary *) buildDefaultConfig {
  id locs[] = {@"Cupertino, CA", @"New York, NY"};
  NSArray *locations = [NSArray arrayWithObjects:locs count:2];
  NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
    locations, @"locations", @"", @"api_key", @"false", @"use_metric_system", nil];
  return newDict;
}

- (void) createConfigFileIfMissing {

  NSString *filePath = [self defaultConfigFilePath];

  bool configFileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];

  if(!configFileExists) {
    NSMutableDictionary *newConfig = [self buildDefaultConfig];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createDirectoryAtPath:[self defaultConfigDirectoryPath]
                            withIntermediateDirectories:true
                                             attributes: nil
                                                  error: nil
    ];

    [fileManager createFileAtPath:filePath
                                            contents: nil
                                          attributes: nil
    ];
    [newConfig writeToFile:filePath atomically:false];
  }
}

- (NSString *) defaultConfigFilePath {
  NSString *fullConfigFilePath = [NSString stringWithFormat:@"%@%@%@", NSHomeDirectory(), relativeDirectoryPath, configFileName];
  return fullConfigFilePath;
}

- (NSString *) defaultConfigDirectoryPath {
  NSString *fullConfigFilePath = [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), relativeDirectoryPath];
  return fullConfigFilePath;
}

- (void) setupDictionary {
  configDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self defaultConfigFilePath]];
  [configDictionary retain];
  locationsArr = [configDictionary valueForKey:@"locations"];
  [locationsArr retain];
}

- (NSString *) locationAtIndex:(int) index {
  return [locationsArr objectAtIndex:index];
}

- (int) locationCount {
  return [locationsArr count];
}

- (void) saveNewConfig:(NSMutableDictionary *) newConfig {
  [newConfig writeToFile:[self defaultConfigFilePath] atomically:false];
  [self setupDictionary];
}

- (void) addLocation:(NSString *) newLocation {
  [locationsArr addObject:newLocation];
}

- (void) removeLocationAt:(NSInteger) index {
  [locationsArr removeObjectAtIndex:index];
}

- (void) setLocationName:(id) name atIndex:(NSInteger )index {
  [locationsArr replaceObjectAtIndex:index withObject:name];
}

 
@end
