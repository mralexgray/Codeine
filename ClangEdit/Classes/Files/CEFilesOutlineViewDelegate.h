/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEFilesOutlineView;

@protocol CEFilesOutlineViewDelegate < NSOutlineViewDelegate >

@optional
    
    - ( BOOL )outlineView: ( CEFilesOutlineView * )view shouldClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point;
    - ( void )outlineView: ( CEFilesOutlineView * )view willClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point;
    - ( void )outlineView: ( CEFilesOutlineView * )view didClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point;
    - ( NSMenu * )outlineView: ( CEFilesOutlineView * )view menuForRow: ( NSInteger )row;

@end
