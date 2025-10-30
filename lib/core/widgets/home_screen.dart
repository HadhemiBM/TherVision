import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:thervision/core/constants/app_colors.dart';
// routes import removed — navigation to AnalyseScreen now uses MaterialPageRoute

import 'MainScaffold.dart';
import 'web_video_capture.dart' as web_capture;
import 'analyse_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  RTCVideoRenderer? _localRenderer;
  MediaStream? _localStream;
  bool _isCameraInitialized = false;
  Uint8List? _capturedImageBytes;
  final GlobalKey _previewKey = GlobalKey();

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      // Clean up any existing renderer/stream before creating a new one
      try {
        _localStream?.getTracks().forEach((t) => t.stop());
      } catch (_) {}
      try {
        await _localRenderer?.dispose();
      } catch (_) {}

      _localRenderer = RTCVideoRenderer();
      await _localRenderer!.initialize();

      final Map<String, dynamic> mediaConstraints = {
        'audio': false,
        'video': {'facingMode': 'environment'},
      };

      _localStream = await navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );
      _localRenderer!.srcObject = _localStream;

      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Camera initialization failed: $e');
    }
  }

  Future<void> _retake() async {
    // Clear captured image and restart the camera preview
    setState(() {
      _capturedImageBytes = null;
      _isCameraInitialized = false;
    });

    await _initCamera();
  }

  @override
  void dispose() {
    try {
      _localStream?.getTracks().forEach((t) => t.stop());
    } catch (_) {}
    _localRenderer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: AppColors.bgNavbar,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.hovered))
                return AppColors.primary;
              return AppColors.white;
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.hovered)) return Colors.white;
              return AppColors.primary;
            }),
            overlayColor: MaterialStateProperty.all<Color>(AppColors.primary),
          ),
        ),
      ),
      child: MainScaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/BG.png', fit: BoxFit.cover),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth < 600;
                return Center(
                  child: isMobile ? _buildMobile(context) : _buildWide(context),
                );
              },
            ),
          ],
        ),
        currentIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          color: Colors.black,
          height: 300,
          width: double.infinity,
          child: _buildCameraPreview(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _capturedImageBytes != null ? _retake : _capturePhoto,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 50),
                maximumSize: const Size(220, 50),
              ),
              child: Text(_capturedImageBytes != null ? 'Retry' : 'Capture'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                if (_capturedImageBytes != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (c) => AnalyseScreen(imageBytes: _capturedImageBytes),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Aucune image capturée. Veuillez capturer une image avant d'analyse.",
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(180, 50)),
              child: const Text('Analyse'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWide(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 500,
            margin: const EdgeInsets.all(16),
            color: Colors.black,
            child: _buildCameraPreview(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed:
                    _capturedImageBytes != null ? _retake : _capturePhoto,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 60),
                ),
                child: Text(
                  _capturedImageBytes != null ? 'Retry' : 'Capture',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_capturedImageBytes != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (c) =>
                                AnalyseScreen(imageBytes: _capturedImageBytes),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Aucune image capturée. Veuillez capturer une image avant d'analyse.",
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 60),
                ),
                child: const Text('Analyse', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCameraPreview() {
    if (_capturedImageBytes != null)
      return Image.memory(_capturedImageBytes!, fit: BoxFit.contain);

    if (_isCameraInitialized && _localRenderer != null) {
      return RepaintBoundary(
        key: _previewKey,
        child: RTCVideoView(
          _localRenderer!,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ),
      );
    }

    return const Center(
      child: Text(
        'Camera unavailable',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Future<void> _capturePhoto() async {
    try {
      Uint8List? bytes;

      if (kIsWeb) {
        bytes = await web_capture.captureHtmlVideoAsPng();
      }

      if (bytes == null) {
        final boundary =
            _previewKey.currentContext?.findRenderObject()
                as RenderRepaintBoundary?;
        if (boundary != null) {
          final pixelRatio = MediaQuery.of(context).devicePixelRatio;
          final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
          final byteData = await image.toByteData(
            format: ui.ImageByteFormat.png,
          );
          bytes = byteData?.buffer.asUint8List();
        }
      }

      if (bytes != null && bytes.isNotEmpty) {
        try {
          _localStream?.getTracks().forEach((t) => t.stop());
        } catch (_) {}

        // Save captured bytes in-memory and show them in the preview area.
        if (!mounted) return;
        setState(() {
          _capturedImageBytes = bytes;
          _isCameraInitialized = false;
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Capture not available on this platform'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Capture failed: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Capture failed: $e')));
    }
  }
}
