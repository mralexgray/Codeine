/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesLinkerOptionsViewController+NSOpenSavePanelDelegate.h"

@implementation CEPreferencesLinkerOptionsViewController( NSOpenSavePanelDelegate )

- ( BOOL )panel: ( id )sender validateURL: ( NSURL * )url error: ( NSError ** )outError
{
    NSString * path;
    BOOL       valid;
    
    ( void )sender;
    ( void )outError;
    
    path = [ url path ];
    
    switch( _openPanelAllowedType )
    {
        case  CELinkerObjectTypeFramework:
            
            valid = [ path.pathExtension isEqualToString: @"framework" ];
            
            break;
            
        case  CELinkerObjectTypeSharedLibrary:
            
            valid = [ path.pathExtension isEqualToString: @"dylib" ];
            
            break;
            
        case  CELinkerObjectTypeStaticLibrary:
            
            valid = [ path.pathExtension isEqualToString: @"a" ];
            
            break;
            
        default:
            
            valid = NO;
            
            break;
    }
    
    if( valid == NO )
    {
        NSBeep();
    }
    
    return valid;
}

@end
