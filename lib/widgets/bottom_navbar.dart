import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workingauth/providers/bottomnav_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: context.watch<BottomNavSelect>().selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (idx) {
        context.read<BottomNavSelect>().updateIndex(idx);
        // Respond to item press.
      },
    );
  }
}
