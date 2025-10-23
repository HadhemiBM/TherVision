// Stub implementation for platforms where dart:html is not available.
// The function is a no-op and returns a Future that completes immediately.
Future<void> downloadBytesAsFile(List<int> bytes, String filename) async {
  // Not supported on this platform. Caller should fallback to native file write.
  return;
}
