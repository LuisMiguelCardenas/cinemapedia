import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CostomBottomNavigation extends StatelessWidget {

  final StatefulNavigationShell navigationShell;

  const CostomBottomNavigation({super.key, required this.navigationShell});

    int getCurrentIndex(BuildContext context) {
    final dynamic location = GoRouterState.of(context).fullPath;
    switch (location) {
      case '/':
        return 0;

      case '/categories':
        return 1;

      case '/favorites':
        return 2;

      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: navigationShell,
      
      bottomNavigationBar: BottomNavigationBar(
 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'Categorías'),
           BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined), label: 'Favoritos'),
        ],
        currentIndex: getCurrentIndex(context),
        onTap: (value) => onItemTapped(context, value),
      ),
    );
  }

}