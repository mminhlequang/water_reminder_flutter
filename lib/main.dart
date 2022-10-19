import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/data/models/app_database_manager.dart';
import 'package:water_reminder/presentations/views/views.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabaseManager.instance.database;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterReminderView(),
    );
  }
}
