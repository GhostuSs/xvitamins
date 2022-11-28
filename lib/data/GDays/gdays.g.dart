// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gdays.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GDaysAdapter extends TypeAdapter<GDays> {
  @override
  final int typeId = 3;

  @override
  GDays read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GDays(
      days: fields[0] == null ? [] : (fields[0] as List?)?.cast<GoalDay>(),
    );
  }

  @override
  void write(BinaryWriter writer, GDays obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GDaysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
