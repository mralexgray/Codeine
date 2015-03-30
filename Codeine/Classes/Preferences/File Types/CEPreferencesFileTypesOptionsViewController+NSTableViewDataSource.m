
/* $Id$ */

#import "CEPreferencesFileTypesOptionsViewController+NSTableViewDataSource.h"
#import "CEPreferencesFileTypesOptionsViewController+Private.h"
#import "CEPreferences.h"
#import "CEMutableOrderedDictionary.h"
#import "CESourceFile.h"
#import "CESystemIconsHelper.h"

@implementation CEPreferencesFileTypesOptionsViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{

    
    if( _fileTypes == nil )
    {
        [ self getFileTypes ];
    }
    
    return ( NSInteger )( _fileTypes.count );
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    NSString           * extension;
    CESourceFileLanguage type;
    

    
    if( _fileTypes == nil )
    {
        [ self getFileTypes ];
    }
    
    extension = [ _fileTypes keyAtIndex: ( NSUInteger )row ];
    type      = ( CESourceFileLanguage )[ ( NSNumber * )[ _fileTypes objectAtIndex: ( NSUInteger )row ] unsignedIntegerValue ];
    
    if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerColumnIconIdentifier ]  )
    {
        {
            NSImage * icon;
            
            icon = [ WORKSPACE iconForFileType: extension ];
            
            if( icon != nil )
            {
                return icon;
            }
            
            return [ [ CESystemIconsHelper sharedInstance ] iconNamed: CESystemIconGenericDocumentIcon ];
        }
    }
    else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerColumnExtensionIdentifier ] )
    {
        return [ NSString stringWithFormat: @".%@", extension ];
    }
    else if( [ [ tableColumn identifier ] isEqualToString: CEPreferencesCompilerOptionsViewControllerColumnTypeIdentifier ] )
    {
        return [ NSNumber numberWithInt: type - 1 ];
    }
    
    return nil;
}

- ( void )tableView: ( NSTableView * )tableView setObjectValue: ( id )object forTableColumn: ( NSTableColumn * )column row: ( NSInteger )row
{
    NSString           * extension;
    CESourceFileLanguage type;
    


    
    extension = [ _fileTypes keyAtIndex: ( NSUInteger )row ];
    type      = ( CESourceFileLanguage )( [ ( NSNumber * )object unsignedIntegerValue ] + 1 );
    
    [ [ CEPreferences sharedInstance ] addFileType: type forExtension: extension ];
    
    [ self getFileTypes ];
    [ _tableView reloadData ];
}

@end
