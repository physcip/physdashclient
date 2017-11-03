#import <Foundation/Foundation.h>
#import <Webkit/WebKit.h>

// Make sure to keep the "/" at the end, otherwise the secure connection
// will fail when executing the binary inside the Application Bundle
#define DASHBOARD_URL "https://www.physcip.uni-stuttgart.de/physreg/"

@interface Window_delegate : NSObject <NSWindowDelegate>
@end

@implementation Window_delegate

-(void)windowWillClose:(id)a
{
	NSLog(@"Exiting");
	exit(0);
}
@end

@interface App_delegate : NSObject <NSApplicationDelegate>
@property (weak, nonatomic) NSWindow *_window;
@end

@implementation App_delegate

-(instancetype)init:(NSWindow*)parent_window
{
	if (self = [super init]) {
	  self._window = parent_window;
	  return self;
	}
	return nil;
}

-(void)applicationDidFinishLaunching:(NSNotification *)a_notification
{
	WebView *wb = [[WebView alloc] initWithFrame:self._window.contentView.frame];
	[self._window.contentView addSubview:wb];
	[[wb mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@DASHBOARD_URL]]];
}

@end

void start_program(void)
{
	NSApplication *app = [NSApplication sharedApplication];
	// Critical to have this so that you can add menus
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

	NSWindow *window =
	  [[NSWindow alloc]
	    initWithContentRect:NSMakeRect(0, 0, 1280, 800)
		styleMask: NSWindowStyleMaskTitled | NSWindowStyleMaskClosable 
			backing:NSBackingStoreBuffered
			  defer:NO];

	[window center];
	window.title = @"Physcip Dashboard";
	[window makeKeyAndOrderFront:window];
	[[window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
	[[window standardWindowButton:NSWindowZoomButton] setHidden:YES];

	Window_delegate *d = [Window_delegate new];
	window.delegate = d;

	App_delegate *application_delegate = [[App_delegate alloc] init:window];
	app.delegate = application_delegate;
	[app activateIgnoringOtherApps:YES];
	[app run];
}

int main(int argc, char **argv)
{
	@autoreleasepool {
	  start_program();
	}
}
