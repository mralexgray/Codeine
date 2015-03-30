
/* $Id$ */

#import "CEFilesViewItemSection.h"
#import "CEPreferences.h"

@implementation CEFilesViewItemSection

- ( id )initWithType: ( CEFilesViewItemType )type name: ( NSString * )name
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
    CEFilesViewItem * item;
    NSString       * prefix;
    
    range = [ keyPath rangeOfString: @":" ];
    
    if( range.location == NSNotFound )
    {
        for( item in self.children )
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
        
        for( item in self.children )
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
    
    if( [ self.name isEqualToString: CEFilesViewPlacesItemName ] )
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
                [ self addChild: [ CEFilesViewItem fileViewItemWithType: CEFilesViewItemTypeFS name: desktopPath ] ];
            }
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFilesViewItem fileViewItemWithType: CEFilesViewItemTypeFS name: documentsPath ] ];
            }
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFilesViewItem fileViewItemWithType: CEFilesViewItemTypeFS name: userPath ] ];
            }
            
            if( desktopPath != nil )
            {
                [ self addChild: [ CEFilesViewItem fileViewItemWithType: CEFilesViewItemTypeFS name: rootPath ] ];
            }
        }
    }
    else if( [ self.name isEqualToString: CEFilesViewBookmarksItemName ] )
    {
        {
            NSArray  * bookmarks;
            NSString * path;
            
            bookmarks = [ [ CEPreferences sharedInstance ] bookmarks ];
            
            for( path in bookmarks )
            {
                [ self addChild: [ CEFilesViewItem fileViewItemWithType: CEFilesViewItemTypeBookmark name: path ] ];
            }
        }
    }
}

- ( BOOL )isLeaf
{
    return NO;
}

@end
