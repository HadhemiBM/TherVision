import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:thervision/core/widgets/liste_analyses_table_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:thervision/core/constants/app_colors.dart';
import 'package:thervision/core/widgets/MainScaffold.dart';

class AnalyseScreen extends StatefulWidget {
  // Optional captured image: either bytes (web/in-memory) or a file path
  final Uint8List? imageBytes;
  final String? imagePath;

  const AnalyseScreen({Key? key, this.imageBytes, this.imagePath})
    : super(key: key);

  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
  // Example variables for anomaly and recommendation
  String anomalie = "Température élevée détectée";
  String recommandation = "Vérifiez l'isolation et contactez un spécialiste.";
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
                      // Image thermique (captured image if provided)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildThermalImage(
                            widget.imageBytes,
                            widget.imagePath,
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
        onPressed: () async {
          if (label == "Exporter") {
            // Build PDF using captured image if available, otherwise fallback to bundled asset
            final pdf = pw.Document();
            final Uint8List imageData =
                widget.imageBytes ??
                (await rootBundle.load(
                  'assets/thermal.jpg',
                )).buffer.asUint8List();
            final image = pw.MemoryImage(imageData);
            pdf.addPage(
              pw.Page(
                build:
                    (pw.Context context) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Type anomalie : $anomalie',
                          style: pw.TextStyle(fontSize: 18),
                        ),
                        pw.SizedBox(height: 16),
                        pw.Text(
                          'Recommandation : $recommandation',
                          style: pw.TextStyle(fontSize: 18),
                        ),
                        pw.SizedBox(height: 24),
                        pw.Image(image, width: 400, height: 300),
                      ],
                    ),
              ),
            );
            await Printing.layoutPdf(onLayout: (format) async => pdf.save());
          } else if (label == "Envoyer") {
            // ...existing code...
            String bodyText =
                "Type anomalie : $anomalie\nRecommandation : $recommandation\n";
            if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
              bodyText +=
                  "\nVeuillez trouver l'image thermique ici : https://yourdomain.com/assets/thermal.jpg";
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'example@email.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': 'Analyse',
                  'body': bodyText,
                }),
              );
              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Impossible d'ouvrir le client email."),
                    ),
                  );
                }
              }
            } else {
              try {
                // Prefer captured bytes if available
                final Uint8List bytes =
                    widget.imageBytes ??
                    (await rootBundle.load(
                      'assets/thermal.jpg',
                    )).buffer.asUint8List();
                final tempDir = await getTemporaryDirectory();
                final file = File('${tempDir.path}/thermal.jpg');
                await file.writeAsBytes(bytes);

                bodyText +=
                    "\nVeuillez trouver l'image thermique en pièce jointe.";
                final Email email = Email(
                  body: bodyText,
                  subject: 'Analyse',
                  recipients: ['example@email.com'],
                  attachmentPaths: [file.path],
                  isHTML: false,
                );
                await FlutterEmailSender.send(email);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erreur lors de l\'envoi de l\'email: $e'),
                    ),
                  );
                }
              }
            }
          } else if (label == "Liste") {
            // Navigate to ListeAnalysesScreen
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListeAnalysesTableScreen(),
                ),
              );
            }
          }
        },
        icon: Icon(icon, size: isMobile ? 20 : 24),
        label: Text(label, style: TextStyle(fontSize: isMobile ? 15 : 16)),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  Widget _buildThermalImage(Uint8List? bytes, String? path) {
    if (bytes != null) {
      return Image.memory(bytes, fit: BoxFit.cover, height: 300, width: 400);
    }

    if (path != null) {
      try {
        final file = File(path);
        if (file.existsSync()) {
          return Image.file(file, fit: BoxFit.cover, height: 300, width: 400);
        }
      } catch (_) {}
    }

    return Image.asset(
      'assets/thermal.jpg',
      fit: BoxFit.cover,
      height: 300,
      width: 400,
    );
  }
}
