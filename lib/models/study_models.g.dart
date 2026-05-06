// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopicAdapter extends TypeAdapter<Topic> {
  @override
  final int typeId = 0;

  @override
  Topic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Topic(
      title: fields[0] as String,
      isRead: fields[1] as bool,
      intervalHours: fields[2] as int,
      lastRevised: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Topic obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isRead)
      ..writeByte(2)
      ..write(obj.intervalHours)
      ..writeByte(3)
      ..write(obj.lastRevised);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CourseUnitAdapter extends TypeAdapter<CourseUnit> {
  @override
  final int typeId = 1;

  @override
  CourseUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseUnit(
      name: fields[0] as String,
      topics: (fields[1] as List).cast<Topic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CourseUnit obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.topics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
