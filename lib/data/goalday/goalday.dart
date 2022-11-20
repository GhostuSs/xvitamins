import 'package:hive/hive.dart';
import 'package:xvitamins/data/food/food_model.dart';

part 'goalday.g.dart';

@HiveType(typeId: 1)
///Один день
class GoalDay extends HiveObject{
  GoalDay({this.day,this.note,this.food,this.seen,this.completed,});
  @HiveField(0)
  DateTime? day;
  @HiveField(1)
  List<Food>? food;
  @HiveField(2)
  String? note;
  @HiveField(3)
  bool? seen;
  @HiveField(4)
  bool? completed;

}