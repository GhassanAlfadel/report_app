// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:report_app/providers/auth_provider.dart';
import 'package:report_app/providers/report_provider.dart';
import 'package:report_app/screen/auth_screen.dart';
import 'package:report_app/screen/elctrec_options.dart';
import 'package:report_app/screen/home_screen.dart';
import 'package:report_app/screen/report_page.dart';
import 'package:report_app/screen/reports_history.dart';

import 'firebase_options.dart';

void main() async {
  await initializeDateFormatting('ar', null);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey('logedin'); // or your key

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ReportProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider())
    ],
    child: MyApp(
      isLoggedIn: isLoggedIn,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, auth, _) {
        auth.chekAuthState();
        return MaterialApp(
          home: auth.logedin ? const HomeScreen() : const AuthScreen(),
          debugShowCheckedModeBanner: false,
          title: 'Report App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: "/",
          routes: {
            '/electricOptions': (context) => const ElctrecOptions(),
            '/add_report': (context) => const ReportPage(
                  option: '',
                ),
            '/report_history': (context) => const ReportsHistory(),
          },
        );
      },
    );
  }
}
