/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController+NSTableViewDelegate.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+CEColorChooserViewDelegate.h"
#import "CEPreferencesFontsAndColorsOptionsViewController+Private.h"
#import "CEColorChooserView.h"
#import "CEPreferences.h"

@implementation CEPreferencesFontsAndColorsOptionsViewController( NSTableViewDelegate )

- ( CGFloat )tableView: ( NSTableView * )tableView heightOfRow: ( NSInteger )row
{
    NSFont * font;
    NSSize   size;
    
    ( void )tableView;
    ( void )row;
    
    font = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: ( CGFloat )11 ];
    size = [ @"XXX" sizeWithAttributes: [ NSDictionary dictionaryWithObject: font forKey: NSFontAttributeName ] ];
    
    return ( size.height + 10 < ( CGFloat )27 ) ? ( CGFloat )27 : size.height + 10;
}

- ( NSView * )tableView: ( NSTableView * )tableView viewForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    ( void )tableView;
    ( void )tableColumn;
    
    if( _colorChooserViews == nil )
    {
        [ self createColorChooserViews ];
    }
    
    @try
    {
        return [ _colorChooserViews objectAtIndex: ( NSUInteger )row ];
    }
    @catch ( NSException * e )
    {
        ( void )e;
    }
    
    return nil;
}

@end
