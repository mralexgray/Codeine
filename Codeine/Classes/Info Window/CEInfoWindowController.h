
/* $Id$ */

#import "CEWindowController.h"

@interface CEInfoWindowController : CEWindowController {
@protected

  NSString* _path;
  NSDictionary* _attributes;
  BOOL _isDirectory;
  NSOutlineView* __weak _outlineView;
  NSView* __weak _infoView;
  NSView* __weak _generalLabelView;
  NSView* __weak _iconLabelView;
  NSView* __weak _permissionsLabelView;
  NSView* __weak _generalView;
  NSView* __weak _iconView;
  NSView* __weak _permissionsView;
  NSImageView* __weak _smallIconView;
  NSImageView* __weak _largeIconView;
  NSTextField* __weak _infoNameTextField;
  NSTextField* __weak _infoSizeTextField;
  NSTextField* __weak _infoDateTextField;
  NSTextField* __weak _generalKindTextField;
  NSTextField* __weak _generalSizeTextField;
  NSTextField* __weak _generalPathTextField;
  NSTextField* __weak _generalCTimeTextField;
  NSTextField* __weak _generalMTimeTextField;
  NSTextField* __weak _permissionsReadableTextField;
  NSTextField* __weak _permissionsWriteableTextField;
  NSTextField* __weak _permissionsOwnerTextField;
  NSTextField* __weak _permissionsGroupTextField;
  NSTextField* __weak _permissionsOctalTextField;
  NSTextField* __weak _permissionsHumanTextField;

@private

  RESERVED_IVARS(CEInfoWindowController, 5);
}

@property (readonly) NSString* path;
@property (weak, nonatomic) IBOutlet NSOutlineView* outlineView;
@property (weak, nonatomic) IBOutlet NSView* infoView;
@property (weak, nonatomic) IBOutlet NSView* generalLabelView;
@property (weak, nonatomic) IBOutlet NSView* iconLabelView;
@property (weak, nonatomic) IBOutlet NSView* permissionsLabelView;
@property (weak, nonatomic) IBOutlet NSView* generalView;
@property (weak, nonatomic) IBOutlet NSView* iconView;
@property (weak, nonatomic) IBOutlet NSView* permissionsView;
@property (weak, nonatomic) IBOutlet NSImageView* smallIconView;
@property (weak, nonatomic) IBOutlet NSImageView* largeIconView;
@property (weak, nonatomic) IBOutlet NSTextField* infoNameTextField;
@property (weak, nonatomic) IBOutlet NSTextField* infoSizeTextField;
@property (weak, nonatomic) IBOutlet NSTextField* infoDateTextField;
@property (weak, nonatomic) IBOutlet NSTextField* generalKindTextField;
@property (weak, nonatomic) IBOutlet NSTextField* generalSizeTextField;
@property (weak, nonatomic) IBOutlet NSTextField* generalPathTextField;
@property (weak, nonatomic) IBOutlet NSTextField* generalCTimeTextField;
@property (weak, nonatomic) IBOutlet NSTextField* generalMTimeTextField;
@property (weak, nonatomic) IBOutlet NSTextField* permissionsReadableTextField;
@property (weak, nonatomic) IBOutlet NSTextField* permissionsWriteableTextField;
@property (weak, nonatomic) IBOutlet NSTextField* permissionsOwnerTextField;
@property (weak, nonatomic) IBOutlet NSTextField* permissionsGroupTextField;
@property (weak, nonatomic) IBOutlet NSTextField* permissionsOctalTextField;
@property (weak, nonatomic) IBOutlet NSTextField* permissionsHumanTextField;

- (instancetype)initWithPath:(NSString*)path;

@end
