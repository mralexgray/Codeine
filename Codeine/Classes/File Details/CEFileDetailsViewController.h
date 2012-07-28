/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CEFile;

@interface CEFileDetailsViewController: CEViewController
{
@protected
    
    CEFile      * _file;
    NSImageView * _iconView;
    NSTextField * _nameTextField;
    NSTextField * _kindTextField;
    NSTextField * _sizeTextField;
    NSTextField * _creationDateTextField;
    NSTextField * _modificationDateTextField;
    NSTextField * _lastOpenedDateTextField;
    
@private
    
    RESERVED_IVARS( CEFileDetailsViewController, 5 );
}

@property( atomic,    readwrite, retain )          CEFile      * file;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView * iconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * nameTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * kindTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * sizeTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * creationDateTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * modificationDateTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField * lastOpenedDateTextField;

- ( IBAction )showInFinder: ( id )sender;
- ( IBAction )openWithDefaultEditor: ( id )sender;
- ( IBAction )preview: ( id )sender;

@end
