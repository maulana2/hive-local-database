// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersModelsAdapter extends TypeAdapter<UsersModels> {
  @override
  final int typeId = 2;

  @override
  UsersModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersModels(
      id: fields[0] as int?,
      email: fields[1] as String?,
      firstName: fields[2] as String?,
      lastName: fields[3] as String?,
      avatar: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersModels obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
