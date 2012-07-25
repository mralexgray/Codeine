/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"

@class CEFilesViewController;
@class CEEditorViewController;
@class CEDebugViewController;
@class CESourceFile;
@class CELanguageWindowController;
@class CEDocument;

@interface CEMainWindowController: CEWindowController
{
@protected
    
    CEFilesViewController       * _fileViewController;
    CEEditorViewController      * _editorViewController;
    CEDebugViewController       * _debugViewController;
    NSView                      * _leftView;
    NSView                      * _mainView;
    NSView                      * _bottomView;
    CELanguageWindowController  * _languageWindowController;
    NSPopUpButton               * _encodingPopUp;
    NSMutableArray              * _documents;
    CEDocument                  * _activeDocument;

    
@private
    
    RESERVERD_IVARS( CEMainWindowController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSView        * leftView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * mainView;
@property( nonatomic, readwrite, retain ) IBOutlet NSView        * bottomView;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton * encodingPopUp;
@property( nonatomic, readonly          )          NSArray       * documents;
@property( nonatomic, readwrite, retain )          CEDocument    * activeDocument;

- ( IBAction )newDocument: ( id )sender;
- ( IBAction )addBookmark: ( id )sender;
- ( IBAction )removeBookmark: ( id )sender;
- ( IBAction )clearConsole: ( id )sender;

@end
