/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesCompilerOptionsViewController+Private.h"
#import "CEMutableOrderedDictionary.h"
#import "CEPreferences.h"

@implementation CEPreferencesCompilerOptionsViewController( Private )

- ( void )getWarningFlags
{
    NSDictionary * flags;
    NSArray      * keys;
    NSString     * key;
    
    RELEASE_IVAR( _warningFlags );
    
    flags = [ [ CEPreferences sharedInstance ] warningFlags ];
    keys  = [ [ flags allKeys ] sortedArrayUsingComparator: ^ NSComparisonResult( id obj1, id obj2 )
                {
                    NSString * flag1;
                    NSString * flag2;
                    
                    flag1 = ( NSString * )obj1;
                    flag2 = ( NSString * )obj2;
                    
                    return [ flag1 compare: flag2 ];
                }
            ];
    
    _warningFlags = [ [ CEMutableOrderedDictionary alloc ] initWithCapacity: keys.count ];
    
    for( key in keys )
    {
        [ _warningFlags setObject: [ flags objectForKey: key ] forKey: key ];
    }
}

@end
