/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+NSOpenSavePanelDelegate.h"

@implementation CEPreferencesCompilerOptionsViewController( NSOpenSavePanelDelegate )

- ( BOOL )panel: ( id )sender isValidFilename: ( NSString * )filename
{
    ( void )sender;
    
    if( [ [ filename pathExtension ] isEqualToString: @"framework" ] )
    {
        return YES;
    }
    
    NSBeep();
    
    return NO;
}

@end
