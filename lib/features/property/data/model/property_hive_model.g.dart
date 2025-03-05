// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertyHiveModelAdapter extends TypeAdapter<PropertyHiveModel> {
  @override
  final int typeId = 1;

  @override
  PropertyHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PropertyHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      location: fields[3] as String,
      image: fields[4] as String,
      pricePerNight: fields[5] as double,
      available: fields[6] as bool,
      bedCount: fields[7] as int,
      bedroomCount: fields[8] as int,
      city: fields[9] as String,
      state: fields[10] as String,
      country: fields[11] as String,
      guestCount: fields[12] as int,
      bathroomCount: fields[13] as int,
      amenities: (fields[14] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PropertyHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.pricePerNight)
      ..writeByte(6)
      ..write(obj.available)
      ..writeByte(7)
      ..write(obj.bedCount)
      ..writeByte(8)
      ..write(obj.bedroomCount)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.country)
      ..writeByte(12)
      ..write(obj.guestCount)
      ..writeByte(13)
      ..write(obj.bathroomCount)
      ..writeByte(14)
      ..write(obj.amenities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
