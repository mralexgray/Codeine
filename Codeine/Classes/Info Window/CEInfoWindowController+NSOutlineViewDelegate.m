
/* $Id$ */

#import "CEInfoWindowController+NSOutlineViewDelegate.h"
#import "CEInfoWindowController+Private.h"
#import "CEInfoWindowCell.h"

@implementation CEInfoWindowController( NSOutlineViewDelegate )

/*
- ( NSView * )outlineView: ( NSOutlineView * )outlineView viewForTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{


    
    return item;
}
*/

- ( NSCell * )outlineView: ( NSOutlineView * )outlineView dataCellForTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{
    CEInfoWindowCell * cell;
    


    
    cell = [ [ CEInfoWindowCell alloc ] init ];
    
    cell.view = item;
    
    return [ cell autorelease ];
}

- ( void )outlineView:(NSOutlineView *)outlineView willDisplayCell: ( id )cell forTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{


    
    ( ( CEInfoWindowCell * )cell ).view = item;
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView shouldSelectItem: ( id )item
{


    
    return NO;
}

- ( CGFloat )outlineView: ( NSOutlineView * )outlineView heightOfRowByItem: ( id )item
{

    
    if( [ item isKindOfClass: [ NSView class ] ] == NO )
    {
        return 0;
    }
    
    return ( ( NSView * )item ).frame.size.height;
}

- ( void )outlineViewItemWillCollapse: ( NSNotification * )notification
{

    
    [ self resizeWindow: YES ];
}

- ( void )outlineViewItemWillExpand: ( NSNotification * )notification
{

    
    [ self resizeWindow: YES ];
}

@end
