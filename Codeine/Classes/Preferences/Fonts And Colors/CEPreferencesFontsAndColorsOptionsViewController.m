
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+Private.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferences.h"
#import "CEColorTheme.h"
#import "CEApplicationDelegate.h"

@implementation CEPreferencesFontsAndColorsOptionsViewController

@synthesize fontTextField               = _fontTextField;
@synthesize colorThemesPopUp            = _colorThemesPopUp;
@synthesize tableView                   = _tableView;

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    _tableView.delegate   = nil;
    _tableView.dataSource = nil;
    
    RELEASE_IVAR( _colorChooserViews );
    
}

- ( void )awakeFromNib
{
    [ self updateView ];
    [ NOTIFICATION_CENTER addObserver: self selector: @selector( updateView ) name: CEPreferencesNotificationValueChanged object: nil ];
    [ self getColorThemes ];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
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
    

    
    theme = [ [ _colorThemesPopUp selectedItem ] representedObject ];
    
    if( theme == nil )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] setColorsFromColorTheme: theme ];
}

- ( IBAction )restoreDefaults: ( id )sender
{
    NSAlert * alert;
    

    
    alert                   = [ NSAlert new ];
    alert.messageText       = L10N( "ResetThemeAlertTitle" );
    alert.informativeText   = L10N( "ResetThemeAlertText" );
    
    [ alert addButtonWithTitle: L10N( "OK" ) ];
    [ alert addButtonWithTitle: L10N( "Cancel" ) ];
    
    [ alert beginSheetModalForWindow: self.view.window completionHandler: ^( NSModalResponse response )
        {
            NSArray    * items;
            NSMenuItem * item;
            
            if( response == NSAlertFirstButtonReturn )
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
    ];
}

- ( IBAction )saveTheme: ( id )sender
{

}

@end
