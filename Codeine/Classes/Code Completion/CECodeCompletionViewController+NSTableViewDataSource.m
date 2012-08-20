/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CECodeCompletionViewController+NSTableViewDataSource.h"

@implementation CECodeCompletionViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{
    ( void )tableView;
    
    return ( NSInteger )( _results.count );
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    CKCompletionResult * result;
    CKCompletionChunk  * chunk;
    
    ( void )tableView;
    ( void )tableColumn;
    
    @try
    {
        result = [ _results objectAtIndex: ( NSUInteger )row ];
        
        for( chunk in result.chunks )
        {
            if( chunk.kind == CKCompletionChunkKindTypedText )
            {
                return chunk.text;
            }
        }
    }
    @catch ( NSException * e )
    {
        ( void )e;
    }
        
        return nil;
}

@end
