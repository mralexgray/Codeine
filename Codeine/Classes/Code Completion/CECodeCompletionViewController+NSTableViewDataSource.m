
/* $Id$ */

#import "CECodeCompletionViewController+NSTableViewDataSource.h"

@implementation CECodeCompletionViewController( NSTableViewDataSource )

- ( NSInteger )numberOfRowsInTableView: ( NSTableView * )tableView
{

    
    return ( NSInteger )( _results.count );
}

- ( id )tableView: ( NSTableView * )tableView objectValueForTableColumn: ( NSTableColumn * )tableColumn row: ( NSInteger )row
{
    CKCompletionResult * result;
    CKCompletionChunk  * chunk;
    


    
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

    }
        
        return nil;
}

@end
