import 'package:flutter/material.dart';
import 'package:ocr_task/core/widgets/custom_appbar.dart';
import 'package:ocr_task/features/home/presentation/pages/home_page.dart';
import 'package:ocr_task/features/ocr/presentation/pages/ocr_page.dart';
import 'package:ocr_task/features/profile/presentation/pages/profile_page.dart';

import '../../../../core/widgets/custom_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  final List<String> _titles = ['Home - Leads', 'Add Expense', 'Profile'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screens = [HomePage(), const OcrPage(), const ProfilePage()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 1
          ? null
          : CustomAppBar(title: _titles[_selectedIndex]),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
