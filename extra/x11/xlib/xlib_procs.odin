//+build linux, openbsd, freebsd
package xlib

/* ----  X11/Xlib.h ---------------------------------------------------------*/

_Xdebug: ^i32
// Free data allocated by Xlib
XFree              : proc "c" (ptr: rawptr)
// Opening/closing a display
XOpenDisplay       : proc "c" (name: cstring) -> ^Display
XCloseDisplay      : proc "c" (display: ^Display)
XSetCloseDownMode  : proc "c" (display: ^Display, mode: CloseMode)
// Generate a no-op request
XNoOp              : proc "c" (display: ^Display)
// Display macros (connection)
XConnectionNumber  : proc "c" (display: ^Display) -> i32
XExtendedMaxRequestSize : proc "c" (display: ^Display) -> int
XMaxRequestSize    : proc "c" (display: ^Display) -> int
XLastKnownRequestProcessed : proc "c" (display: ^Display) -> uint
XNextRequest       : proc "c" (display: ^Display) -> uint
XProtocolVersion   : proc "c" (display: ^Display) -> i32
XProtocolRevision  : proc "c" (display: ^Display) -> i32
XQLength           : proc "c" (display: ^Display) -> i32
XServerVendor      : proc "c" (display: ^Display) -> cstring
XVendorRelease     : proc "c" (display: ^Display) -> i32
// Display macros (display properties)
XBlackPixel        : proc "c" (display: ^Display, screen_no: i32) -> uint
XWhitePixel        : proc "c" (display: ^Display, screen_no: i32) -> uint
XListDepths        : proc "c" (display: ^Display, screen_no: i32, count: ^i32) -> [^]i32
XDisplayCells      : proc "c" (display: ^Display, screen_no: i32) -> i32
XDisplayPlanes     : proc "c" (display: ^Display, screen_no: i32) -> i32
XScreenOfDisplay   : proc "c" (display: ^Display, screen_no: i32) -> ^Screen
XDisplayString     : proc "c" (display: ^Display) -> cstring
// Display macros (defaults)
XDefaultColormap   : proc "c" (display: ^Display, screen_no: i32) -> Colormap
XDefaultDepth      : proc "c" (display: ^Display) -> i32
XDefaultGC         : proc "c" (display: ^Display, screen_no: i32) -> GC
XDefaultRootWindow : proc "c" (display: ^Display) -> Window
XDefaultScreen     : proc "c" (display: ^Display) -> i32
XDefaultVisual     : proc "c" (display: ^Display, screen_no: i32) -> ^Visual
XDefaultScreenOfDisplay : proc "c" (display: ^Display) -> ^Screen
// Display macros (other)
XRootWindow        : proc "c" (display: ^Display, screen_no: i32) -> Window
XScreenCount       : proc "c" (display: ^Display) -> i32
// Display image format macros
XListPixmapFormats : proc "c" (display: ^Display, count: ^i32) -> [^]XPixmapFormatValues
XImageByteOrder    : proc "c" (display: ^Display) -> ByteOrder
XBitmapUnit        : proc "c" (display: ^Display) -> i32
XBitmapBitOrder    : proc "c" (display: ^Display) -> ByteOrder
XBitmapPad         : proc "c" (display: ^Display) -> i32
XDisplayHeight     : proc "c" (display: ^Display, screen_no: i32) -> i32
XDisplayHeightMM   : proc "c" (display: ^Display, screen_no: i32) -> i32
XDisplayWidth      : proc "c" (display: ^Display, screen_no: i32) -> i32
XDisplayWidthMM    : proc "c" (display: ^Display, screen_no: i32) -> i32
// Screen macros
XBlackPixelOfScreen : proc "c" (screen: ^Screen) -> uint
XWhitePixelOfScreen : proc "c" (screen: ^Screen) -> uint
XCellsOfScreen       : proc "c" (screen: ^Screen) -> i32
XDefaultColormapOfScreen : proc "c" (screen: ^Screen) -> Colormap
XDefaultDepthOfScreen    : proc "c" (screen: ^Screen) -> i32
XDefaultGCOfScreen       : proc "c" (screen: ^Screen) -> GC
XDefaultVisualOfScreen   : proc "c" (screen: ^Screen) -> ^Visual
XDoesBackingStore    : proc "c" (screen: ^Screen) -> BackingStore
XDoesSaveUnders      : proc "c" (screen: ^Screen) -> b32
XDisplayOfScreen     : proc "c" (screen: ^Screen) -> ^Display
XScreenNumberOfScreen : proc "c" (screen: ^Screen) -> i32
XEventMaskOfScreen   : proc "c" (screen: ^Screen) -> EventMask
XWidthOfScreen       : proc "c" (screen: ^Screen) -> i32
XHeightOfScreen      : proc "c" (screen: ^Screen) -> i32
XWidthMMOfScreen     : proc "c" (screen: ^Screen) -> i32
XHeightMMOfScreen    : proc "c" (screen: ^Screen) -> i32
XMaxCmapsOfScreen    : proc "c" (screen: ^Screen) -> i32
XMinCmapsOfScreen    : proc "c" (screen: ^Screen) -> i32
XPlanesOfScreen      : proc "c" (screen: ^Screen) -> i32
XRootWindowOfScreen  : proc "c" (screen: ^Screen) -> Window
// Threading functions
XInitThreads         : proc "c" () -> Status
XLockDisplay         : proc "c" (display: ^Display)
XUnlockDisplay       : proc "c" (display: ^Display)
// Internal connections
XAddConnectionWatch  : proc "c" (
	display:   ^Display,
	procedure: XConnectionWatchProc,
	data:      rawptr,
	) -> Status
XRemoveConnectionWatch : proc "c" (
	display:   ^Display,
	procedure: XConnectionWatchProc,
	data:      rawptr,
	) -> Status
XProcessInternalConnection : proc "c" (
	display:   ^Display,
	fd:        i32,
	)
XInternalConnectionNumbers : proc "c" (
	display:   ^Display,
	fds:       ^[^]i32,
	count:     ^i32,
	) -> Status
// Windows functions
XVisualIDFromVisual : proc "c" (visual: ^Visual) -> VisualID
// Windows: creation/destruction
XCreateWindow : proc "c" (
	display:   ^Display,
	parent:    Window,
	x:         i32,
	y:         i32,
	width:     u32,
	height:    u32,
	bordersz:  u32,
	depth:     i32,
	class:     WindowClass,
	visual:    ^Visual,
	attr_mask: WindowAttributeMask,
	attr:      ^XSetWindowAttributes,
	) -> Window
XCreateSimpleWindow : proc "c" (
	display:   ^Display,
	parent:    Window,
	x:         i32,
	y:         i32,
	width:     u32,
	height:    u32,
	bordersz:  u32,
	border:    int,
	bg:        int,
	) -> Window
