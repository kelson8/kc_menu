# KCMenu
This is a replacement for my old kc_menu which was originally using menuV, this is much easier to use for me.

So far I have some player options, vehicle options and music options but not much is here.

There is also marker testing for this for teleporting between two points on the map.

## Permissions

Busy spinner test permissions
* add_ace group.admin kc_menu.Admin.AdminOptions.EnableBusySpinner allow # Allow enabling the busy spinner
* add_ace group.admin kc_menu.Admin.AdminOptions.DisableBusySpinner allow # Allow disabling the busy spinner

# Features in this menu so far

## Player Options
 
Player Toggles 
* Mobile radio - Turn on/off the mobile radio for use outside of vehicles.

Clothes menu
* Has a list of clothes to change, for now this only works for the female multiplayer ped, and it doesn't work with hats and sunglasses just yet.
* Planned feature for this: Saving/loading clothes from a file. 

## Teleport Options
* Saved locations - List the locations saved to the teleport config.
* Save location - Save current location to the config.
* Refresh Saved locations - This is supposed to refresh the saved locations but currently doesn't do anything.

## Vehicle Options
* Upgrade vehicle - Fully upgrade current vehicle if you are in one, adds max armor, engine, brakes, transmission, turbo, bulletproof tires, and most of the other upgrades if set in the code.

## Music Options
So far these don't seem to work to well, at least for me.
* Chase Parachute - Play one of the games sound tracks.
* Arena War - Play the arena war music
* Stop music - Stop any currently playing music track, doesn't do anything to the radio.

## Camera Options
* First Person Cam - Check if first person cam is enabled, displays a notification to the player, possibly move to admin menu.

## Lobby Menu
This menu allows you to switch between the hub lobby and no population lobby
* Hub - Switch to the hub lobby (Routing bucket set in routing_buckets.lua)
* No population - Switch to the no population lobby with no peds, or vehicles.

## Admin Menu
This is mostly just a test menu, but I will add admin features to it that most players shouldn't have access to.
* Enable busy spinner - Enable a test busy spinner on the screen.
* Disable busy spinner - Disable a test busy spinner on the screen.

# Links
Link to kc_util, this is required for my tests (I may remove this dependency later):
* https://github.com/kelson8/fivem-scripts/tree/main/kc_util

Link to my other test projects:
* Main Scripts repo https://github.com/kelson8/fivem-scripts
* My old menu (Uses MenuV): https://github.com/kelson8/fivem-scripts/tree/main/kc_menu

# Credits
BerkieBb and bMenu on GitHub for some teleport functions:
* https://github.com/BerkieBb/bMenu

# License
This project is Licensed under the GPLV3 license

Anyone is welcome to use this code, please give credit if you do.