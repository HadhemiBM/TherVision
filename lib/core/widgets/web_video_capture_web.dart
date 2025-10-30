// Web implementation: paint the first <video> element into a canvas and return PNG bytes
import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

Future<Uint8List?> captureHtmlVideoAsPng() async {
  final videos = html.document.getElementsByTagName('video');
  if (videos.isEmpty) return null;

  final html.VideoElement video = videos.first as html.VideoElement;

  // Wait until video has dimensions
  if (video.videoWidth == 0 || video.videoHeight == 0) {
    try {
      await video.onLoadedData.first.timeout(const Duration(seconds: 2));
    } catch (_) {
      // ignore timeout
    }
    if (video.videoWidth == 0 || video.videoHeight == 0) return null;
  }

  final canvas = html.CanvasElement(
    width: video.videoWidth,
    height: video.videoHeight,
  );
  final ctx = canvas.context2D;
  ctx.drawImageScaled(video, 0, 0, canvas.width!, canvas.height!);

  final blob = await canvas.toBlob('image/png');

  final reader = html.FileReader();
  final completer = Completer<Uint8List?>();
  reader.onLoad.listen((_) {
    final result = reader.result;
    if (result is ByteBuffer) {
      completer.complete(Uint8List.view(result));
    } else if (result is List<int>) {
      completer.complete(Uint8List.fromList(result));
    } else {
      completer.complete(null);
    }
  });
  reader.readAsArrayBuffer(blob);
  return completer.future;
}
