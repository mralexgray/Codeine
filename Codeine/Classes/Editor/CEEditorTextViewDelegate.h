
/* $Id$ */

@class CEEditorTextView;

@protocol CEEditorTextViewDelegate<NSTextViewDelegate>

@optional

- (BOOL)textView:(CEEditorTextView*)textView complete:(id)sender;

@end
