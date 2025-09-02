import 'package:flutter/material.dart';
import 'package:thervision/core/constants/app_colors.dart';
import 'package:thervision/core/routes/app_routes.dart';
import 'package:thervision/core/widgets/analyse_screen.dart';

import 'MainScaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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
                              // Video feed
                              Container(
                                margin: EdgeInsets.all(16),
                                color: Colors.black,
                                height: 300,

                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Video Stream Here",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
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
                                flex: 7,
                                child: Container(
                                  margin: EdgeInsets.all(16),
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      "Video Stream Here",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
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
}
