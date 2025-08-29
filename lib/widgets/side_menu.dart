// lib/screens/dashboard/side_menu.dart

import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final Function(int) onItemSelected;
  const SideMenu({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      color: const Color(0xFF2B2F3A),
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onItemSelected(0),
            child: Column(
              children: const [
                Icon(Icons.person, color: Color(0xFFE3E3E3), size: 40),
                SizedBox(height: 1),
                Text('Perfil', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 220),
          GestureDetector(
            onTap: () => onItemSelected(1),
            child: Column(
              children: const [
                Icon(Icons.equalizer, color: Color(0xFFE3E3E3), size: 40),
                SizedBox(height: 1),
                Text('Estadísticas', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => onItemSelected(2),
            child: Column(
              children: const [
                Icon(Icons.apps, color: Color(0xFFE3E3E3), size: 40),
                SizedBox(height: 1),
                Text('Sistema', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 12)),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => onItemSelected(3),
            child: Column(
              children: const [
                Icon(Icons.settings, color: Color(0xFFE3E3E3), size: 40),
                SizedBox(height: 1),
                Text('Ajustes', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}