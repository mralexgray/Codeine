/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesWindowController.h"
#import "CEPreferencesWindowController+Private.h"
#import "CEPreferencesGeneralOptionsViewController.h"
#import "CEPreferencesEditorOptionsViewController.h"
#import "CEPreferencesCompilerOptionsViewController.h"
#import "CEPreferencesLinkerOptionsViewController.h"
#import "CEPreferencesFontsAndColorsOptionsViewController.h"
#import "CEPreferencesFileTypesOptionsViewController.h"
#import "CESystemIconsHelper.h"

static NSString * const __generalOptionsItemIdentifier          = @"GeneralOptions";
static NSString * const __editorOptionsItemIdentifier           = @"EditorOptions";
static NSString * const __compilerOptionsItemIdentifier         = @"CompilerOptions";
static NSString * const __linkerOptionsItemIdentifier           = @"LinkerOptions";
static NSString * const __fontsAndColorsOptionsViewController   = @"FontsAndColors";
static NSString * const __fileTypesOptionsItemIdentifier        = @"FileTypesOptions";

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
        else if( [ [ item itemIdentifier ] isEqualToString: __fontsAndColorsOptionsViewController ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconProfileFontAndColor ] ]; }
        else if( [ [ item itemIdentifier ] isEqualToString: __fileTypesOptionsItemIdentifier      ] ) { [ item setImage: [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconMultipleItemsIcon ] ]; }
    }
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( windowDidClose: ) name: NSWindowWillCloseNotification object: self.window ];
}

- ( IBAction )showGeneralOptions: ( id )sender
{
    ( void )sender;
    
    if( _generalOptionsViewController == nil )
    {
        _generalOptionsViewController = [ CEPreferencesGeneralOptionsViewController new ];
        
        [ _generalOptionsViewController setNextResponder: self.nextResponder ];
        [ self setNextResponder: _generalOptionsViewController ];
    }
    
    [ self showView: _generalOptionsViewController.view ];
}

- ( IBAction )showEditorOptions: ( id )sender
{
    ( void )sender;
    
    if( _editorOptionsViewController == nil )
    {
        _editorOptionsViewController = [ CEPreferencesEditorOptionsViewController new ];
        
        [ _editorOptionsViewController setNextResponder: self.nextResponder ];
        [ self setNextResponder: _editorOptionsViewController ];
    }
    
    [ self showView: _editorOptionsViewController.view ];
}

- ( IBAction )showCompilerOptions: ( id )sender
{
    ( void )sender;
    
    if( _compilerOptionsViewController == nil )
    {
        _compilerOptionsViewController = [ CEPreferencesCompilerOptionsViewController new ];
        
        [ _compilerOptionsViewController setNextResponder: self.nextResponder ];
        [ self setNextResponder: _compilerOptionsViewController ];
    }
    
    [ self showView: _compilerOptionsViewController.view ];
}

- ( IBAction )showLinkerOptions: ( id )sender
{
    ( void )sender;
    
    if( _linkerOptionsViewController == nil )
    {
        _linkerOptionsViewController = [ CEPreferencesLinkerOptionsViewController new ];
        
        [ _linkerOptionsViewController setNextResponder: self.nextResponder ];
        [ self setNextResponder: _linkerOptionsViewController ];
    }
    
    [ self showView: _linkerOptionsViewController.view ];
}

- ( IBAction )showFontsAndColorsOptions: ( id )sender
{
    ( void )sender;
    
    if( _fontsAndColorsOptionsViewController == nil )
    {
        _fontsAndColorsOptionsViewController = [ CEPreferencesFontsAndColorsOptionsViewController new ];
        
        [ _fontsAndColorsOptionsViewController setNextResponder: self.nextResponder ];
        [ self setNextResponder: _fontsAndColorsOptionsViewController ];
    }
    
    [ self showView: _fontsAndColorsOptionsViewController.view ];
}

- ( IBAction )showFileTypesOptions: ( id )sender
{
    ( void )sender;
    
    if( _fileTypesOptionsViewController == nil )
    {
        _fileTypesOptionsViewController = [ CEPreferencesFileTypesOptionsViewController new ];
        
        [ _fileTypesOptionsViewController setNextResponder: self.nextResponder ];
        [ self setNextResponder: _fileTypesOptionsViewController ];
    }
    
    [ self showView: _fileTypesOptionsViewController.view ];
}

@end
