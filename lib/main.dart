import 'package:flutter/material.dart';

import 'app/infra/dependency_injection/injection.dart';
import 'app/modules/splash/splash_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupProjectDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
