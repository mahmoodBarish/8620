import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/shop_clothing_on_scroll_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/shop_clothing_on_scroll',
  routes: <RouteBase>[
    GoRoute(
      path: '/shop_clothing_on_scroll',
      builder: (BuildContext context, GoRouterState state) {
        return const ShopClothingOnScrollScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}