XDestroyWindow     : proc "c" (display: ^Display, window: Window)
XDestroySubwindows : proc "c" (display: ^Display, window: Window)
// Windows: mapping/unmapping
XMapWindow         : proc "c" (display: ^Display, window: Window)
XMapRaised         : proc "c" (display: ^Display, window: Window)
XMapSubwindows     : proc "c" (display: ^Display, window: Window)
XUnmapWindow       : proc "c" (display: ^Display, window: Window)
XUnmapSubwindows   : proc "c" (display: ^Display, window: Window)
// Windows: configuring
XConfigureWindow : proc "c" (
	display: ^Display,
	window:  Window,
	mask:    WindowChangesMask,
	values:  XWindowChanges,
	)
XMoveWindow : proc "c" (
	display: ^Display,
	window:  Window,
	x:       i32,
	y:       i32,
	)
XResizeWindow : proc "c" (
	display: ^Display,
	window:  Window,
	width:   u32,
	height:  u32,
	)
XMoveResizeWindow : proc "c" (
	display: ^Display,
	window:  Window,
	x:       i32,
	y:       i32,
	width:   u32,
	height:  u32,
	)
XSetWindowBorderWidth : proc "c" (
	display: ^Display,
	window:  Window,
	width:   u32,
	)
// Window: changing stacking order
XRaiseWindow : proc "c" (display: ^Display, window: Window)
XLowerWindow : proc "c" (display: ^Display, window: Window)
XCirculateSubwindows : proc "c" (display: ^Display, window: Window, direction: CirculationDirection)
XCirculateSubwindowsUp : proc "c" (display: ^Display, window: Window)
XCirculateSubwindowsDown : proc "c" (display: ^Display, window: Window)
XRestackWindows : proc "c" (display: ^Display, windows: [^]Window, nwindows: i32)
// Window: changing attributes
XChangeWindowAttributes : proc "c" (
	display:   ^Display,
	window:    Window,
	attr_mask: WindowAttributeMask,
	attr:      XWindowAttributes,
	)
XSetWindowBackground : proc "c" (
	display:   ^Display,
	window:    Window,
	pixel:     uint,
	)
XSetWindowBackgroundPixmap : proc "c" (
	display:   ^Display,
	window:    Window,
	pixmap:    Pixmap,
	)
XSetWindowColormap : proc "c" (
	display:   ^Display,
	window:    Window,
	colormap:  Colormap,
	)
XDefineCursor : proc "c" (
	display:   ^Display,
	window:    Window,
	cursor:    Cursor,
	)
XUndefineCursor : proc "c" (
	display:   ^Display,
	window:    Window,
	)
// Windows: querying information
XQueryTree : proc "c" (
	display:   ^Display,
	window:    Window,
	root:      ^Window,
	parent:    ^Window,
	children:  ^[^]Window,
	nchildren: ^u32,
	) -> Status
XGetWindowAttributes : proc "c" (
	display: ^Display,
	window:  Window,
	attr:    ^XWindowAttributes,
	)
XGetGeometry : proc "c" (
	display:   ^Display,
	drawable:  Drawable,
	root:      ^Window,
	x:         ^i32,
	y:         ^i32,
	width:     ^u32,
	height:    ^u32,
	border_sz: ^u32,
	depth:     ^u32,
	) -> Status
// Windows: translating screen coordinates
XTranslateCoordinates : proc "c" (
	display: ^Display,
	src_window: Window,
	dst_window: Window,
	src_x:      i32,
	src_y:      i32,
	dst_x:      ^i32,
	dst_y:      ^i32,
	) -> b32
XQueryPointer : proc "c" (
	display: ^Display,
	window:  Window,
	root:    ^Window,
	child:   ^Window,
	root_x:  ^i32,
	root_y:  ^i32,
	x:       ^i32,
	y:       ^i32,
	mask:    ^KeyMask,
	) -> b32
// Atoms
XInternAtom : proc "c" (
	display:  ^Display,
	name:     cstring,
	existing: b32,
	) -> Atom
XInternAtoms : proc "c" (
	display: ^Display,
	names:   [^]cstring,
	count:   i32,
	atoms:   [^]Atom,
	) -> Status
XGetAtomName : proc "c" (
	display: ^Display,
	atom:    Atom,
	) -> cstring
XGetAtomNames : proc "c" (
	display: ^Display,
	atoms:   [^]Atom,
	count:   i32,
	names:   [^]cstring,
	) -> Status
// Windows: Obtaining and changing properties
XGetWindowProperty : proc "c" (
	display:     ^Display,
	window:      Window,
	property:    Atom,
	long_offs:   int,
	long_len:    int,
	delete:      b32,
	req_type:    Atom,
	act_type:    [^]Atom,
	act_format:  [^]i32,
	nitems:      [^]uint,
	bytes_after: [^]uint,
	props:       ^rawptr,
) -> i32
XListProperties : proc "c" (
	display:     ^Display,
	window:      Window,
	num:         ^i32,
	) -> [^]Atom
XChangeProperty : proc "c" (
	display:     ^Display,
	window:      Window,
	property:    Atom,
	type:        Atom,
	format:      i32,
	mode:        i32,
	data:        rawptr,
	count:       i32,
	)
XRotateWindowProperties : proc "c" (
	display:     ^Display,
	window:      Window,
	props:       [^]Atom,
	nprops:      i32,
	npos:        i32,
	)
XDeleteProperty : proc "c" (
	display:     ^Display,
	window:      Window,
	prop:        Atom,
	)
// Selections
XSetSelectionOwner : proc "c" (
	display:     ^Display,
	selection:   Atom,
	owber:       Window,
	time:        Time,
	)
XGetSelectionOwner : proc "c" (
	display:     ^Display,
	selection:   Atom,
	) -> Window
XConvertSelection : proc "c" (
	display:     ^Display,
	selection:   Atom,
	target:      Atom,
	property:    Atom,
	requestor:   Window,
	time:        Time,
	)
// Creating and freeing pixmaps
XCreatePixmap : proc "c" (
	display:   ^Display,
	drawable:  Drawable,
	width:     u32,
	height:    u32,
	depth:     u32,
	) -> Pixmap
XFreePixmap : proc "c" (
	display:   ^Display,
	pixmap:    Pixmap,
	)
// Creating recoloring and freeing cursors
XCreateFontCursor : proc "c" (
	display:   ^Display,
	shape:     CursorShape,
	) -> Cursor
XCreateGlyphCursor : proc "c" (
	display:   ^Display,
	src_font:  Font,
	mask_font: Font,
	src_char:  u32,
	mask_char: u32,
	fg:        ^XColor,
	bg:        ^XColor,
	) -> Cursor
XCreatePixmapCursor : proc "c" (
	display:   ^Display,
	source:    Pixmap,
	mask:      Pixmap,
	fg:        XColor,
	bg:        ^XColor,
	x:         u32,
	y:         u32,
	) -> Cursor
XQueryBestCursor : proc "c" (
	display:    ^Display,
	drawable:   Drawable,
	width:      u32,
	height:     u32,
	out_width:  ^u32,
	out_height: ^u32,
	) -> Status
