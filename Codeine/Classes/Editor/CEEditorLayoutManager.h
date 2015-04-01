
/* $Id$ */

@interface CEEditorLayoutManager : NSLayoutManager {
@protected

  NSTextView* _textView;
  BOOL _showInvisibles;
  BOOL _showSpaces;
  CGSize _glyphSize;
  CGFloat _firstGlyphLeftMargin;

@private

  RESERVED_IVARS(CEEditorLayoutManager, 5);
}

@property (readwrite, assign) BOOL showInvisibles;
@property (readwrite, assign) BOOL showSpaces;
@property (readonly) CGSize glyphSize;
@property (readonly) CGFloat firstGlyphLeftMargin;

@end
