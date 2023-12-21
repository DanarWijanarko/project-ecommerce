import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/theme.dart';
import 'package:project_ecommerce/functions/firebase_options.dart';
import 'package:project_ecommerce/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: ColorScheme(
        //   brightness: Brightness.light,
        //   primary: blue,
        //   onPrimary: blue,
        //   secondary: textGrey,
        //   onSecondary: bgGrey,
        //   error: red,
        //   onError: red,
        //   background: blue,
        //   onBackground: blue,
        //   surface: black,
        //   onSurface: black,
        // ),
        scaffoldBackgroundColor: white,
        appBarTheme: AppBarTheme(
          backgroundColor: white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
