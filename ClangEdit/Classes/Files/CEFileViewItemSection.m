/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItemSection.h"

@implementation CEFileViewItemSection

- ( id )initWithType: ( CEFileViewItemType )type name: ( NSString * )name
{
    if( ( self = [ super initWithType: type name: name ] ) )
    {}
    
    return self;
}

- ( BOOL )expandable
{
    return ( BOOL )( self.children.count > 0 );
}

- ( NSString * )displayName
{
    return L10N( [ _name cStringUsingEncoding: NSUTF8StringEncoding ] );
}

- ( id )valueForKeyPath: ( NSString * )keyPath
{
    NSRange          range;
    CEFileViewItem * item;
    NSString       * prefix;
    
    range = [ keyPath rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        for( item in _children )
        {
            if( [ item.name isEqualToString: keyPath ] )
            {
                return item;
            }
        }
    }
    else
    {
        prefix = [ keyPath substringToIndex: range.location ];
        
        for( item in _children )
        {
            if( [ item.name isEqualToString: prefix ] )
            {
                return [ item valueForKeyPath: keyPath ];
            }
        }
    }
    
    return nil;
}

@end