XRecolorCursor : proc "c" (
	display:    ^Display,
	cursor:     Cursor,
	fg:         ^XColor,
	bg:         ^XColor,
	)
XFreeCursor : proc "c" (display: ^Display, cursor: Cursor)
// Creation/destruction of colormaps
XCreateColormap : proc "c" (
	display:  ^Display,
	window:   Window,
	visual:   ^Visual,
	alloc:    ColormapAlloc,
	) -> Colormap
XCopyColormapAndFree : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	) -> Colormap
XFreeColormap : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	)
// Mapping color names to values
XLookupColor : proc "c" (
	display:  ^Display,
	colomap:  Colormap,
	name:     cstring,
	exact:    ^XColor,
	screen:   ^XColor,
	) -> Status
XcmsLookupColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	name:     cstring,
	exact:    XcmsColor,
	screen:   XcmsColor,
	format:   XcmsColorFormat,
	) -> Status
// Allocating and freeing color cells
XAllocColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	screen:   ^XColor,
	) -> Status
XcmsAllocColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    ^XcmsColor,
	format:   XcmsColorFormat,
	) -> Status
XAllocNamedColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	name:     cstring,
	screen:   ^XColor,
	exact:    ^XColor,
	) -> Status
XcmsAllocNamedColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	name:     cstring,
	screen:   ^XcmsColor,
	exact:    ^XcmsColor,
	format:   XcmsColorFormat,
	) -> Status
XAllocColorCells : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	contig:   b32,
	pmasks:   [^]uint,
	np:       u32,
	pixels:   [^]uint,
	npixels:  u32,
	) -> Status
XAllocColorPlanes : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	contig:   b32,
	pixels:   [^]uint,
	ncolors:  i32,
	nreds:    i32,
	ngreens:  i32,
	nblues:   i32,
	rmask:    [^]uint,
	gmask:    [^]uint,
	bmask:    [^]uint,
	) -> Status
XFreeColors : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	pixels:   [^]uint,
	npixels:  i32,
	planes:   uint,
	)
// Modifying and querying colormap cells
XStoreColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    ^XColor,
	)
XStoreColors : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    [^]XColor,
	ncolors:  i32,
	)
XcmsStoreColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    ^XcmsColor,
	) -> Status
XcmsStoreColors : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	colors:   [^]XcmsColor,
	ncolors:  XcmsColor,
	cflags:   [^]b32,
	) -> Status
XStoreNamedColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	name:     cstring,
	pixel:    uint,
	flags:    ColorFlags,
	)
XQueryColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    ^XColor,
	)
XQueryColors : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	colors:   [^]XColor,
	ncolors:  i32,
	)
XcmsQueryColor : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    ^XcmsColor,
	format:   XcmsColorFormat,
	) -> Status
XcmsQueryColors : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	color:    [^]XcmsColor,
	ncolors:  i32,
	format:   XcmsColorFormat,
	) -> Status
// Getting and setting the color conversion context (CCC) of a colormap
XcmsCCCOfColormap : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	) -> XcmsCCC
XcmsSetCCCOfColormap : proc "c" (
	display:  ^Display,
	colormap: Colormap,
	ccc:      XcmsCCC) -> XcmsCCC
XcmsDefaultCCC : proc "c" (display:   ^Display, screen_no: i32) -> XcmsCCC
// Color conversion context macros
XcmsDisplayOfCCC : proc "c" (ccc: XcmsCCC) -> ^Display
XcmsVisualOfCCC  : proc "c" (ccc: XcmsCCC) -> ^Visual
XcmsScreenNumberOfCCC : proc "c" (ccc: XcmsCCC) -> i32
XcmsScreenWhitePointOfCCC : proc "c" (ccc: XcmsCCC) -> XcmsColor
XcmsClientWhitePointOfCCC : proc "c" (ccc: XcmsCCC) -> XcmsColor
// Modifying the attributes of color conversion context
XcmsSetWhitePoint : proc "c" (
	ccc: XcmsCCC,
	color: ^XcmsColor,
	) -> Status
XcmsSetCompressionProc : proc "c" (
	ccc: XcmsCCC,
	cproc: XcmsCompressionProc,
	data: rawptr,
	) -> XcmsCompressionProc
XcmsSetWhiteAdjustProc : proc "c" (
	ccc: XcmsCCC,
	aproc: XcmsWhiteAdjustProc,
	data: rawptr,
	) -> XcmsWhiteAdjustProc
// Creating and freeing the color conversion context
XcmsCreateCCC : proc "c" (
	display: ^Display,
	screen_no: i32,
	visual: ^Visual,
	white_point: ^XcmsColor,
	cproc: XcmsCompressionProc,
	cdata: rawptr,
	aproc: XcmsWhiteAdjustProc,
	adata: rawptr,
	) -> XcmsCCC
XcmsFreeCCC : proc "c" (ccc: XcmsCCC)
// Converting between colorspaces
XcmsConvertColors : proc "c" (
	ccc:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	format:  XcmsColorFormat,
	cflags:  [^]b32,
	) -> Status
// Pre-defined gamut compression callbacks
XcmsCIELabClipL : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsCIELabClipab : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsCIELabClipLab : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsCIELuvClipL : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsCIELuvClipuv : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsCIELuvClipLuv : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsTekHVCClipV : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsTekHVCClipC : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
XcmsTekHVCClipVC : proc "c" (
	ctx:     XcmsCCC,
	colors:  [^]XcmsColor,
	ncolors: u32,
	index:   u32,
	flags:   [^]b32,
	) -> Status
// Pre-defined white-point adjustment procedures
XcmsCIELabWhiteShiftColors : proc "c" (
	ctx:                 XcmsCCC,
	initial_white_point: ^XcmsColor,
	target_white_point:  ^XcmsColor,
	target_format:       XcmsColorFormat,
	colors:              [^]XcmsColor,
	ncolors:             u32,
	compression:         [^]b32,
	) -> Status
XcmsCIELuvWhiteShiftColors : proc "c" (
	ctx:                 XcmsCCC,
	initial_white_point: ^XcmsColor,
	target_white_point:  ^XcmsColor,
	target_format:       XcmsColorFormat,
	colors:              [^]XcmsColor,
	ncolors:             u32,
	compression:         [^]b32,
	) -> Status
XcmsTekHVCWhiteShiftColors : proc "c" (
	ctx:                 XcmsCCC,
	initial_white_point: ^XcmsColor,
	target_white_point:  ^XcmsColor,
	target_format:       XcmsColorFormat,
	colors:              [^]XcmsColor,
	ncolors:             u32,
	compression:         [^]b32,
	) -> Status
// Color querying
XcmsQueryBlack : proc "c" (
	ccc:    XcmsCCC,
	format: XcmsColorFormat,
	color:  ^XcmsColor,
	) -> Status
XcmsQueryBlue : proc "c" (
	ccc:    XcmsCCC,
	format: XcmsColorFormat,
	color:  ^XcmsColor,
	) -> Status
