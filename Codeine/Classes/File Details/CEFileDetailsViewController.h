
/* $Id$ */

#import "CEViewController.h"

@class CEFile;
@class CEDocument;

@interface CEFileDetailsViewController : CEViewController {
@protected

  CEFile* _file;
  NSImageView* _iconView;
  NSTextField* _nameTextField;
  NSTextField* _kindTextField;
  NSTextField* _sizeTextField;
  NSTextField* _creationDateTextField;
  NSTextField* _modificationDateTextField;
  NSTextField* _lastOpenedDateTextField;
  NSButton* _openButton;
  CEDocument* _document;

@private

  RESERVED_IVARS(CEFileDetailsViewController, 5);
}

@property (atomic, readwrite, retain) CEFile* file;
@property (nonatomic) IBOutlet NSImageView* iconView;
@property (nonatomic) IBOutlet NSTextField* nameTextField;
@property (nonatomic) IBOutlet NSTextField* kindTextField;
@property (nonatomic) IBOutlet NSTextField* sizeTextField;
@property (nonatomic) IBOutlet NSTextField* creationDateTextField;
@property (nonatomic) IBOutlet NSTextField* modificationDateTextField;
@property (nonatomic) IBOutlet NSTextField* lastOpenedDateTextField;
@property (nonatomic) IBOutlet NSButton* openButton;

- (IBAction)open:(id)sender;
- (IBAction)openWithDefaultEditor:(id)sender;
- (IBAction)showInFinder:(id)sender;
- (IBAction)preview:(id)sender;

@end
