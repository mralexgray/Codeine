
/* $Id$ */

#import "CEAboutWindowController.h"
#import "CEBackgroundView.h"

@implementation CEAboutWindowController

@synthesize versionTextField = _versionTextField, backgroundView   = _backgroundView, iconView         = _iconView;


- ( void )awakeFromNib
{
    NSString * version;
    NSString * build;
    NSString * versionString;
    NSImage  * icon;
    CGImageRef cgImage;
    NSRect     rect;
    
    version = [ [ NSBundle mainBundle ] objectForInfoDictionaryKey: NSBundleInfoKeyCFBundleShortVersionString ];
    build   = [ [ NSBundle mainBundle ] objectForInfoDictionaryKey: NSBundleInfoKeyCFBundleVersion ];
    
    versionString = [ NSString stringWithFormat:  L10N( "AppVersion" ), version, [ build uppercaseString ] ];
    
    [ _versionTextField setStringValue: versionString ];
    [ _backgroundView setBackgroundColor: [ NSColor whiteColor ] ];
    
    icon    = [ NSImage imageNamed: @"Application" ];
    rect    = NSMakeRect( ( CGFloat )0, ( CGFloat )0, ( CGFloat )512, ( CGFloat )512 );
    cgImage = [ icon CGImageForProposedRect: &rect context: nil hints: nil ];
    icon   =[NSImage.alloc 
         initWithCGImage: cgImage size: NSMakeSize( ( CGFloat )512, ( CGFloat )512 ) ];
    
    [ _iconView setImage: icon ];
}

@end
