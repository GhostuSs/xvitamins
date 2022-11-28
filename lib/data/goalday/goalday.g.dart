// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goalday.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalDayAdapter extends TypeAdapter<GoalDay> {
  @override
  final int typeId = 1;

  @override
  GoalDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalDay(
      day: fields[0] as DateTime?,
      note: fields[2] == null ? '' : fields[2] as String?,
      food: fields[1] == null ? [] : (fields[1] as List?)?.cast<Food>(),
      seen: fields[3] == null ? false : fields[3] as bool?,
      completed: fields[4] == null ? false : fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GoalDay obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.food)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.seen)
      ..writeByte(4)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
