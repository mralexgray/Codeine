
/* $Id$ */

#import "CEPreferencesWindowController.h"
#import "CEPreferencesWindowController+Private.h"
#import "CEPreferencesGeneralOptionsViewController.h"
#import "CEPreferencesEditorOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesLinkerOptionsViewController.h"
#import "CEPreferencesFontsAndColorsOptionsViewController.h"
#import "CEPreferencesFileTypesOptionsViewController.h"
#import "CEPreferencesUserInterfaceOptionsViewController.h"
#import "CESystemIconsHelper.h"

static NSString * const __generalOptionsItemIdentifier          = @"GeneralOptions";
static NSString * const __editorOptionsItemIdentifier           = @"EditorOptions";
static NSString * const __compilerOptionsItemIdentifier         = @"CompilerOptions";
static NSString * const __linkerOptionsItemIdentifier           = @"LinkerOptions";
static NSString * const __fontsAndColorsOptionsIdentifier       = @"FontsAndColors";
static NSString * const __fileTypesOptionsItemIdentifier        = @"FileTypesOptions";
static NSString * const __userInterfaceOptionsItemIdentifier    = @"UserInterfaceOptions";

@implementation CEPreferencesWindowController

@synthesize toolbar = _toolbar;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _generalOptionsViewController );
    RELEASE_IVAR( _editorOptionsViewController );
    RELEASE_IVAR( _compilerOptionsViewController );
    RELEASE_IVAR( _linkerOptionsViewController );
    RELEASE_IVAR( _fontsAndColorsOptionsViewController );
    RELEASE_IVAR( _fileTypesOptionsViewController );
    RELEASE_IVAR( _userInterfaceOptionsViewController );
    RELEASE_IVAR( _toolbar );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSToolbarItem * item;
    
    [ _toolbar setSelectedItemIdentifier: __generalOptionsItemIdentifier ];
    [ self showGeneralOptions: nil ];
    
    for( item in _toolbar.items )
    {
        if(      [ [ item itemIdentifier ] isEqualToString: __generalOptionsItemIdentifier        ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconGeneral ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __editorOptionsItemIdentifier         ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconClippingText ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __compilerOptionsItemIdentifier       ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconToolbarAdvanced ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __linkerOptionsItemIdentifier         ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconKEXT ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __fontsAndColorsOptionsIdentifier     ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconProfileFontAndColor ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __fileTypesOptionsItemIdentifier      ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconMultipleItemsIcon ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __userInterfaceOptionsItemIdentifier  ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconSidebarPrefs ] ]; }
    }
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( windowDidClose: ) name: NSWindowWillCloseNotification object: self.window ];
}

- ( IBAction )showGeneralOptions: ( id )sender
{

    
    if( _generalOptionsViewController == nil )
    {
        _generalOptionsViewController = [ CEPreferencesGeneralOptionsViewController new ];
    }
    
    [ self showView: _generalOptionsViewController.view ];
}

- ( IBAction )showEditorOptions: ( id )sender
{

    
    if( _editorOptionsViewController == nil )
    {
        _editorOptionsViewController = [ CEPreferencesEditorOptionsViewController new ];
    }
    
    [ self showView: _editorOptionsViewController.view ];
}

- ( IBAction )showCompilerOptions: ( id )sender
{

    
    if( _compilerOptionsViewController == nil )
    {
        _compilerOptionsViewController = [ CEPreferencesCompilerOptionsViewController new ];
    }
    
    [ self showView: _compilerOptionsViewController.view ];
}

- ( IBAction )showLinkerOptions: ( id )sender
{

    
    if( _linkerOptionsViewController == nil )
    {
        _linkerOptionsViewController = [ CEPreferencesLinkerOptionsViewController new ];
    }
    
    [ self showView: _linkerOptionsViewController.view ];
}

- ( IBAction )showFontsAndColorsOptions: ( id )sender
{

    
    if( _fontsAndColorsOptionsViewController == nil )
    {
        _fontsAndColorsOptionsViewController = [ CEPreferencesFontsAndColorsOptionsViewController new ];
    }
    
    [ self showView: _fontsAndColorsOptionsViewController.view ];
}

- ( IBAction )showFileTypesOptions: ( id )sender
{

    
    if( _fileTypesOptionsViewController == nil )
    {
        _fileTypesOptionsViewController = [ CEPreferencesFileTypesOptionsViewController new ];
    }
    
    [ self showView: _fileTypesOptionsViewController.view ];
}

- ( IBAction )showUserInterfaceOptions: ( id )sender
{

    
    if( _userInterfaceOptionsViewController == nil )
    {
        _userInterfaceOptionsViewController = [ CEPreferencesUserInterfaceOptionsViewController new ];
    }
    
    [ self showView: _userInterfaceOptionsViewController.view ];
}

@end
