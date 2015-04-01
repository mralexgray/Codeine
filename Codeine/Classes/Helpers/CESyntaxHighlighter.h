
/* $Id$ */

@class CESourceFile;

@interface CESyntaxHighlighter : NSObject {
@protected

  NSTextView* _textView;
  CESourceFile* _sourceFile;
  NSLock* _lock;

@private

  RESERVED_IVARS(CESyntaxHighlighter, 5);
}

- (instancetype)initWithTextView:(NSTextView*)textView sourceFile:(CESourceFile*)sourceFile;
- (void)startHighlighting;
- (void)stopHighlighting;
- (void)highlight;

@end
