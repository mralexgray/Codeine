
/* $Id$ */

#import "CEWindowController.h"

@interface CEInfoWindowController : CEWindowController {
@protected

  NSString* _path;
  NSDictionary* _attributes;
  BOOL _isDirectory;
  NSOutlineView* _outlineView;
  NSView* _infoView;
  NSView* _generalLabelView;
  NSView* _iconLabelView;
  NSView* _permissionsLabelView;
  NSView* _generalView;
  NSView* _iconView;
  NSView* _permissionsView;
  NSImageView* _smallIconView;
  NSImageView* _largeIconView;
  NSTextField* _infoNameTextField;
  NSTextField* _infoSizeTextField;
  NSTextField* _infoDateTextField;
  NSTextField* _generalKindTextField;
  NSTextField* _generalSizeTextField;
  NSTextField* _generalPathTextField;
  NSTextField* _generalCTimeTextField;
  NSTextField* _generalMTimeTextField;
  NSTextField* _permissionsReadableTextField;
  NSTextField* _permissionsWriteableTextField;
  NSTextField* _permissionsOwnerTextField;
  NSTextField* _permissionsGroupTextField;
  NSTextField* _permissionsOctalTextField;
  NSTextField* _permissionsHumanTextField;

@private

  RESERVED_IVARS(CEInfoWindowController, 5);
}

@property (atomic, readonly) NSString* path;
@property (nonatomic) IBOutlet NSOutlineView* outlineView;
@property (nonatomic) IBOutlet NSView* infoView;
@property (nonatomic) IBOutlet NSView* generalLabelView;
@property (nonatomic) IBOutlet NSView* iconLabelView;
@property (nonatomic) IBOutlet NSView* permissionsLabelView;
@property (nonatomic) IBOutlet NSView* generalView;
@property (nonatomic) IBOutlet NSView* iconView;
@property (nonatomic) IBOutlet NSView* permissionsView;
@property (nonatomic) IBOutlet NSImageView* smallIconView;
@property (nonatomic) IBOutlet NSImageView* largeIconView;
@property (nonatomic) IBOutlet NSTextField* infoNameTextField;
@property (nonatomic) IBOutlet NSTextField* infoSizeTextField;
@property (nonatomic) IBOutlet NSTextField* infoDateTextField;
@property (nonatomic) IBOutlet NSTextField* generalKindTextField;
@property (nonatomic) IBOutlet NSTextField* generalSizeTextField;
@property (nonatomic) IBOutlet NSTextField* generalPathTextField;
@property (nonatomic) IBOutlet NSTextField* generalCTimeTextField;
@property (nonatomic) IBOutlet NSTextField* generalMTimeTextField;
@property (nonatomic) IBOutlet NSTextField* permissionsReadableTextField;
@property (nonatomic) IBOutlet NSTextField* permissionsWriteableTextField;
@property (nonatomic) IBOutlet NSTextField* permissionsOwnerTextField;
@property (nonatomic) IBOutlet NSTextField* permissionsGroupTextField;
@property (nonatomic) IBOutlet NSTextField* permissionsOctalTextField;
@property (nonatomic) IBOutlet NSTextField* permissionsHumanTextField;

- (id)initWithPath:(NSString*)path;

@end
