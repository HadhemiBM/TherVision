// Platform-agnostic export for web video capture
export 'web_video_capture_stub.dart'
    if (dart.library.html) 'web_video_capture_web.dart';