XcmsQueryGreen : proc "c" (
	ccc:    XcmsCCC,
	format: XcmsColorFormat,
	color:  ^XcmsColor,
	) -> Status
XcmsQueryRed : proc "c" (
	ccc:    XcmsCCC,
	format: XcmsColorFormat,
	color:  ^XcmsColor,
	) -> Status
XcmsQueryWhite : proc "c" (
	ccc:    XcmsCCC,
	format: XcmsColorFormat,
	color:  ^XcmsColor,
	) -> Status
// CIELab queries
XcmsCIELabQueryMaxC : proc "c" (
	ccc:   XcmsCCC,
	hue:   XcmsFloat,
	lstar: XcmsFloat,
	color: ^XcmsColor,
	) -> Status
XcmsCIELabQueryMaxL : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	chroma: XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
XcmsCIELabQueryMaxLC : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
XcmsCIELabQueryMinL : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	chroma: XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
// CIEluv queries
XcmsCIELuvQueryMaxC : proc "c" (
	ccc:   XcmsCCC,
	hue:   XcmsFloat,
	lstar: XcmsFloat,
	color: ^XcmsColor,
	) -> Status
XcmsCIELuvQueryMaxL : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	chroma: XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
XcmsCIELuvQueryMaxLC : proc "c" (
	ccc:   XcmsCCC,
	hue:   XcmsFloat,
	color: ^XcmsColor,
	) -> Status
XcmsCIELuvQueryMinL : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	chroma: XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
// TexHVX queries
XcmsTekHVCQueryMaxC : proc "c" (
	ccc:   XcmsCCC,
	hue:   XcmsFloat,
	value: XcmsFloat,
	color: ^XcmsColor,
	) -> Status
XcmsTekHVCQueryMaxV : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	chroma: XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
XcmsTekHVCQueryMaxVC : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
XcmsTekHVCQueryMaxVSamples : proc "c" (
	ccc:      XcmsCCC,
	hue:      XcmsFloat,
	colors:   [^]XcmsColor,
	nsamples: u32,
	) -> Status
XcmsTekHVCQueryMinV : proc "c" (
	ccc:    XcmsCCC,
	hue:    XcmsFloat,
	chroma: XcmsFloat,
	color:  ^XcmsColor,
	) -> Status
// Graphics context functions
XCreateGC : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	mask:     GCAttributeMask,
	attr:     ^XGCValues,
	) -> GC
XCopyGC : proc "c" (
	display:  ^Display,
	src:      GC,
	dst:      GC,
	mask:     GCAttributeMask,
	)
XChangeGC : proc "c" (
	display:  ^Display,
	gc:       GC,
	mask:     GCAttributeMask,
	values:   ^XGCValues,
	)
XGetGCValues : proc "c" (
	display:  ^Display,
	gc:       GC,
	mask:     GCAttributeMask,
	values:   ^XGCValues,
	) -> Status
XFreeGC : proc "c" (display: ^Display, gc: GC)
XGContextFromGC : proc "c" (gc: GC) -> GContext
XFlushGC : proc "c" (display: ^Display, gc: GC)
// Convenience routines for GC
XSetState : proc "c" (
	display: ^Display,
	gc:      GC,
	fg:      uint,
	bg:      uint,
	fn:      GCFunction,
	pmask:   uint,
	)
XSetForeground : proc "c" (
	display: ^Display,
	gc:      GC,
	fg:      uint,
	)
XSetBackground : proc "c" (
	display: ^Display,
	gc:      GC,
	bg:      uint,
	)
XSetFunction : proc "c" (
	display: ^Display,
	gc:      GC,
	fn:      GCFunction,
	)
XSetPlaneMask : proc "c" (
	display: ^Display,
	gc:      GC,
	pmask:   uint,
	)
XSetLineAttributes : proc "c" (
	display:    ^Display,
	gc:         GC,
	width:      u32,
	line_style: LineStyle,
	cap_style:  CapStyle,
	join_style: JoinStyle,
	)
XSetDashes : proc "c" (
	display:   ^Display,
	gc:        GC,
	dash_offs: i32,
	dash_list: [^]i8,
	n:         i32,
	)
XSetFillStyle : proc "c" (
	display: ^Display,
	gc:      GC,
	style:   FillStyle,
	)
XSetFillRule : proc "c" (
	display: ^Display,
	gc:      GC,
	rule:    FillRule,
	)
XQueryBestSize : proc "c" (
	display:    ^Display,
	class:      i32,
	which:      Drawable,
	width:      u32,
	height:     u32,
	out_width:  ^u32,
	out_height: ^u32,
	) -> Status
XQueryBestTile : proc "c" (
	display:    ^Display,
	which:      Drawable,
	width:      u32,
	height:     u32,
	out_width:  ^u32,
	out_height: ^u32,
	) -> Status
XQueryBestStipple : proc "c" (
	display:    ^Display,
	which:      Drawable,
	width:      u32,
	height:     u32,
	out_width:  u32,
	out_height: u32,
	) -> Status
XSetTile       : proc "c" (display: ^Display, gc: GC, tile: Pixmap)
XSetStipple   : proc "c" (display: ^Display, gc: GC, stripple: Pixmap)
XSetTSOrigin   : proc "c" (display: ^Display, gc: GC, x: i32, y: i32)
XSetFont       : proc "c" (display: ^Display, gc: GC, font: Font)
XSetClipOrigin : proc "c" (display: ^Display, gc: GC, x: i32, y: i32)
XSetClipMask   : proc "c" (display: ^Display, gc: GC, pixmap: Pixmap)
XSetClipRectangles : proc "c" (
	display:  ^Display,
	gc:       GC,
	x:        i32,
	y:        i32,
	rects:    [^]XRectangle,
	n:        i32,
	ordering: i32,
	)
XSetArcMode           : proc "c" (display: ^Display, gc: GC, mode: ArcMode)
XSetSubwindowMode     : proc "c" (display: ^Display, gc: GC, mode: SubwindowMode)
XSetGraphicsExposures : proc "c" (display: ^Display, gc: GC, exp: b32)
// Graphics functions
XClearArea : proc "c" (
	display: ^Display,
	window:  Window,
	x:       i32,
	y:       i32,
	width:   u32,
	height:  u32,
	exp:     b32,
	)
XClearWindow : proc "c" (
	display: ^Display,
	window: Window,
	)
XCopyArea : proc "c" (
	display: ^Display,
	src:     Drawable,
	dst:     Drawable,
	gc:      GC,
	src_x:   i32,
	src_y:   i32,
	width:   u32,
	height:  u32,
	dst_x:   i32,
	dst_y:   i32,
	)
XCopyPlane : proc "c" (
	display: ^Display,
	src:     Drawable,
	dst:     Drawable,
	gc:      GC,
	src_x:   i32,
	src_y:   i32,
	width:   u32,
	height:  u32,
	dst_x:   i32,
	dst_y:   i32,
	plane:   uint,
	)
// Drawing lines, points, rectangles and arc
XDrawPoint : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	)
XDrawPoints : proc "c" (
	display:  Display,
	drawable: Drawable,
	gc:       GC,
	point:    [^]XPoint,
	npoints:  i32,
	mode:     CoordMode,
	)
