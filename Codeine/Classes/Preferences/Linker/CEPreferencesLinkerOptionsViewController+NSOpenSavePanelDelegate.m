
/* $Id$ */

#import "CEPreferencesLinkerOptionsViewController+NSOpenSavePanelDelegate.h"

@implementation CEPreferencesLinkerOptionsViewController( NSOpenSavePanelDelegate )

- ( BOOL )panel: ( id )sender validateURL: ( NSURL * )url error: ( NSError ** )outError
{
    NSString * path;
    BOOL       valid;
    


    
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
    }
    
    if( valid == NO )
    {
        NSBeep();
    }
    
    return valid;
}

@end
