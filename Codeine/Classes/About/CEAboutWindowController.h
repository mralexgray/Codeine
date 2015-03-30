
/* $Id$ */

#import "CEWindowController.h"

@class CEBackgroundView;

@interface CEAboutWindowController : CEWindowController {
@protected

  CEBackgroundView* __weak _backgroundView;
  NSTextField* __weak _versionTextField;
  NSImageView* __weak _iconView;

@private

  RESERVED_IVARS(CEAboutWindowController, 5);
}

@property (weak, nonatomic) IBOutlet CEBackgroundView* backgroundView;
@property (weak, nonatomic) IBOutlet NSTextField* versionTextField;
@property (weak, nonatomic) IBOutlet NSImageView* iconView;

@end
