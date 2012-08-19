/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEEditorTextView;

@protocol CEEditorTextViewDelegate < NSTextViewDelegate >

@optional

- ( BOOL )textView: ( CEEditorTextView * )textView complete: ( id )sender;

@end
