/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CEDocument;

FOUNDATION_EXPORT NSString * const CEDiagnosticsViewControllerTableColumnIdentifierIcon;
FOUNDATION_EXPORT NSString * const CEDiagnosticsViewControllerTableColumnIdentifierLine;
FOUNDATION_EXPORT NSString * const CEDiagnosticsViewControllerTableColumnIdentifierColumn;
FOUNDATION_EXPORT NSString * const CEDiagnosticsViewControllerTableColumnIdentifierMessage;

@interface CEDiagnosticsViewController: CEViewController
{
@protected
    
    NSTableView     * _tableView;
    CEDocument      * _document;
    NSTextView      * _textView;
    NSMutableArray  * _diagnostics;
    
@private
    
    RESERVED_IVARS( CEDiagnosticsViewController, 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTableView * tableView;
@property( atomic, readwrite, retain )             CEDocument  * document;
@property( atomic, readwrite, retain )             NSTextView  * textView;

@end
