/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEFileOutlineView;

@protocol CEFileOutlineViewDelegate < NSOutlineViewDelegate >

@optional
    
    - ( BOOL )outlineView: ( CEFileOutlineView * )view shouldClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point;
    - ( void )outlineView: ( CEFileOutlineView * )view willClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point;
    - ( void )outlineView: ( CEFileOutlineView * )view didClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point;

@end
