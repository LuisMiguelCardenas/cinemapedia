import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CostomBottomNavigation extends StatelessWidget {
  const CostomBottomNavigation({super.key});

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
    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outlined), label: 'Categorias'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favotritos'),
      ],
    );
  }
}
