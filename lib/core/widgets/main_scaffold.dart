
import 'package:flutter/material.dart';
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
          drawer: isMobile
              ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: AppColors.bgNavbar,
                        ),
                        child: Row(
                          children: [
                            /* CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFF0C3C46),
                              child: const Icon(Icons.refresh, color: Colors.white),
                            ), */
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
                      ),
                      ListTile(
                        leading: Icon(Icons.description),
                        title: Text('Fichier'),
                        selected: currentIndex == 0,
                        onTap: () {
                          Navigator.pop(context);
                          onTabTapped(0);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.bar_chart),
                        title: Text('Profil'),
                        selected: currentIndex == 1,
                        onTap: () {
                          Navigator.pop(context);
                          onTabTapped(1);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.tune),
                        title: Text('Paramètres'),
                        selected: currentIndex == 2,
                        onTap: () {
                          Navigator.pop(context);
                          onTabTapped(2);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.build),
                        title: Text('Outils'),
                        selected: currentIndex == 3,
                        onTap: () {
                          Navigator.pop(context);
                          onTabTapped(3);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                )
              : null,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.transparent,
                child: Row(
                  children: [
                    // Logo + Title
                    Row(
                      children: [
                        /* CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF0C3C46),
                          child: const Icon(Icons.refresh, color: Colors.white),
                        ), */
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
                        )
                      ],
                    ),
                    const Spacer(),
                    if (isMobile)
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.teal[900]),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      )
                    else ...[
                      // Nav icons (desktop/tablet only)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.bgNavbar,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildNavIcon(Icons.description, 0),
                            const SizedBox(width: 100),
                            _buildNavIcon(Icons.bar_chart, 1),
                            const SizedBox(width: 100),
                            _buildNavIcon(Icons.tune, 2),
                            const SizedBox(width: 100),
                            _buildNavIcon(Icons.build, 3),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Logout button (desktop/tablet only)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C3C46),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.logout, color: Colors.white),
                        ),
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
        color: Colors.teal[900], // couleur sombre des icônes
      ),
    );
  }
}