XDrawLine : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x1:       i32,
	y1:       i32,
	x2:       i32,
	y2:       i32,
	)
XDrawLines : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	points:   [^]XPoint,
	npoints:  i32,
	)
XDrawSegments : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	segs:     [^]XSegment,
	nsegs:    i32,
	)
XDrawRectangle : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	width:    u32,
	height:   u32,
	)
XDrawRectangles : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	rects:    [^]XRectangle,
	nrects:   i32,
	)
XDrawArc : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	width:    u32,
	height:   u32,
	angle1:   i32,
	angle2:   i32,
	)
XDrawArcs : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	arcs:     [^]XArc,
	narcs:    i32,
	)
// Filling areas
XFillRectangle : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	width:    u32,
	height:   u32,
	)
XFillRectangles : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	rects:    [^]XRectangle,
	nrects:   i32,
	)
XFillPolygon : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	points:   [^]XPoint,
	npoints:  i32,
	shape:    Shape,
	mode:     CoordMode,
	)
XFillArc : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	width:    u32,
	height:   u32,
	angle1:   i32,
	angle2:   i32,
	)
XFillArcs : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	arcs:     [^]XArc,
	narcs:    i32,
	)
// Font metrics
XLoadFont        : proc "c" (display: ^Display, name: cstring) -> Font
XQueryFont       : proc "c" (display: ^Display, id: XID) -> ^XFontStruct
XLoadQueryFont   : proc "c" (display: ^Display, name: cstring) -> ^XFontStruct
XFreeFont        : proc "c" (display: ^Display, font_struct: ^XFontStruct)
XGetFontProperty : proc "c" (font_struct: ^XFontStruct, atom: Atom, ret: ^uint) -> b32
XUnloadFont      : proc "c" (display: ^Display, font: Font)
XListFonts       : proc "c" (display: ^Display, pat: cstring, max: i32, count: ^i32) -> [^]cstring
XFreeFontNames   : proc "c" (display: ^Display, list: [^]cstring)
XListFontsWithInfo : proc "c" (
	display: ^Display,
	pat:     cstring,
	max:     i32,
	count:   ^i32,
	info:    ^[^]XFontStruct,
	) -> [^]cstring
XFreeFontInfo : proc "c" (names: [^]cstring, info: [^]XFontStruct, count: i32)
// Computing character string sizes
XTextWidth : proc "c" (font_struct: ^XFontStruct, string: [^]u8, count: i32) -> i32
XTextWidth16 : proc "c" (font_struct: ^XFontStruct, string: [^]XChar2b, count: i32) -> i32
XTextExtents : proc "c" (
	font_struct: ^XFontStruct,
	string:      [^]u8,
	nchars:      i32,
	direction:   ^FontDirection,
	ascent:      ^i32,
	descent:     ^i32,
	ret:         ^XCharStruct,
	)
XTextExtents16 : proc "c" (
	font_struct: ^XFontStruct,
	string:      [^]XChar2b,
	nchars:      i32,
	direction:   ^FontDirection,
	ascent:      ^i32,
	descent:     ^i32,
	ret:         ^XCharStruct,
	)
XQueryTextExtents : proc "c" (
	display:     ^Display,
	font_id:     XID,
	string:      [^]u8,
	nchars:      i32,
	direction:   ^FontDirection,
	ascent:      ^i32,
	descent:     ^i32,
	ret:         ^XCharStruct,
	)
XQueryTextExtents16 : proc "c" (
	display:     ^Display,
	font_id:     XID,
	string:      [^]XChar2b,
	nchars:      i32,
	direction:   ^FontDirection,
	ascent:      ^i32,
	descent:     ^i32,
	ret:         ^XCharStruct,
	)
// Drawing complex text
XDrawText : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	items:    XTextItem,
	nitems:   i32,
	)
XDrawText16 : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	items:    XTextItem16,
	nitems:   i32,
	)
// Drawing text characters
XDrawString : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	string:   [^]u8,
	length:   i32,
	)
XDrawString16 : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	string:   [^]XChar2b,
	length:   i32,
	)
XDrawImageString : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	string:   [^]u8,
	length:   i32,
	)
XDrawImageString16 : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	x:        i32,
	y:        i32,
	string:   [^]XChar2b,
	length:   i32,
	)
// Transferring images between client and server
XInitImage : proc "c" (image: ^XImage) -> Status
XPutImage : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	gc:       GC,
	image:    ^XImage,
	src_x:    i32,
	src_y:    i32,
	dst_x:    i32,
	dst_y:    i32,
	width:    u32,
	height:   u32,
	)
XGetImage : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	x:        i32,
	y:        i32,
	width:    u32,
	height:   u32,
	mask:     uint,
	format:   ImageFormat,
	) -> ^XImage
XGetSubImage : proc "c" (
	display:  ^Display,
	drawable: Drawable,
	src_x:    i32,
	src_y:    i32,
	width:    u32,
	height:   u32,
	mask:     uint,
	format:   ImageFormat,
	dst:      ^XImage,
	dst_x:    i32,
	dst_y:    i32,
	) -> ^XImage
// Window and session manager functions
XReparentWindow : proc "c" (
	display: ^Display,
	window:  Window,
	parent:  Window,
	x:       i32,
	y:       i32,
	)
XChangeSaveSet : proc "c" (
	display: ^Display,
	window:  Window,
	mode:    SaveSetChangeMode,
	)
XAddToSaveSet : proc "c" (
	display: ^Display,
	window:  Window,
	)
XRemoveFromSaveSet : proc "c" (
	display: ^Display,
	window:  Window,
	)
// Managing installed colormaps
XInstallColormap        : proc "c" (display: ^Display, colormap: Colormap)
XUninstallColormap      : proc "c" (display: ^Display, colormap: Colormap)
XListInstalledColormaps : proc "c" (display: ^Display, window: Window, n: ^i32) -> [^]Colormap
// Setting and retrieving font search paths
XSetFontPath            : proc "c" (display: ^Display, dirs: [^]cstring, ndirs: i32)
XGetFontPath            : proc "c" (display: ^Display, npaths: ^i32) -> [^]cstring
XFreeFontPath           : proc "c" (list: [^]cstring)
// Grabbing the server
XGrabServer             : proc "c" (display: ^Display)
XUngrabServer           : proc "c" (display: ^Display)
// Killing clients
XKillClient             : proc "c" (display: ^Display, resource: XID)
// Controlling the screen saver
XSetScreenSaver : proc "c" (
	display:   ^Display,
	timeout:   i32,
	interval:  i32,
	blanking:  ScreenSaverBlanking,
	exposures: ScreenSavingExposures,
	)
XForceScreenSaver    : proc "c" (display: ^Display, mode: ScreenSaverForceMode)
XActivateScreenSaver : proc "c" (display: ^Display)
XResetScreenSaver    : proc "c" (display: ^Display)
XGetScreenSaver : proc "c" (
	display: ^Display,
	timeout: ^i32,
	interval: ^i32,
	blanking: ^ScreenSaverBlanking,
	exposures: ^ScreenSavingExposures,
	)
