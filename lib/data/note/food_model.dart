import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 2)
class Food extends HiveObject{
  Food({this.name,this.gramms,});
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? gramms;
}