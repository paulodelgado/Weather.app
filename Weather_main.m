/* 
   Project: Weather.app
   Author: Paulo Delgado
   Created: 2023-08-25 16:05:06 -0700 by paulo
*/

#import <AppKit/AppKit.h>
#import "AppController.h"

int main(int argc, const char *argv[])
{

  NSAutoreleasePool *pool;
  AppController *delegate;

  pool = [[NSAutoreleasePool alloc] init];
  delegate = [[AppController alloc] init];

  [NSApplication sharedApplication];
  [NSApp setDelegate:delegate];

  /*

  */
  RELEASE(pool);

  return NSApplicationMain (argc, argv);
}
