/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController+Private.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+CEColorChooserViewDelegate.h"
#import "CEPreferences.h"
#import "CEColorTheme.h"
#import "CEApplicationDelegate.h"
#import "CEColorChooserView.h"

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

- ( void )resetAlertDidEnd: ( NSAlert * )alert returnCode: ( NSInteger )returnCode contextInfo: ( void * )contextInfo
{
    NSArray    * items;
    NSMenuItem * item;
    
    ( void )alert;
    ( void )contextInfo;
    
    if( returnCode == NSAlertDefaultReturn )
    {
        items = [ _colorThemesPopUp itemArray ];
        
        for( item in items )
        {
            if( [ item.representedObject isKindOfClass: [ CEColorTheme class ] ] == YES )
            {
                [ _colorThemesPopUp removeItemWithTitle: item.title ];
            }
        }
        
        [ [ CEApplicationDelegate sharedInstance ] resetColorThemes: nil ];
        [ self getColorThemes ];
        [ [ CEPreferences sharedInstance ] setColorsFromColorTheme: [ CEColorTheme defaultColorThemeWithName: @"Codeine - Dark" ] ];
    }
}

- ( void )createColorChooserViews
{
    NSInteger            numViews;
    NSInteger            i;
    CEColorChooserView * view;
    NSColor            * backgroundColor;
    NSColor            * foregroundColor;
    NSColor            * color;
    NSString           * title;
    id                   key;
    
    [ _colorChooserViews release ];
    
    numViews           = [ self numberOfRowsInTableView: _tableView ];
    _colorChooserViews = [ [NSMutableArray alloc ] initWithCapacity: ( NSUInteger )numViews ];
    
    for( i = 0; i < numViews; i++ )
    {
        switch( i )
        {
            case 0:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
                color           = [ [ CEPreferences sharedInstance ] backgroundColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelBackground" );
                key             = CEPreferencesKeyBackgroundColor;
                break;
                
            case 1:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
                color           = [ [ CEPreferences sharedInstance ] foregroundColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelForeground" );
                key             = CEPreferencesKeyForegoundColor;
                break;
                
            case 2:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
                color           = [ [ CEPreferences sharedInstance ] selectionColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] selectionColor ];
                title           = L10N( "ColorLabelSelection" );
                key             = CEPreferencesKeySelectionColor;
                break;
                
            case 3:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
                color           = [ [ CEPreferences sharedInstance ] currentLineColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] currentLineColor ];
                title           = L10N( "ColorLabelCurrentLine" );
                key             = CEPreferencesKeyCurrentLineColor;
                break;
                
            case 4:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] invisibleColor ];
                color           = [ [ CEPreferences sharedInstance ] invisibleColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelInvisible" );
                key             = CEPreferencesKeyInvisibleColor;
                break;
                
            case 5:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] keywordColor ];
                color           = [ [ CEPreferences sharedInstance ] keywordColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelKeyword" );
                key             = CEPreferencesKeyKeywordColor;
                break;
                
            case 6:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] preprocessorColor ];
                color           = [ [ CEPreferences sharedInstance ] preprocessorColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelPreprocessor" );
                key             = CEPreferencesKeyPreprocessorColor;
                break;
                
            case 7:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] predefinedColor ];
                color           = [ [ CEPreferences sharedInstance ] predefinedColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelPredefined" );
                key             = CEPreferencesKeyPredefinedColor;
                break;
                
            case 8:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] projectColor ];
                color           = [ [ CEPreferences sharedInstance ] projectColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelProject" );
                key             = CEPreferencesKeyProjectColor;
                break;
                
            case 9:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] numberColor ];
                color           = [ [ CEPreferences sharedInstance ] numberColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelNumber" );
                key             = CEPreferencesKeyNumberColor;
                break;
                
            case 10:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] stringColor ];
                color           = [ [ CEPreferences sharedInstance ] stringColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelString" );
                key             = CEPreferencesKeyStringColor;
                break;
                
            case 11:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] commentColor ];
                color           = [ [ CEPreferences sharedInstance ] commentColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "ColorLabelComment" );
                key             = CEPreferencesKeyCommentColor;
                break;
                
            default:
                
                foregroundColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
                color           = [ [ CEPreferences sharedInstance ] foregroundColor ];
                backgroundColor = [ [ CEPreferences sharedInstance ] backgroundColor ];
                title           = L10N( "N/A" );
                key             = nil;
                break;
        }
    
        view = [ [ CEColorChooserView alloc ] initWithFrame: NSZeroRect ];
        
        view.foregroundColor    = foregroundColor;
        view.backgroundColor    = backgroundColor;
        view.color              = color;
        view.title              = title;
        view.font               = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: ( CGFloat )11 ];
        view.delegate           = self;
        view.representedObject  = key;
        
        [ _colorChooserViews addObject: view ];
        [ view release ];
    }
}

@end
