import 'package:brainepadia/Screens/Login/login_screen.dart';
import 'package:brainepadia/Screens/Signup/signup_screen.dart';
import 'package:brainepadia/Screens/Welcome/welcome_screen.dart';
import 'package:brainepadia/utilis/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:brainepadia/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/dashboard/dashboard.dart';
import 'models/user.dart';
import 'providers/user_provider.dart';
import 'providers/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Providers(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Brainepadia Walllet',
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPrimaryLightColor,
                iconColor: kPrimaryColor,
                prefixIconColor: kPrimaryColor,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              )),
          //home: const WelcomeScreen(),
          //home: authToken != null ? const Dashboard() : const LoginScreen(),
          home: FutureBuilder<User>(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator(
                      color: kPrimaryColor,
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data!.token == null) {
                      return const LoginScreen();
                    } else {
                      UserPreferences().removeUser();
                    }
                    return WelcomeScreen(user: snapshot.data!);
                }
              }),
          routes: {
            '/dashboard': (context) => const Dashboard(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const SignUpScreen(),
          }),
    );
  }
}
