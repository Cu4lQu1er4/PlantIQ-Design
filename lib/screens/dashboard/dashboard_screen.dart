// lib/screens/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';

// Importaciones de las pestañas del dashboard
import '../dashboard/profile_tab.dart';
import '../dashboard/risks.dart';
import '../dashboard/statistics_tab.dart';
import '../dashboard/system_tap.dart';
import '../dashboard/settings_tab.dart';

// Widget del menú lateral
import '../../widgets/side_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Lista combinada de pantallas, incluyendo la de "Riesgos"
  final List<Widget> _screens = [
    const ProfileTab(),
    RisksListScreen(),          // Nueva pestaña añadida
    const StatisticsTab(),
    const SystemTap(),
    const SettingsTab(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menú lateral que permite cambiar de pestaña
          SideMenu(onItemSelected: _onItemSelected),
          
          // Área principal donde se muestra la pestaña seleccionada
          Expanded(
            child: Container(
              color: const Color(0xFF1C1F2A),
              child: _screens[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
