import 'package:hive/hive.dart';
import 'package:xvitamins/data/note/food_model.dart';

part 'goalday.g.dart';

@HiveType(typeId: 1)
class GoalDay extends HiveObject{
  GoalDay({this.day,});
  @HiveField(0)
  DateTime? day;
  @HiveField(1)
  List<Food>? food;
  @HiveField(2)
  String? note;

}