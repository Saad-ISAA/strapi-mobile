import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/splash_screen.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          hintColor: neutral600,
          colorScheme: ColorScheme(
            background: neutral100,
            onBackground: neutral800,
            // primary color is set to default Strapi color.
            primary: primary500,
            brightness: Brightness.light,
            error: danger500,
            onError: danger500,
            onPrimary: neutral0,
            surface: neutral0,
            primaryVariant: primary700,
            onSurface: neutral0,
            // for buttons
            secondary: primary600,
            secondaryVariant: primary700,
            onSecondary: neutral0,
          ),
          appBarTheme: AppBarTheme(
            color: strapiColor,
          )),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
