/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEEditorLayoutManager: NSLayoutManager
{
@protected
    
    BOOL _showInvisibles;
    
@private
    
    RESERVERD_IVARS( CEEditorLayoutManager , 5 );
}

@property( atomic, readwrite, assign ) BOOL showInvisibles;

@end
