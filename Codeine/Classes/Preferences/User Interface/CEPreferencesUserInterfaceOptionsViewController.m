
/* $Id$ */

#import "CEPreferencesUserInterfaceOptionsViewController.h"
#import "CEPreferences.h"

@implementation CEPreferencesUserInterfaceOptionsViewController

@synthesize fullScreenStyleMatrix = _fullScreenStyleMatrix;

- ( void )dealloc
{
    RELEASE_IVAR( _fullScreenStyleMatrix );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ _fullScreenStyleMatrix selectCellWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] fullScreenStyle ] ];
}

- ( IBAction )setFullScreenStyle: ( id )sender
{
    NSButtonCell * cell;
    

    
    cell = [ _fullScreenStyleMatrix selectedCell ];
    
    [ [ CEPreferences sharedInstance ] setFullScreenStyle: ( CEPreferencesFullScreenStyle )cell.tag ];
}

@end