// Controlling host address
XAddHost     : proc "c" (display: ^Display, addr: ^XHostAddress)
XAddHosts    : proc "c" (display: ^Display, hosts: [^]XHostAddress, nhosts: i32)
XListHosts   : proc "c" (display: ^Display, nhosts: ^i32, state: [^]b32) -> [^]XHostAddress
XRemoveHost  : proc "c" (display: ^Display, host: XHostAddress)
XRemoveHosts : proc "c" (display: ^Display, hosts: [^]XHostAddress, nhosts: i32)
// Access control list
XSetAccessControl     : proc "c" (display: ^Display, mode: AccessControlMode)
XEnableAccessControl  : proc "c" (display: ^Display)
XDisableAccessControl : proc "c" (display: ^Display)
// Events
XSelectInput  : proc "c" (display: ^Display, window: Window, mask: EventMask)
XFlush        : proc "c" (display: ^Display)
XSync         : proc "c" (display: ^Display)
XEventsQueued : proc "c" (display: ^Display, mode: EventQueueMode) -> i32
XPending      : proc "c" (display: ^Display) -> i32
XNextEvent    : proc "c" (display: ^Display, event: ^XEvent)
XPeekEvent    : proc "c" (display: ^Display, event: ^XEvent)
// Selecting events using a predicate procedure
XIfEvent : proc "c" (
	display:   ^Display,
	event:     ^XEvent,
	predicate: #type proc "c" (display: ^Display, event: ^XEvent, ctx: rawptr) -> b32,
	ctx:       rawptr,
	)
XCheckIfEvent : proc "c" (
	display:   ^Display,
	event:     ^XEvent,
	predicate: #type proc "c" (display: ^Display, event: ^XEvent, ctx: rawptr) -> b32,
	arg:       rawptr,
	) -> b32
XPeekIfEvent : proc "c" (
	display:   ^Display,
	event:     ^XEvent,
	predicate: #type proc "c" (display: ^Display, event: ^XEvent, ctx: rawptr) -> b32,
	ctx:       rawptr,
	)
// Selecting events using a window or event mask
XWindowEvent : proc "c" (
	display:   ^Display,
	window:    Window,
	mask:      EventMask,
	event:     ^XEvent,
	)
XCheckWindowEvent : proc "c" (
	display:   ^Display,
	window:    Window,
	mask:      EventMask,
	event:     ^XEvent,
	) -> b32
XMaskEvent : proc "c" (
	display: ^Display,
	mask:    EventMask,
	event:   ^XEvent,
	)
XCheckMaskEvent : proc "c" (
	display: ^Display,
	mask:    EventMask,
	event:   ^XEvent,
	) -> b32
XCheckTypedEvent : proc "c" (
	display: ^Display,
	type:    EventType,
	event:   ^XEvent,
	) -> b32
XCheckTypedWindowEvent : proc "c" (
	display: ^Display,
	window:  Window,
	type:    EventType,
	event:   ^XEvent,
	) -> b32
// Putting events back
XPutBackEvent : proc "c" (
	display: ^Display,
	event:   ^XEvent,
	)
// Sending events to other applications
XSendEvent : proc "c" (
	display:   ^Display,
	window:    Window,
	propagate: b32,
	mask:      EventMask,
	event:     ^XEvent,
	) -> Status
// Getting the history of pointer motion
XDisplayMotionBufferSize : proc "c" (display: ^Display) -> uint
XGetMotionEvents : proc "c" (
	display: ^Display,
	window: Window,
	start: Time,
	stop: Time,
	nevents: ^i32,
	) -> [^]XTimeCoord
// Enabling or disabling synchronization
XSetAfterFunction : proc "c" (
	display:   ^Display,
	procedure: #type proc "c" (display: ^Display) -> i32,
	) -> i32
XSynchronize : proc "c" (
	display: ^Display,
	onoff: b32,
	) -> i32
// Error handling
XSetErrorHandler : proc "c" (
	handler: #type proc "c" (display: ^Display, event: ^XErrorEvent) -> i32,
	) -> i32
XGetErrorText : proc "c" (
	display: ^Display,
	code: i32,
	buffer: [^]u8,
	size: i32,
	)
XGetErrorDatabaseText : proc "c" (
	display: ^Display,
	name: cstring,
	message: cstring,
	default_string: cstring,
	buffer: [^]u8,
	size: i32,
	)
XDisplayName : proc "c" (string: cstring) -> cstring
XSetIOErrorHandler : proc "c" (
	handler: #type proc "c" (display: ^Display) -> i32,
	) -> i32
// Pointer grabbing
XGrabPointer : proc "c" (
	display:       ^Display,
	grab_window:   Window,
	owner_events:  b32,
	mask:          EventMask,
	pointer_mode:  GrabMode,
	keyboard_mode: GrabMode,
	confine_to:    Window,
	cursor:        Cursor,
	time:          Time,
	) -> i32
XUngrabPointer : proc "c" (
	display:       ^Display,
	time:          Time,
	) -> i32
XChangeActivePointerGrab : proc "c" (
	display:       ^Display,
	event_mask:    EventMask,
	cursor:        Cursor,
	time:          Time,
	)
XGrabButton : proc "c" (
	display:       ^Display,
	button:        u32,
	modifiers:     InputMask,
	grab_window:   Window,
	owner_events:  b32,
	event_mask:    EventMask,
	pointer_mode:  GrabMode,
	keyboard_mode: GrabMode,
	confine_to:    Window,
	cursor:        Cursor,
	)
XUngrabButton : proc "c" (
	display:       ^Display,
	button:        u32,
	modifiers:     InputMask,
	grab_window:   Window,
	)
XGrabKeyboard : proc "c" (
	display:       ^Display,
	grab_window:   Window,
	owner_events:  b32,
	pointer_mode:  GrabMode,
	keyboard_mode: GrabMode,
	time:          Time,
	) -> i32
XUngrabKeyboard : proc "c" (
	display:       ^Display,
	time:          Time,
	)
XGrabKey : proc "c" (
	display:       ^Display,
	keycode:       i32,
	modifiers:     InputMask,
	grab_window:   Window,
	owner_events:  b32,
	pointer_mode:  GrabMode,
	keyboard_mode: GrabMode,
	)
XUngrabKey : proc "c" (
	display:       ^Display,
	keycode:       i32,
	modifiers:     InputMask,
	grab_window:   Window,
	)
// Resuming event processing
XAllowEvents : proc "c" (display: ^Display, evend_mode: AllowEventsMode, time: Time)
// Moving the pointer
XWarpPointer : proc "c" (
	display:    ^Display,
	src_window: Window,
	dst_window: Window,
	src_x:      i32,
	src_y:      i32,
	src_width:  u32,
	src_height: u32,
	dst_x:      i32,
	dst_y:      i32,
	)
