/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface NSTextView( CE )

- ( NSUInteger )numberOfHardLines;
- ( NSUInteger )numberOfSoftLines;
- ( void )enableSoftWrap;
- ( void )disableSoftWrap;
- ( NSInteger )currentLine;
- ( NSInteger )currentColumn;

@end
