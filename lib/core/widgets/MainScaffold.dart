import 'package:flutter/material.dart';
import 'package:thervision/core/routes/app_routes.dart';
import 'package:thervision/component/footer.dart';
import '../constants/app_colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final Function(int) onTabTapped;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 900;
        return Scaffold(
          drawer:
              isMobile
                  ? Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          color: AppColors.bgNavbar,
                          height: 60, // set your custom height
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  "assets/LogoBig.png",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "THERVISION",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.description,
                        //     color: AppColors.primary,
                        //   ),
                        //   title: Text(
                        //     'Fichier',
                        //     style: const TextStyle(color: AppColors.primary),
                        //   ),
                        //   selected: currentIndex == 0,
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     onTabTapped(0);
                        //   },
                        // ),
                        ExpansionTile(
                          leading: Icon(
                            Icons.description,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            'Fichier',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          initiallyExpanded:
                              currentIndex == 1, // expand if selected
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                              ),
                              leading: Icon(
                                Icons.folder_open,
                                size: 18.0,

                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Ouvrir fichier",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              onTap: () {
                                // Navigator.pop(context);
                                onTabTapped(1);
                                print("Ouvrir selected");
                              },
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                              ),
                              leading: Icon(
                                Icons.save,
                                size: 18.0,

                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Enregistrer sous",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              onTap: () {
                                // Navigator.pop(context);
                                onTabTapped(2);
                                print("Enregistrer selected");
                              },
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                              ),
                              leading: Icon(
                                Icons.file_upload,
                                size: 18.0,
                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Importer image",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                onTabTapped(3);
                                print("export selected");
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.bar_chart,
                            color: AppColors.primary,
                          ),
                          // Fichier
                          title: Text(
                            'Courbes',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          selected: currentIndex == 4,
                          onTap: () {
                            // Navigator.pop(context);
                            onTabTapped(1);
                          },
                        ),
                        // ListTile(
                        //   leading: Icon(Icons.tune, color: AppColors.primary),
                        //   title: Text(
                        //     'Paramètres',
                        //     style: const TextStyle(color: AppColors.primary),
                        //   ),
                        //   selected: currentIndex == 2,
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     onTabTapped(2);
                        //   },
                        // ),
                        ExpansionTile(
                          leading: Icon(Icons.tune, color: AppColors.primary),
                          title: Text(
                            'Paramètres',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          initiallyExpanded:
                              currentIndex == 5, // expand if selected
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                              ),
                              leading: Icon(
                                Icons.radio_button_checked,
                                size: 18.0,

                                color: AppColors.primary,
                              ),

                              title: const Text(
                                "Connecter",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              onTap: () {
                                // Navigator.pop(context);
                                onTabTapped(6);
                                print("Connecter selected");
                              },
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                              ),
                              leading: Icon(
                                Icons.block,
                                size: 18.0,

                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Déconnecter",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              onTap: () {
                                // Navigator.pop(context);
                                onTabTapped(7);
                                print("Déconnecter selected");
                              },
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                              ),
                              leading: Icon(
                                Icons.settings_input_component,
                                size: 18.0,
                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Calibration",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              onTap: () {
                                // Navigator.pop(context);
                                onTabTapped(7);
                                print("Calibration selected");
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Icon(Icons.build, color: AppColors.primary),
                          title: Text(
                            'Outils',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          selected: currentIndex == 8,
                          onTap: () {
                            Navigator.pop(context);
                            onTabTapped(8);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: AppColors.primary,
                          ),
                          title: const Text(
                            'Déconnexion',

                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            // Exemple d'action logout
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                  : null,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.transparent,
                child: Row(
                  children: [
                    // Logo + Title
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/LogoBig.png", // <-- update with your logo path
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "THERVISION",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (isMobile)
                      Builder(
                        builder:
                            (context) => IconButton(
                              icon: Icon(Icons.menu, color: Colors.teal[900]),
                              onPressed:
                                  () => Scaffold.of(context).openDrawer(),
                            ),
                      )
                    else ...[
                      // Nav icons (desktop/tablet only)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bgNavbar,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // HoverNavIcon(
                            //   icon: Icons.description,
                            //   label: 'Fichier',
                            //   index: 0,

                            //   onTap: (i) {},
                            // ),
                            HoverNavMenu(
                              icon: Icons.description,
                              label: 'Fichier',
                              items: [
                                PopupMenuItem(
                                  value: 'open',
                                  child: Text('Ouvrir fichier'),
                                ),
                                PopupMenuItem(
                                  value: 'save',
                                  child: Text('Enregistrer sous'),
                                ),
                                PopupMenuItem(
                                  value: 'import',
                                  child: Text('Importer image'),
                                ),
                              ],
                            ),

                            const SizedBox(width: 100),
                            HoverNavIcon(
                              icon: Icons.bar_chart,
                              label: 'Courbes',
                              index: 1,
                              onTap: (i) {},
                            ),
                            const SizedBox(width: 100),
                            // HoverNavIcon(
                            //   icon: Icons.tune,
                            //   label: 'Paramètres',
                            //   index: 2,
                            //   onTap: (i) {},
                            // ),
                            HoverNavMenu(
                              icon: Icons.tune,
                              label: 'Paramètres',
                              items: [
                                PopupMenuItem(
                                  value: 'Connecter',
                                  child: Text('Connecter'),
                                ),
                                PopupMenuItem(
                                  value: 'Déconnecter',
                                  child: Text('Déconnecter'),
                                ),
                                PopupMenuItem(
                                  value: 'Calibration',
                                  child: Text('Calibration'),
                                ),
                              ],
                            ),
                            const SizedBox(width: 100),
                            HoverNavIcon(
                              icon: Icons.build,
                              label: 'Outils',
                              index: 3,
                              onTap: (i) {},
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      // Logout button (desktop/tablet only)
                      HoverLogout(
                        onTap: () {
                          // action à exécuter lors du clic
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          );

                          // Exemple : FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(child: body),
              const Footer(),
            ],
          ),
        );
      },
    );
  }

  // Helper for nav icons
  Widget _buildNavIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Icon(
        icon,
        size: 24,
        color: AppColors.primary, // couleur sombre des icônes
      ),
    );
  }
}

class HoverNavIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final int index;
  final Function(int) onTap;

  const HoverNavIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.onTap,
  });

  @override
  State<HoverNavIcon> createState() => _HoverNavIconState();
}

class _HoverNavIconState extends State<HoverNavIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.index),
        child: Row(
          children: [
            Icon(widget.icon, size: 28, color: AppColors.primary),
            if (_isHovered) ...[
              const SizedBox(width: 8),

              Text(
                widget.label,
                style: const TextStyle(fontSize: 16, color: AppColors.primary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HoverLogout extends StatefulWidget {
  final VoidCallback onTap;

  const HoverLogout({super.key, required this.onTap});

  @override
  State<HoverLogout> createState() => _HoverLogoutState();
}

class _HoverLogoutState extends State<HoverLogout> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0C3C46),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: _isHovered ? Colors.white : Colors.white,
              ),
              if (_isHovered) ...[
                const SizedBox(width: 8),
                Text(
                  "Déconnexion",
                  style: TextStyle(
                    color: _isHovered ? Colors.white : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class HoverNavMenu extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<PopupMenuEntry<String>> items;

  const HoverNavMenu({
    super.key,
    required this.icon,
    required this.label,
    required this.items,
  });

  @override
  State<HoverNavMenu> createState() => _HoverNavMenuState();
}

class _HoverNavMenuState extends State<HoverNavMenu> {
  final GlobalKey<PopupMenuButtonState<String>> _menuKey = GlobalKey();
  bool _isHovered = false;

  void _openMenu() {
    setState(() => _isHovered = true);
    final dynamic popupMenu = _menuKey.currentState;

    popupMenu.showButtonMenu();
    Future.delayed(Duration.zero, () {
      Navigator.of(context).overlay!.context; // just to ensure build finished
    }).then((_) {
      // quand menu fermé
      setState(() => _isHovered = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _openMenu, // 👉 clic ouvre le menu
        child: Row(
          children: [
            Icon(widget.icon, size: 28, color: AppColors.primary),
            if (_isHovered) ...[
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(fontSize: 16, color: AppColors.primary),
              ),
            ],
            // invisible PopupMenuButton (juste pour générer le menu)
            PopupMenuButton<String>(
              key: _menuKey,
              itemBuilder: (context) => widget.items,
              onSelected: (value) {
                if (value == 'open') {
                  print("Ouvrir fichier");
                } else if (value == 'save') {
                  print("Enregistrer sous");
                } else if (value == 'import') {
                  print("Importer image");
                }
              },
              // on cache complètement le bouton par défaut
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverNavMenuParams extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<PopupMenuEntry<String>> items;

  const HoverNavMenuParams({
    super.key,
    required this.icon,
    required this.label,
    required this.items,
  });

  @override
  State<HoverNavMenu> createState() => _HoverNavMenuParamsState();
}

class _HoverNavMenuParamsState extends State<HoverNavMenu> {
  final GlobalKey<PopupMenuButtonState<String>> _menuKey = GlobalKey();
  bool _isHovered = false;

  void _openParamsMenu() {
    setState(() => _isHovered = true);
    final dynamic popupMenu = _menuKey.currentState;

    popupMenu.showButtonMenu();
    Future.delayed(Duration.zero, () {
      Navigator.of(context).overlay!.context; // just to ensure build finished
    }).then((_) {
      // quand menu fermé
      setState(() => _isHovered = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _openParamsMenu, // 👉 clic ouvre le menu
        child: Row(
          children: [
            Icon(widget.icon, size: 28, color: AppColors.primary),
            if (_isHovered) ...[
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(fontSize: 16, color: AppColors.primary),
              ),
            ],
            // invisible PopupMenuButton (juste pour générer le menu)
            PopupMenuButton<String>(
              key: _menuKey,
              itemBuilder: (context) => widget.items,
              onSelected: (value) {
                if (value == 'Connecter') {
                  print("Connecter");
                } else if (value == 'Déconnecter') {
                  print("Déconnecter");
                } else if (value == 'Calibration') {
                  print("Calibration");
                }
              },
              // on cache complètement le bouton par défaut
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