// Controlling input focus
XSetInputFocus : proc "c" (
	display: ^Display,
	focus: Window,
	revert_to: FocusRevert,
	time: Time,
	)
XGetInputFocus : proc "c" (
	display: ^Display,
	focus: ^Window,
	revert_to: ^FocusRevert,
	)
// Manipulating the keyboard and pointer settings
XChangeKeyboardControl : proc "c" (
	display: ^Display,
	mask: KeyboardControlMask,
	values: ^XKeyboardControl,
	)
XGetKeyboardControl : proc "c" (
	display: ^Display,
	values: ^XKeyboardState,
	)
XAutoRepeatOn  : proc "c" (display: ^Display)
XAutoRepeatOff : proc "c" (display: ^Display)
XBell          : proc "c" (display: ^Display, percent: i32)
XQueryKeymap   : proc "c" (display: ^Display, keys: [^]u32)
XSetPointerMapping : proc "c" (display: ^Display, map_should_not_be_a_keyword: [^]u8, nmap: i32) -> i32
XGetPointerMapping : proc "c" (display: ^Display, map_should_not_be_a_keyword: [^]u8, nmap: i32) -> i32
XChangePointerControl : proc "c" (
	display:           ^Display,
	do_accel:          b32,
	do_threshold:      b32,
	accel_numerator:   i32,
	accel_denominator: i32,
	threshold:         i32,
	)
XGetPointerControl : proc "c" (
	display: ^Display,
	accel_numerator:   ^i32,
	accel_denominator: ^i32,
	threshold:         ^i32,
	)
// Manipulating the keyboard encoding
XDisplayKeycodes : proc "c" (
	display:      ^Display,
	min_keycodes: ^i32,
	max_keycodes: ^i32,
	)
XGetKeyboardMapping : proc "c" (
	display:     ^Display,
	first:       KeyCode,
	count:       i32,
	keysyms_per: ^i32,
	) -> ^KeySym
XChangeKeyboardMapping : proc "c" (
	display:     ^Display,
	first:       KeyCode,
	keysyms_per: i32,
	keysyms:     [^]KeySym,
	num_codes:   i32,
	)
XNewModifiermap : proc "c" (max_keys_per_mode: i32) -> ^XModifierKeymap
XInsertModifiermapEntry : proc "c" (
	modmap:        ^XModifierKeymap,
	keycode_entry: KeyCode,
	modifier:      i32,
	) -> ^XModifierKeymap
XDeleteModifiermapEntry : proc "c" (
	modmap: ^XModifierKeymap,
	keycode_entry: KeyCode,
	modifier: i32,
	) -> ^XModifierKeymap
XFreeModifiermap : proc "c" (modmap: ^XModifierKeymap)
XSetModifierMapping : proc "c" (display: ^Display, modmap: ^XModifierKeymap) -> i32
XGetModifierMapping : proc "c" (display: ^Display) -> ^XModifierKeymap
// Manipulating top-level windows
XIconifyWindow : proc "c" (
	dipslay:   ^Display,
	window:    Window,
	screen_no: i32,
	) -> Status
XWithdrawWindow : proc "c" (
	dipslay:   ^Display,
	window:    Window,
	screen_no: i32,
	) -> Status
XReconfigureWMWindow : proc "c" (
	dipslay:   ^Display,
	window:    Window,
	screen_no: i32,
	mask:      WindowChangesMask,
	changes:   ^XWindowChanges,
	) -> Status
// Getting and setting the WM_NAME property
XSetWMName : proc "c" (
	display:   ^Display,
	window:    Window,
	prop:      ^XTextProperty,
	)
XGetWMName : proc "c" (
	display: ^Display,
	window:  Window,
	prop:    ^XTextProperty,
	) -> Status
XStoreName : proc "c" (
	display: ^Display,
	window:  Window,
	name:    cstring,
	)
XFetchName : proc "c" (
	display: ^Display,
	window:  Window,
	name:    ^cstring,
	) -> Status
XSetWMIconName : proc "c" (
	display: ^Display,
	window:  Window,
	prop:    ^XTextProperty,
	)
XGetWMIconName : proc "c" (
	display: ^Display,
	window:  Window,
	prop:    ^XTextProperty,
	) -> Status
XSetIconName : proc "c" (
	display: ^Display,
	window:  Window,
	name:    cstring,
	)
XGetIconName : proc "c" (
	display: ^Display,
	window:  Window,
	prop:    ^cstring,
	) -> Status
// Setting and reading WM_HINTS property
XAllocWMHints : proc "c" () -> ^XWMHints
XSetWMHints : proc "c" (
	display: ^Display,
	window:  Window,
	hints:   ^XWMHints,
	)
XGetWMHints : proc "c" (
	display: ^Display,
	window:  Window,
	) -> ^XWMHints
// Setting and reading MW_NORMAL_HINTS property
XAllocSizeHints : proc "c" () -> ^XSizeHints
XSetWMNormalHints : proc "c" (
	display: ^Display,
	window:  Window,
	hints:   ^XSizeHints,
	)
XGetWMNormalHints : proc "c" (
	display: ^Display,
	window: Window,
	hints: ^XSizeHints,
	flags: ^SizeHints,
	) -> Status
XSetWMSizeHints : proc "c" (
	display: ^Display,
	window:  Window,
	hints:   ^XSizeHints,
	prop:    Atom,
	)
XGetWMSizeHints : proc "c" (
	display: ^Display,
	window:  Window,
	hints:   ^XSizeHints,
	masks:   ^SizeHints,
	prop:    Atom,
	) -> Status
// Setting and reading the WM_CLASS property
XAllocClassHint : proc "c" () -> ^XClassHint
XSetClassHint : proc "c" (
	display: ^Display,
	window:  Window,
	hint:    ^XClassHint,
	)
XGetClassHint : proc "c" (
	display: ^Display,
	window:  Window,
	hint:    ^XClassHint,
	) -> Status
// Setting and reading WM_TRANSIENT_FOR property
XSetTransientForHint : proc "c" (
	display:     ^Display,
	window:      Window,
	prop_window: Window,
	)
XGetTransientForHint : proc "c" (
	display:     ^Display,
	window:      Window,
	prop_window: ^Window,
	) -> Status
// Setting and reading the WM_PROTOCOLS property
XSetWMProtocols : proc "c" (
	display:   ^Display,
	window:    Window,
	protocols: [^]Atom,
	count:     i32,
	) -> Status
XGetWMProtocols : proc "c" (
	display:   ^Display,
	window:    Window,
	protocols: ^[^]Atom,
	count:     ^i32,
	) -> Status
// Setting and reading the WM_COLORMAP_WINDOWS property
XSetWMColormapWindows : proc "c" (
	display:          ^Display,
	window:           Window,
	colormap_windows: [^]Window,
	count:            i32,
	) -> Status
XGetWMColormapWindows : proc "c" (
	display:          ^Display,
	window:           Window,
	colormap_windows: ^[^]Window,
	count:            ^i32,
	) -> Status
