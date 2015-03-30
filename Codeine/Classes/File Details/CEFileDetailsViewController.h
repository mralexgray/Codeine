
/* $Id$ */

#import "CEViewController.h"

@class CEFile;
@class CEDocument;

@interface CEFileDetailsViewController : CEViewController {
@protected

  CEFile* _file;
  NSImageView* __weak _iconView;
  NSTextField* __weak _nameTextField;
  NSTextField* __weak _kindTextField;
  NSTextField* __weak _sizeTextField;
  NSTextField* __weak _creationDateTextField;
  NSTextField* __weak _modificationDateTextField;
  NSTextField* __weak _lastOpenedDateTextField;
  NSButton* __weak _openButton;
  CEDocument* _document;

@private

  RESERVED_IVARS(CEFileDetailsViewController, 5);
}

@property (atomic, readwrite, strong) CEFile* file;
@property (weak, nonatomic) IBOutlet NSImageView* iconView;
@property (weak, nonatomic) IBOutlet NSTextField* nameTextField;
@property (weak, nonatomic) IBOutlet NSTextField* kindTextField;
@property (weak, nonatomic) IBOutlet NSTextField* sizeTextField;
@property (weak, nonatomic) IBOutlet NSTextField* creationDateTextField;
@property (weak, nonatomic) IBOutlet NSTextField* modificationDateTextField;
@property (weak, nonatomic) IBOutlet NSTextField* lastOpenedDateTextField;
@property (weak, nonatomic) IBOutlet NSButton* openButton;

- (IBAction)open:(id)sender;
- (IBAction)openWithDefaultEditor:(id)sender;
- (IBAction)showInFinder:(id)sender;
- (IBAction)preview:(id)sender;

@end
