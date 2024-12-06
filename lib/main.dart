import 'package:batalha_series/controllers/database_controller.dart';
import 'package:batalha_series/controllers/get_series_controller.dart';
import 'package:batalha_series/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/register_serie_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final registerSerieController = Get.put(RegisterSerieController());
  final databaseController = Get.put(DatabaseController());
  final getSeriesController = Get.put(GetSeriesController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
