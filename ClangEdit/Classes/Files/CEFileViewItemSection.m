/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileViewItemSection.h"
#import "CEPreferences.h"

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

- ( void )reload
{
    [ super reload ];
    
    if( [ self.name isEqualToString: CEFileViewPlacesItemName ] )
    {
        {
            NSString       * rootPath;
            NSString       * userPath;
            NSString       * desktopPath;
            NSString       * documentsPath;
            
            desktopPath     = [ NSSearchPathForDirectoriesInDomains( NSDesktopDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
            documentsPath   = [ NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0 ];
            userPath        = NSHomeDirectory();
            rootPath        = @"/";
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: desktopPath ] ];
            }
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: documentsPath ] ];
            }
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: userPath ] ];
            }
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeFS name: rootPath ] ];
            }
        }
    }
    else if( [ self.name isEqualToString: CEFileViewBookmarksItemName ] )
    {
        {
            NSArray  * bookmarks;
            NSString * path;
            
            bookmarks = [ [ CEPreferences sharedInstance ] bookmarks ];
            
            for( path in bookmarks )
            {
                [ self addChild: [ CEFileViewItem fileViewItemWithType: CEFileViewItemTypeBookmark name: path ] ];
            }
        }
    }
}

@end
