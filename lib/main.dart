import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/my_app.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfig.initializePrefs();
  runApp(MyApp());
}
