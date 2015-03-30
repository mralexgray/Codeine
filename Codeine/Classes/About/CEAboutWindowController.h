
/* $Id$ */

#import "CEWindowController.h"

@class CEBackgroundView;

@interface CEAboutWindowController : CEWindowController {
@protected

  CEBackgroundView* _backgroundView;
  NSTextField* _versionTextField;
  NSImageView* _iconView;

@private

  RESERVED_IVARS(CEAboutWindowController, 5);
}

@property (nonatomic) IBOutlet CEBackgroundView* backgroundView;
@property (nonatomic) IBOutlet NSTextField* versionTextField;
@property (nonatomic) IBOutlet NSImageView* iconView;

@end
