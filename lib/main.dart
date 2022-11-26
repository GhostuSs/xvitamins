import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/data/food/food_model.dart';
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
    ..registerAdapter<GoalDay>(GoalDayAdapter())
    ..registerAdapter<GDays>(GDaysAdapter());
  await Hive.deleteFromDisk();
  await Hive.openBox<GDays>('goals');
  await Hive.openBox<bool>('premium');
  if(Hive.box<bool>('premium').values.isEmpty==true){
    await Hive.box<bool>('premium').put('premium', false);
  }
  if (Hive.box<GDays>('goals').values.isEmpty == true) {
    print('empty data');
    await Hive.box<GDays>('goals').put(
      'goals',
      GDays(
        days: [
        ],
      ),
    );
  }
  // Hive.deleteFromDisk();
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
      ),
    );
  }
}
