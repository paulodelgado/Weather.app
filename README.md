# Weather.app

This is a small weather app written in ObjectiveC and using the GNUStep framework in an attempt for me to:
* Learn some ObjectiveC
* Doing so without using only OSS.
* Adding to the Ecosystem of GNUStep apps. 

# Building and Installing

* Ensure you have the GNUStep dev environment tools installed (libgnustep-base-dev, gnustep-make, gnustep-gui-common, etc)
* Clone this repo.
* cd to the repo directory.
* Run `make` in your command line (or use ProjectCenter)
* Run `sudo make install` for a system-wide installation or `make install` to install for just your user.

# Usage
Run the app from the repo directory.   It won't work the first time, so quit it.

You will need to manually edit the generated file in `~/.config/Weather.app/config.plist` to include your WeatherApi.com token. 

The token is free once you sign up for a free plan with WeatherAPI.com.  Yes, this is annoying but I don't know (really haven't researched) any other Weather APIs that are free to use.

My config file looks as follows:
```
{
    "api_key" = "your api token goes here";
    locations = (
        "Cupertino, CA",
        "New York, NY"
    );
    "use_metric_system" = "false";
}
```

# Known Bugs
* The "current location icon" doesn't update/change when you switch between locations/cities.

# To-Do's
* Use a nicer background depending on the weather api current condition code.

# Contributing
This is free software, clone this repo, create a feature branch and make a pull request. Maybe I'll merge it.

# Screenshots
* Screenshot with Preferences window display alongside GWorkspace and WindowMaker
![Screenshot with Preferences window display alongside GWorkspace and WindowMaker](https://github.com/paulodelgado/Weather.app/blob/master/GitHub/Weather.app%20with%20GWorkspace.png?raw=true)