// Setting and reading the WM_ICON_SIZE_PROPERTY
XAllocIconSize : proc "c" () -> ^XIconSize
XSetIconSizes : proc "c" (
	display:   ^Display,
	window:    Window,
	size_list: [^]XIconSize,
	count:     i32,
	)
XGetIconSizes : proc "c" (
	display:   ^Display,
	window:    Window,
	size_list: ^[^]XIconSize,
	count:     ^i32,
	) -> Status
// Using window manager convenience functions
XmbSetWMProperties : proc "c" (
	display:      ^Display,
	window:       Window,
	window_name:  cstring,
	icon_name:    cstring,
	argv:         [^]cstring,
	argc:         i32,
	normal_hints: ^XSizeHints,
	wm_hints:     ^XWMHints,
	class_hints:  ^XClassHint,
	)
XSetWMProperties : proc "c" (
	display:      ^Display,
	window:       Window,
	window_name:  ^XTextProperty,
	argv:         [^]cstring,
	argc:         i32,
	normal_hints: ^XSizeHints,
	wm_hints:     ^XWMHints,
	class_hints:  ^XWMHints,
	)
// Client to session manager communication
XSetCommand : proc "c" (
	display: ^Display,
	window:  Window,
	argv:    [^]cstring,
	argc:    i32,
	)
XGetCommand : proc "c" (
	display: ^Display,
	window:  Window,
	argv:    ^[^]cstring,
	argc:    ^i32,
	) -> Status
XSetWMClientMachine : proc "c" (
	display: ^Display,
	window:  Window,
	prop:    ^XTextProperty,
	)
XGetWMClientMachine : proc "c" (
	display: ^Display,
	window:  Window,
	prop:    ^XTextProperty,
	) -> Status
XSetRGBColormaps : proc "c" (
	display:  ^Display,
	window:   Window,
	colormap: ^XStandardColormap,
	prop:     Atom,
	)
XGetRGBColormaps : proc "c" (
	display:  ^Display,
	window:   Window,
	colormap: ^[^]XStandardColormap,
	count:    ^i32,
	prop:     Atom,
	) -> Status
// Keyboard utility functions
XLookupKeysym : proc "c" (
	event: ^XKeyEvent,
	index: i32,
	) -> KeySym
XKeycodeToKeysym : proc "c" (
	display: ^Display,
	keycode: KeyCode,
	index: i32,
	) -> KeySym
XKeysymToKeycode : proc "c" (
	display: ^Display,
	keysym: KeySym,
	) -> KeyCode
XRefreshKeyboardMapping : proc "c" (event_map: ^XMappingEvent)
XConvertCase : proc "c" (
	keysym: KeySym,
	lower:  ^KeySym,
	upper:  ^KeySym,
	)
XStringToKeysym : proc "c" (str: cstring) -> KeySym
XKeysymToString : proc "c" (keysym: KeySym) -> cstring
XLookupString : proc "c" (
	event: ^XKeyEvent,
	buffer: [^]u8,
	count: i32,
	keysym: ^KeySym,
	status: ^XComposeStatus,
	) -> i32
XRebindKeysym : proc "c" (
	display: ^Display,
	keysym: KeySym,
	list: [^]KeySym,
	mod_count: i32,
	string: [^]u8,
	num_bytes: i32,
	)
// Allocating permanent storage
Xpermalloc : proc "c" (size: u32) -> rawptr
// Parsing the window geometry
XParseGeometry : proc "c" (
	parsestring: cstring,
	x_ret:       ^i32,
	y_ret:       ^i32,
	width:       ^u32,
	height:      ^u32,
	) -> i32
XWMGeometry : proc "c" (
	display:   ^Display,
	screen_no: i32,
	user_geom: cstring,
	def_geom:  cstring,
	bwidth:    u32,
	hints:     ^XSizeHints,
	x_ret:     ^i32,
	y_ret:     ^i32,
	w_ret:     ^u32,
	h_ret:     ^u32,
	grav:      ^Gravity,
	) -> i32
// Creating, copying and destroying regions
XCreateRegion : proc "c" () -> Region
XPolygonRegion : proc "c" (
	points: [^]XPoint,
	n:      i32,
	fill:   FillRule,
	) -> Region
XSetRegion : proc "c" (
	display: ^Display,
	gc:      GC,
	region:  Region,
	)
XDestroyRegion : proc "c" (r: Region)
// Moving or shrinking regions
XOffsetRegion : proc "c" (region: Region, dx, dy: i32)
XShrinkRegion : proc "c" (region: Region, dx, dy: i32)
// Computing with regions
XClipBox : proc "c" (region: Region, rect: ^XRectangle)
XIntersectRegion : proc "c" (sra, srb, ret: Region)
XUnionRegion : proc "c" (sra, srb, ret: Region)
XUnionRectWithRegion : proc "c" (rect: ^XRectangle, src, dst: Region)
XSubtractRegion : proc "c" (sra, srb, ret: Region)
XXorRegion : proc "c" (sra, srb, ret: Region)
XEmptyRegion : proc "c" (reg: Region) -> b32
XEqualRegion : proc "c" (a,b: Region) -> b32
XPointInRegion : proc "c" (reg: Region, x,y: i32) -> b32
XRectInRegion : proc "c" (reg: Region, x,y: i32, w,h: u32) -> b32
// Using cut buffers
XStoreBytes : proc "c" (display: ^Display, bytes: [^]u8, nbytes: i32)
XStoreBuffer : proc "c" (display: ^Display, bytes: [^]u8, nbytes: i32, buffer: i32)
XFetchBytes : proc "c" (display: ^Display, nbytes: ^i32) -> [^]u8
XFetchBuffer : proc "c" (display: ^Display, nbytes: ^i32, buffer: i32) -> [^]u8
// Determining the appropriate visual types
XGetVisualInfo : proc "c" (
	display: ^Display,
	mask:    VisualInfoMask,
	info:    ^XVisualInfo,
	nret:    ^i32,
	) -> [^]XVisualInfo
XMatchVisualInfo : proc "c" (
	display:   ^Display,
	screen_no: i32,
	depth:     i32,
	class:     i32,
	ret:       ^XVisualInfo,
	) -> Status
// Manipulating images
XCreateImage : proc "c" (
	display: ^Display,
	visual:  ^Visual,
	depth:   u32,
	format:  ImageFormat,
	offset:  i32,
	data:    rawptr,
	width:   u32,
	height:  u32,
	pad:     i32,
	stride:  i32,
	) -> ^XImage
XGetPixel : proc "c" (
	image: ^XImage,
	x:     i32,
	y:     i32,
	) -> uint
XPutPixel : proc "c" (
	image: ^XImage,
	x:     i32,
	y:     i32,
	pixel: uint,
	)
XSubImage : proc "c" (
	image: ^XImage,
	x: i32,
	y: i32,
	w: u32,
	h: u32,
	) -> ^XImage
XAddPixel : proc "c" (
	image: ^XImage,
	value: int,
	)
XDestroyImage : proc "c" (image: ^XImage)
