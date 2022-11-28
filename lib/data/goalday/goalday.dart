import 'package:hive/hive.dart';
import 'package:xvitamins/data/food/food_model.dart';

part 'goalday.g.dart';

@HiveType(typeId: 1)
///Один день
class GoalDay extends HiveObject{
  GoalDay({this.day,this.note,this.food,this.seen,this.completed,});
  @HiveField(0)
  DateTime? day;
  @HiveField(1,defaultValue: [])
  List<Food>? food;
  @HiveField(2,defaultValue: '')
  String? note;
  @HiveField(3,defaultValue: false)
  bool? seen;
  @HiveField(4,defaultValue: false)
  bool? completed;

}