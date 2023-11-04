import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'onboarding/splashscreen.dart';
import 'utils/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => Providers(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Brainepadia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor:
            Colors.black, // Set the background color of the app bar
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.black), // Set the title text color
        ),
        iconTheme: const IconThemeData(
            color: Colors.black), // Set the back button color
      ),
      home: const SplashScreen(),
    );
  }
}
