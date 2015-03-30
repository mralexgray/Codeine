
/* $Id$ */

#import "CEPreferencesFileTypesOptionsViewController+Private.h"
#import "CEMutableOrderedDictionary.h"
#import "CEPreferences.h"
#import "CEPreferencesFileTypesAddNewViewController.h"
#import "CESourceFile.h"

@implementation CEPreferencesFileTypesOptionsViewController( Private )

- ( void )getFileTypes
{
    NSDictionary * types;
    NSArray      * keys;
    NSString     * key;
    
    RELEASE_IVAR( _fileTypes );
    
    types = [ [ CEPreferences sharedInstance ] fileTypes ];
    keys  = [ [ types allKeys ] sortedArrayUsingComparator: ^ NSComparisonResult( id obj1, id obj2 )
                {
                    NSString * type1;
                    NSString * type2;
                    
                    type1 = ( NSString * )obj1;
                    type2 = ( NSString * )obj2;
                    
                    return [ type1 compare: type2 ];
                }
            ];
    
    _fileTypes = [ [ CEMutableOrderedDictionary alloc ] initWithCapacity: keys.count ];
    
    for( key in keys )
    {
        [ _fileTypes setObject: [ types objectForKey: key ] forKey: key ];
    }
}

- ( void )didChooseFileType: ( id )sender
{

    
    if( _addNewController.fileExtension.length == 0 )
    {
        return;
    }
    
    if( _addNewController.language == CESourceFileLanguageNone )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] addFileType: _addNewController.language forExtension: _addNewController.fileExtension ];
    
    RELEASE_IVAR( _addNewController );
    
    [ self getFileTypes ];
    [ _tableView reloadData ];
}

@end
