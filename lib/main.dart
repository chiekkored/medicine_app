import 'package:flutter/material.dart';
import 'package:medicine_app/core/viewmodels/home_viewmodel.dart';
import 'package:medicine_app/utilities/constants/theme_constant.dart';
import 'package:provider/provider.dart';
import 'package:medicine_app/views/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences localPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize local cache
  localPrefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CTheme.lightTheme,
      darkTheme: CTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
