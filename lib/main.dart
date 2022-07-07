import 'package:ecommerce_app/views/onboard_screen.dart';
import 'package:ecommerce_app/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/carts_provider.dart';
import 'models/favorite_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            OnboardScreen.onboardRoute: (context) => const OnboardScreen(),
          },
          home: const SplashScreen()),
    );
  }
}
