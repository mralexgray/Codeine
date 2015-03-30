
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

- ( void )createColorChooserViews
{
    NSInteger            numViews;
    NSInteger            i;
    CEColorChooserView * view;
    
    [ _colorChooserViews release ];
    
    numViews           = [ self numberOfRowsInTableView: _tableView ];
    _colorChooserViews = [ [NSMutableArray alloc ] initWithCapacity: ( NSUInteger )numViews ];
    
    for( i = 0; i < numViews; i++ )
    {
        view = [ [ CEColorChooserView alloc ] initWithFrame: NSZeroRect ];
        
        [ _colorChooserViews addObject: view ];
        [ view release ];
    }
}

@end
