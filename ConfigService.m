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

#import "ConfigService.h"

@implementation ConfigService
NSDictionary *configDictionary;
NSArray *locationsArr;

static NSString *relativeDirectoryPath = @"/.config/Weather.app/";
static NSString *configFileName = @"config.plist";

- (id) init {
  NSLog(@"ConfigService#init");
  self = [super init];
  if(self) {
    [self createConfigFileIfMissing];
    [self setupDictionary];
  }

  return self;
}

- (NSString *) fetchAuthToken {
  NSLog(@"ConfigService#fetchAuthToken");
  return [configDictionary valueForKey:@"api_key"];
}

- (NSDictionary *) buildDefaultConfig {
  NSLog(@"ConfigService#buildDefaultConfig");


  id locs[] = {@"Cupertino, CA", @"New York, NY"};
  NSArray *locations = [NSArray arrayWithObjects:locs count:2];
  NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:
    locations, @"locations", @"", @"api_key", nil];
  return newDict;
}

- (void) createConfigFileIfMissing {
  NSLog(@"ConfigService#createConfigFileIfMissing");

  NSString *filePath = [self defaultConfigFilePath];

  bool configFileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];

  if(!configFileExists) {
    NSDictionary *newConfig = [self buildDefaultConfig];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool dirExists = [fileManager createDirectoryAtPath:[self defaultConfigDirectoryPath]
                            withIntermediateDirectories:true
                                             attributes: nil
                                                  error: nil
    ];
    NSLog(@"dirExists: %d", dirExists);

    bool fileCreated = [fileManager createFileAtPath:filePath
                                            contents: nil
                                          attributes: nil
    ];
    if(!fileCreated) {
    }
    bool successWrite = [newConfig writeToFile:filePath atomically:false];
    if(!successWrite) {
      NSLog(@"dammit");
    }
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
  configDictionary = [NSDictionary dictionaryWithContentsOfFile:[self defaultConfigFilePath]];
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

@end
