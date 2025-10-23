import 'package:flutter/material.dart';
import 'package:thervision/core/constants/app_colors.dart';
import 'package:thervision/core/routes/app_routes.dart';
import 'MainScaffold.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  RTCVideoRenderer? _localRenderer;
  MediaStream? _localStream;
  bool _isCameraInitialized = false;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primary; // custom hover background
              }
              return AppColors.white; // default button color
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white; // text is white on hover
              }
              return AppColors.primary; // default text color
            }),
            overlayColor: MaterialStateProperty.all<Color>(AppColors.primary),
            // disables ripple / splash overlay
          ),
        ),
      ),
      child: MainScaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/BG.png", fit: BoxFit.cover),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600; // breakpoint

                return Center(
                  child:
                      isMobile
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Video feed (mobile)
                              Container(
                                margin: const EdgeInsets.all(16),
                                color: Colors.black,
                                height: 300,
                                width: double.infinity,
                                child: _buildCameraPreview(context),
                              ),
                              SizedBox(height: 20),
                              // Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(180, 50),
                                      maximumSize: Size(220, 50),
                                    ),
                                    child: Text("Capture"),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        AppRoutes.analyse,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(180, 50),
                                    ),
                                    child: Text("Analyse"),
                                  ),
                                ],
                              ),
                            ],
                          )
                          : Row(
                            children: [
                              // Video feed - 70%
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 500,
                                  width: 500,
                                  margin: const EdgeInsets.all(16),
                                  color: Colors.black,
                                  child: _buildCameraPreview(context),
                                ),
                              ),
                              // Buttons - 30%
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(250, 60),
                                      ),
                                      child: Text(
                                        "Capture",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.analyse,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(250, 60),
                                      ),
                                      child: Text(
                                        "Analyse",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _localRenderer = RTCVideoRenderer();
      await _localRenderer!.initialize();

      // Request user media (camera only)
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
      // leave _isCameraInitialized false; UI will show fallback
    }
  }

  @override
  void dispose() {
    try {
      _localStream?.getTracks().forEach((t) => t.stop());
    } catch (_) {}
    _localRenderer?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview(BuildContext context) {
    if (_isCameraInitialized && _localRenderer != null) {
      return RTCVideoView(
        _localRenderer!,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      );
    }

    return const Center(
      child: Text(
        'Camera unavailable',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
