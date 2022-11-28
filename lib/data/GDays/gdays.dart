import 'package:hive/hive.dart';
import 'package:xvitamins/data/goalday/goalday.dart';

part 'gdays.g.dart';

@HiveType(typeId: 3)
///Все дни
class GDays extends HiveObject{
  GDays({this.days,});
  @HiveField(0,defaultValue: [])
  List<GoalDay>? days;

}