import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/requests/requests_screen.dart';
import '../features/waste/add_waste_screen.dart';
import '../features/collectors/collector_directory_screen.dart';
import '../features/profile/profile_screen.dart';
import '../shared/widgets/main_scaffold.dart';

/// Main Application Shell managing 5 bottom navigation tabs
class MainView extends StatefulWidget {
  final int initialTab;

  const MainView({super.key, this.initialTab = 0});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  void _onNavigationChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onTabChange: _onNavigationChanged),
      RequestsScreen(onTabChange: _onNavigationChanged),
      const AddWasteScreen(),
      CollectorDirectoryScreen(onTabChange: _onNavigationChanged),
      ProfileScreen(onTabChange: _onNavigationChanged),
    ];

    return MainScaffold(
      currentIndex: _currentIndex,
      onNavigationChanged: _onNavigationChanged,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
    );
  }
}
