/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEFilesOutlineView;

@protocol CEFilesOutlineViewDelegate < NSOutlineViewDelegate >

@optional
    
    - ( BOOL )outlineView: ( CEFilesOutlineView * )view shouldClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
    - ( void )outlineView: ( CEFilesOutlineView * )view willClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
    - ( void )outlineView: ( CEFilesOutlineView * )view didClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
    - ( BOOL )outlineView: ( CEFilesOutlineView * )view shouldDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
    - ( void )outlineView: ( CEFilesOutlineView * )view willDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
    - ( void )outlineView: ( CEFilesOutlineView * )view didDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
    - ( BOOL )outlineView: ( CEFilesOutlineView * )view processKeyEvent: ( CEVirtualKey )key onRow: ( NSInteger )row event: ( NSEvent * )e;
    - ( NSMenu * )outlineView: ( CEFilesOutlineView * )view menuForRow: ( NSInteger )row;

@end
