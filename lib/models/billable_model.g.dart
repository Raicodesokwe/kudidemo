// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billable_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillableModelAdapter extends TypeAdapter<BillableModel> {
  @override
  final int typeId = 2;

  @override
  BillableModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillableModel(
      id: fields[0] as int?,
      start: fields[1] as DateTime?,
      end: fields[2] as DateTime?,
      amount: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BillableModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillableModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
