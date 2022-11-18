import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/data/note/food_model.dart';
import 'package:xvitamins/ui/main/ui/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = Directory.current;
  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(
    directory.path,
  );
  Hive
    ..registerAdapter<Food>(FoodAdapter())
    ..registerAdapter<GoalDay>(GoalDayAdapter());
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (_, s) => const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
            ));
  }
}
