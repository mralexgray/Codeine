/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEApplicationDelegate+Private.h"

@implementation CEApplicationDelegate( Private )

- ( void )installApplicationSupportFiles
{
    NSString * path;
    NSString * templatesBundlePath;
    NSString * templatesPath;
    
    path = [ FILE_MANAGER applicationSupportDirectory ];
    
    if( path == nil )
    {
        return;
    }
    
    templatesBundlePath = [ BUNDLE pathForResource: @"Templates" ofType: nil ];
    templatesPath       = [ path stringByAppendingPathComponent: [ templatesBundlePath lastPathComponent ] ];
    
    if( [ FILE_MANAGER fileExistsAtPath: templatesPath ] == NO )
    {
        [ FILE_MANAGER copyItemAtPath: templatesBundlePath toPath: templatesPath error: NULL ];
    }
}

@end
