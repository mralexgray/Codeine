/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CEColorTheme.h"

@implementation CEPreferencesFontsAndColorsOptionsViewController( Private )

- ( void )updateView
{
    NSString      * font;
    CEPreferences * prefs;
    
    prefs = [ CEPreferences sharedInstance ];
    font  = [ NSString stringWithFormat: @"%@ - %.01f", [ prefs fontName ], [ prefs fontSize ] ];
    
    [ _fontTextField setStringValue: font ];
    
    _tableView.backgroundColor = [ prefs backgroundColor ];
    
    [ _tableView reloadData ];
}

- ( void )getColorThemes
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

@end
