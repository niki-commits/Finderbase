import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_application_1/screens/lost_found_provider.dart';

 // Import the provider

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/lost_report_screen.dart';
import 'screens/found_report_screen.dart';
import 'screens/image_picker_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LostFoundProvider()), // Provide LostFoundProvider
      ],
      child: const FinderBaseApp(),
    ),
  );
}

class FinderBaseApp extends StatelessWidget {
  const FinderBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinderBase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/report-lost': (context) => LostReportScreen(),
        '/report-found': (context) => FoundForm(), // Use FoundForm instead of FoundReportScreen
        '/image-picker': (context) => const ImagePickerScreen(),
      },
    );
  }
}
