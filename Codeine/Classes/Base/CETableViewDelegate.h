/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CETableView;

@protocol CETableViewDelegate< NSTableViewDelegate >

@optional

- ( BOOL )tableView: ( CETableView * )view shouldClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
- ( void )tableView: ( CETableView * )view willClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
- ( void )tableView: ( CETableView * )view didClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
- ( BOOL )tableView: ( CETableView * )view shouldDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
- ( void )tableView: ( CETableView * )view willDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
- ( void )tableView: ( CETableView * )view didDoubleClickOnRow: ( NSInteger )row atPoint: ( NSPoint )point event: ( NSEvent * )e;
- ( BOOL )tableView: ( CETableView * )view processKeyEvent: ( CEVirtualKey )key onRow: ( NSInteger )row event: ( NSEvent * )e;

@end
