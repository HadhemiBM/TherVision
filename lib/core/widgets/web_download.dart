// Platform-agnostic web download API. Uses conditional imports to provide a
// working implementation on web and a stub on other platforms.
export 'web_download_stub.dart' if (dart.library.html) 'web_download_web.dart';
