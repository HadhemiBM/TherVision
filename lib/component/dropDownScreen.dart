import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DropDownScreen(),
    ),
  );
}

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({Key? key}) : super(key: key);

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  final GlobalKey _menuKey = GlobalKey();

  void _openMenu() {
    final dynamic popupMenu = _menuKey.currentState;
    popupMenu.showButtonMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.lightGreen,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.description, color: Colors.black),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _openMenu,
                  child: const Text(
                    "Fichier",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  key: _menuKey,
                  onSelected: (value) {
                    if (value == 'save') {
                      print("Save selected");
                    } else if (value == 'export') {
                      print("Export selected");
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'save',
                      child: Text('Save'),
                    ),
                    const PopupMenuItem(
                      value: 'export',
                      child: Text('Export'),
                    ),
                  ],
                  child: const Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
