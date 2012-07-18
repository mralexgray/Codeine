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
    
    ( void )sender;
    ( void )outError;
    
    path = [ url path ];
    
    switch( _openPanelAllowedType )
    {
        case  CELinkerObjectTypeFramework:
            
            return [ path.pathExtension isEqualToString: @"framework" ];
            
        case  CELinkerObjectTypeSharedLibrary:
            
            return [ path.pathExtension isEqualToString: @"dylib" ];
            
        case  CELinkerObjectTypeStaticLibrary:
            
            return [ path.pathExtension isEqualToString: @"a" ];
            
        default:
            
            break;
    }
    
    return NO;
}

@end
