import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'pages/home/home_page.dart';
import 'pages/menu/menu_page.dart';
import 'pages/menu/menu_item_detail_page.dart';
import 'pages/cart/cart_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/splash/splash_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/checkout/checkout_page.dart';
import 'pages/order/order_tracking_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(currentThemeProvider);
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Chicken La Canyada',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: authState.when(
        data: (user) {
          if (user != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
        loading: () => const SplashPage(),
        error: (error, stack) => const LoginPage(),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/menu': (context) => const MenuPage(),
        '/menu-item-detail': (context) => const MenuItemDetailPage(),
        '/cart': (context) => const CartPage(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/checkout': (context) => const CheckoutPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/order-tracking') {
          final orderId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => OrderTrackingPage(orderId: orderId),
          );
        }
        return null;
      },
    );
  }
}
