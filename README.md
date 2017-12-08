# PhysCIP Dashboard Client
`physdashclient` is a simple macOS application written in Objective-C that opens the physdash website in a WebKit view without the need to start a full-fledged web browser. Its only purpose is to make it easy for computer lab users to find the place to create new accounts, reset their password etc.

## Compilation
`physdashclient` can be compiled on any macOS device without any special requirements (apart from the usual development setup with an Objective-C compiler).
* Use `make` to compile `physdashclient`. This also creates the `physdash.app` Application Bundle.
* Use `make run` to compile and run `physdashclient`
* Use `make clean` to remove the binary and bundle files
* Use `make dmg` to create the `physdash.dmg` file to be deployed on all computer lab machines.

## Autostart and user account lockdown
In our setup, `physdashclient` has to automatically be executed as soon as anyone logs in as a user called `physreg`. Additionally, we need to make sure that this `physreg` user can only be used for account creation. For this purpose, a LaunchAgent script that takes care of auto-starting `physdash.app` and installing configuration profiles to lock down the `physreg` account is provided.

Installation:

* Create `/usr/local/share/physreg_profiles` directory
* Copy `physregaccount/physreg.appwhitelist.mobileconfig` to `/usr/local/share/physreg_profiles`. This profile contains a whitelist that takes care of restricting application access to `physdash.app` only.
* Copy `physregaccount/physreg.dock.mobileconfig` to `/usr/local/share/physreg_profiles`. This profile removes all items from the dock other than `physdash.app`.
* Copy `de.uni-stuttgart.physcip.physreg.mcx.plist` to `/Library/LaunchAgents/`. This property list contains a script that launches `physdash.app` when logging in as `physreg`. Additionally, it installs the configuration profiles (if not already present) during `physreg` login, so that will only happen during first login.

The `physregaccount/testinstall.sh` script can be used to automate this copying process for testing / development purposes. It suffices to just copy the files to these locations, the LaunchAgent property list will automatically be recognized.

*Warning:* The application whitelist profile has to contain a so-called `appID` (see [Parental Control Application Access Payload](https://developer.apple.com/library/content/featuredarticles/iPhoneConfigurationProfileRef/Introduction/Introduction.html)). This is a string that is specific to the compiled version of `physdash.app`, since it seems to contain some sort of hash of the app bundle (?). A sample `appID` string that happened to work with a specific version of `physdash.app` is provided in `physregaccount/physreg.appwhitelist.mobileconfig`. In order to retrieve the `appID` for any app bundle without using e.g. `SecCodeCopyDesignatedRequirement`, you can create a user account with parental controls enabled and restrict application access to your app bundle. You can then use `dscl` and `cat Local/Default/Users/USERNAME_HERE` to get a property list that contains `physdash.app`'s `appID`.

## Attribution
* This code is based on [Edgar Aroutiounian's Objective C++ WebKit Browser](http://hyegar.com/2016/02/26/lets-make-a-browser/) released under CC BY-NC-4.0.
* The applicaiton uses the [University of Stuttgart signet](https://commons.wikimedia.org/wiki/File:Uni_stuttgart_signet.svg) as its icon
