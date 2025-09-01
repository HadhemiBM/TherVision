import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/main_scaffold.dart';

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
      // Ajoute ici la logique de navigation si besoin
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/BG.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text(
            "HOME",
            style: TextStyle(fontSize: 40, color: AppColors.primary),
          ),
        ),
      ),
      currentIndex: _selectedIndex,
      onTabTapped: _onTabTapped,
    );
  }
}