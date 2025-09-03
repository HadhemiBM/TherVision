import 'package:flutter/material.dart';
import 'package:thervision/core/constants/app_colors.dart';
import 'package:thervision/core/widgets/MainScaffold.dart';

class AnalyseScreen extends StatefulWidget {
  const AnalyseScreen({super.key});

  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
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
        // backgroundColor: Colors.white,
        body: Center(
          // ⬅️ Center everything vertically + horizontally
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // ⬅️ horizontal center
              crossAxisAlignment:
                  CrossAxisAlignment.center, // ⬅️ vertical center
              children: [
                // Partie gauche : Image thermique + boutons
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // ⬅️ vertical center inside
                    children: [
                      // Image thermique
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/thermal.jpg",
                            fit: BoxFit.cover,
                            height: 300,
                            width: 400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const SizedBox(height: 24),

                      // Boutons
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isMobile = constraints.maxWidth < 600;
                          final buttons = [
                            _buildButton(Icons.save, "Enregistrer", isMobile),
                            _buildButton(
                              Icons.upload_file,
                              "Exporter",
                              isMobile,
                            ),
                            _buildButton(Icons.share, "Envoyer", isMobile),
                            _buildButton(Icons.list, "Liste", isMobile),
                          ];

                          if (isMobile) {
                            return Column(
                              children:
                                  buttons
                                      .map(
                                        (btn) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: btn,
                                        ),
                                      )
                                      .toList(),
                            );
                          } else {
                            // 2 par ligne
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buttons[0],
                                    const SizedBox(width: 30),
                                    buttons[1],
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buttons[2],
                                    const SizedBox(width: 30),
                                    buttons[3],
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 30),

                // Partie droite : texte anomalie & recommandations
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // ⬅️ vertical centering
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Type anomalie :", style: TextStyle(fontSize: 18)),
                      SizedBox(height: 50),
                      Text("Recommandations:", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        currentIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, bool isMobile) {
    return SizedBox(
      width: isMobile ? 200 : 220,
      height: isMobile ? 50 : 55,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: isMobile ? 20 : 24),
        label: Text(label, style: TextStyle(fontSize: isMobile ? 15 : 16)),
      ),
    );
  }
}
