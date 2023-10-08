#
# GNUmakefile - Generated by ProjectCenter
#
ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
  ifeq ($(GNUSTEP_MAKEFILES),)
    $(warning )
    $(warning Unable to obtain GNUSTEP_MAKEFILES setting from gnustep-config!)
    $(warning Perhaps gnustep-make is not properly installed,)
    $(warning so gnustep-config is not in your PATH.)
    $(warning )
    $(warning Your PATH is currently $(PATH))
    $(warning )
  endif
endif
ifeq ($(GNUSTEP_MAKEFILES),)
 $(error You need to set GNUSTEP_MAKEFILES before compiling!)
endif

include $(GNUSTEP_MAKEFILES)/common.make

#
# Application
#
VERSION = 0.1
PACKAGE_NAME = Weather
APP_NAME = Weather
Weather_APPLICATION_ICON = icon.png


#
# Libraries
#
Weather_LIBRARIES_DEPEND_UPON += -lWebServices 

#
# Resource files
#
Weather_RESOURCE_FILES = \
Resources/Weather.gorm \
Resources/Preferences.gorm \
Resources/LocationSearchWindow.gorm \
Resources/weatherapi_logo.png \
Resources/icon.png \
Resources/icon.tiff \
Resources/loading.gif 


#
# Header files
#
Weather_HEADER_FILES = \
AppController.h \
LocationWeatherData.h \
WeatherApi.h \
ConfigManager.h \
PreferencesController.h \
WeatherView.h \
WeatherGradients.h \
WeatherIconImageView.h \
WeatherWindow.h \
GSNominatim.h \
GSMetNoWeather.h \
LocationSearchController.h

#
# Objective-C Class files
#
Weather_OBJC_FILES = \
AppController.m \
LocationWeatherData.m \
WeatherApi.m \
ConfigManager.m \
PreferencesController.m \
WeatherView.m \
WeatherGradients.m \
WeatherIconImageView.m \
WeatherWindow.m \
GSNominatim.m \
GSMetNoWeather.m \
LocationSearchController.m

#
# Other sources
#
Weather_OBJC_FILES += \
Weather_main.m 

#
# Makefiles
#
-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
