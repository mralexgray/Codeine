/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CEColorTheme.h"

@implementation CEPreferencesFontsAndColorsOptionsViewController

@synthesize fontTextField               = _fontTextField;
@synthesize generalForegroundColorWell  = _generalForegroundColorWell;
@synthesize generalBackgroundColorWell  = _generalBackgroundColorWell;
@synthesize generalSelectionColorWell   = _generalSelectionColorWell;
@synthesize generalCurrentLineColorWell = _generalCurrentLineColorWell;
@synthesize sourceKeywordColorWell      = _sourceKeywordColorWell;
@synthesize sourceCommentColorWell      = _sourceCommentColorWell;
@synthesize sourceStringColorWell       = _sourceStringColorWell;
@synthesize sourcePredefinedColorWell   = _sourcePredefinedColorWell;
@synthesize colorThemesPopUp            = _colorThemesPopUp;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    RELEASE_IVAR( _fontTextField );
    RELEASE_IVAR( _generalForegroundColorWell );
    RELEASE_IVAR( _generalBackgroundColorWell );
    RELEASE_IVAR( _generalSelectionColorWell );
    RELEASE_IVAR( _generalCurrentLineColorWell );
    RELEASE_IVAR( _sourceKeywordColorWell );
    RELEASE_IVAR( _sourceCommentColorWell );
    RELEASE_IVAR( _sourceStringColorWell );
    RELEASE_IVAR( _sourcePredefinedColorWell );
    RELEASE_IVAR( _colorThemesPopUp );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ self updateView ];
    
    [ _generalForegroundColorWell   setTarget: self ];
    [ _generalBackgroundColorWell   setTarget: self ];
    [ _generalSelectionColorWell    setTarget: self ];
    [ _generalCurrentLineColorWell  setTarget: self ];
    [ _sourceKeywordColorWell       setTarget: self ];
    [ _sourceCommentColorWell       setTarget: self ];
    [ _sourceStringColorWell        setTarget: self ];
    [ _sourcePredefinedColorWell    setTarget: self ];
    
    [ _generalForegroundColorWell   setAction: @selector( updateColor: ) ];
    [ _generalBackgroundColorWell   setAction: @selector( updateColor: ) ];
    [ _generalSelectionColorWell    setAction: @selector( updateColor: ) ];
    [ _generalCurrentLineColorWell  setAction: @selector( updateColor: ) ];
    [ _sourceKeywordColorWell       setAction: @selector( updateColor: ) ];
    [ _sourceCommentColorWell       setAction: @selector( updateColor: ) ];
    [ _sourceStringColorWell        setAction: @selector( updateColor: ) ];
    [ _sourcePredefinedColorWell    setAction: @selector( updateColor: ) ];
    
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    
    {
        NSArray      * themes;
        CEColorTheme * theme;
        NSMenuItem   * item;
        
        themes = [ CEColorTheme defaultColorThemes ];
        
        for( theme in themes )
        {
            [ _colorThemesPopUp addItemWithTitle: theme.name ];
            
            item                   = [ _colorThemesPopUp itemWithTitle: theme.name ];
            item.representedObject = theme;
        }
    }
}

- ( IBAction )chooseFont: ( id )sender
{
    NSFontManager * manager;
    NSFontPanel   * panel;
    NSFont        * font;
    
    font    = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: [ [ CEPreferences sharedInstance ] fontSize ] ];
    manager = [ NSFontManager sharedFontManager ];
    panel   = [ manager fontPanel: YES ];
    
    [ manager setSelectedFont: font isMultiple: NO ];
    [ manager setDelegate: self ];
    
    [ panel makeKeyAndOrderFront: sender ];
}

- ( void )changeFont: ( id )sender
{
    NSFontManager * manager;
    NSFont        * font;
    
    if( [ sender isKindOfClass: [ NSFontManager class ] ] == NO )
    {
        return;
    }
    
    manager = ( NSFontManager * )sender;
    font    = [ manager convertFont: [ manager selectedFont ] ];
    
    [ [ CEPreferences sharedInstance ] setFontName: [ font fontName ] ];
    [ [ CEPreferences sharedInstance ] setFontSize: [ font pointSize ] ];
}

- ( IBAction )chooseColorTheme: ( id )sender
{
    CEColorTheme * theme;
    
    ( void )sender;
    
    theme = [ [ _colorThemesPopUp selectedItem ] representedObject ];
    
    if( theme == nil )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] setColorsFromColorTheme: theme ];
}

@end
