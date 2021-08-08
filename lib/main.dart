import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signin_signout/screens/SigninScreen.dart';
import'screens/screens.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //navigatorObservers: [
        //FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
      routes: {
        '/home': (context) => HomeScreen(title:'Flutter BLE'),
        '/sign': (context) => SigninScreen(),

        '/search': (context) => search(),
    },
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SigninScreen(),
    );
  }
}

