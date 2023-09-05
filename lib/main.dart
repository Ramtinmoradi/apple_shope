import 'package:apple_shop/bottom_navigation.dart';
import 'package:apple_shop/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavgation(),
    );
  }
}

// BlocProvider(
//           create: (context) => AuthBloc(),
//           child: LoginScreen(),
//         ),
