import 'package:flutter/material.dart';
import 'package:thervision/core/routes/app_routes.dart';

class Footer extends StatelessWidget implements PreferredSizeWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: const Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton retour
          currentRoute != AppRoutes.home
              ? TextButton.icon(
                onPressed: () {
                  // Only pop if there is a previous route AND it's not Login
                  if (Navigator.of(context).canPop() &&
                      currentRoute != AppRoutes.home) {
                    Navigator.of(context).pop();
                  } else {
                    print(
                      "Cannot go back: previous screen is Login or no previous route.",
                    );
                  }
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  "Retour",
                  style: TextStyle(color: Colors.black),
                ),
              )
              : SizedBox.shrink(), // nothing shown if current page is home
          // Texte centré
          const Expanded(
            child: Center(
              child: Text(
                "@4ina Technology",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Espace pour équilibrer le Row (même largeur que le bouton retour)
          const SizedBox(width: 100),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
