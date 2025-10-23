// Web implementation using dart:html
// This file will only be imported on web via conditional import in web_download.dart
import 'dart:html' as html;

Future<void> downloadBytesAsFile(List<int> bytes, String filename) async {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor =
      html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..download = filename
        ..style.display = 'none';
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(url);
}
