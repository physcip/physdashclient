# PhysCIP Dashboard Client
`physdashclient` is a simple macOS application written in Objective-C that opens the physdash website in a WebKit view without the need to start a full-fledged web browser. Its only purpose is to make it easy for computer lab users to find the place to create new accounts, reset their password etc.

## Compilation
`physdashclient` can be compiled on any macOS device without any special requirements (apart from the usual development setup with an Objective-C compiler).
* Use `make` to compile `physdashclient`. This also creates the `physdash.app` Application Bundle.
* Use `make run` to compile and run `physdashclient`
* Use `make clean` to remove the binary and bundle files
* Use `make dmg` to create the `physdash.dmg` file to be deployed on all computer lab machines.

## Attribution
* This code is based on [Edgar Aroutiounian's Objective C++ WebKit Browser](http://hyegar.com/2016/02/26/lets-make-a-browser/) released under CC BY-NC-4.0.
* The applicaiton uses the [University of Stuttgart signet](https://commons.wikimedia.org/wiki/File:Uni_stuttgart_signet.svg) as its icon
