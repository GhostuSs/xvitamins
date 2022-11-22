import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Food extends HiveObject{
  Food({this.name,this.gramms,});
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? gramms;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  /// Connect the generated [_$FoodToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}