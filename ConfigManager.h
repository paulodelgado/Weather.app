/*
   Project: Weather

   Copyright (C) 2023 Free Software Foundation

   Author: Paulo Delgado

   Created: 2023-08-30 14:50:12 -0700 by paulo

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

#ifndef _ConfigManager_H_
#define _ConfigManager_H_

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject
{
  NSDictionary *configDictionary;
  NSMutableArray *locationsArr;
}

+ (ConfigManager *) defaultManager;

- (void) setupDictionary;
- (void) saveNewConfig:(NSDictionary *) newConfig;
- (NSDictionary *) buildDefaultConfig;
- (NSString *) defaultConfigFilePath;
- (NSString *) defaultConfigDirectoryPath;

- (void) createConfigFileIfMissing;

- (NSString *) fetchAuthToken;
- (NSString *) locationAtIndex:(int) index;
- (int) locationCount;
- (void) addLocation:(NSString *) newLocation;
- (void) removeLocationAt:(NSInteger) index;
- (void) setLocationName:(id)name atIndex:(NSInteger) index;

@end

#endif // _ConfigManager_H_

