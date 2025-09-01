import 'package:flutter/material.dart';
import 'package:thervision/core/routes/app_routes.dart';
import 'package:thervision/presentation/home/home_screen.dart';
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
                        ListTile(
                          leading: Icon(
                            Icons.description,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            'Fichier',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          selected: currentIndex == 0,
                          onTap: () {
                            Navigator.pop(context);
                            onTabTapped(0);
                          },
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
                          selected: currentIndex == 1,
                          onTap: () {
                            Navigator.pop(context);
                            onTabTapped(1);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.tune, color: AppColors.primary),
                          title: Text(
                            'Paramètres',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          selected: currentIndex == 2,
                          onTap: () {
                            Navigator.pop(context);
                            onTabTapped(2);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.build, color: AppColors.primary),
                          title: Text(
                            'Outils',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                          selected: currentIndex == 3,
                          onTap: () {
                            Navigator.pop(context);
                            onTabTapped(3);
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
                            HoverNavIcon(
                              icon: Icons.description,
                              label: 'Fichier',
                              index: 0,
                              onTap: (i) {},
                            ),
                            const SizedBox(width: 100),
                            HoverNavIcon(
                              icon: Icons.bar_chart,
                              label: 'Courbes',
                              index: 1,
                              onTap: (i) {},
                            ),
                            const SizedBox(width: 100),
                            HoverNavIcon(
                              icon: Icons.tune,
                              label: 'Paramètres',
                              index: 2,
                              onTap: (i) {},
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
