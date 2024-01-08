import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';
import 'package:project_ecommerce/routes/route.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  String? userUid = AuthServices().getCurrentUserUID();
  bool isAdmin = await FirestoreService().getIsAdmin(userUid);

  runApp(MyApp(isAdmin: isAdmin, userUid: userUid));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isAdmin, required this.userUid});

  final String? userUid;
  final bool isAdmin;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: white,
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: white,
          elevation: 0,
        ),
      ),
      initialRoute: RouteGenerator.routeInit(widget.userUid, widget.isAdmin),
      routes: RouteGenerator.generateRoute(),
    );
  }
}
