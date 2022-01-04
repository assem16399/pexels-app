// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WallpaperAdapter extends TypeAdapter<Wallpaper> {
  @override
  final int typeId = 1;

  @override
  Wallpaper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wallpaper(
      id: fields[0] as int?,
      width: fields[1] as int?,
      height: fields[3] as int?,
      imageUrl: fields[4] as String?,
      photographer: fields[5] as String?,
      photographerUrl: fields[6] as String?,
      photographerId: fields[7] as int?,
      avgColor: fields[8] as String?,
      src: fields[9] as WallpaperSource?,
      alt: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Wallpaper obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.photographer)
      ..writeByte(6)
      ..write(obj.photographerUrl)
      ..writeByte(7)
      ..write(obj.photographerId)
      ..writeByte(8)
      ..write(obj.avgColor)
      ..writeByte(9)
      ..write(obj.src)
      ..writeByte(10)
      ..write(obj.alt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallpaperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WallpaperSourceAdapter extends TypeAdapter<WallpaperSource> {
  @override
  final int typeId = 0;

  @override
  WallpaperSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WallpaperSource(
      original: fields[0] as String?,
      large: fields[1] as String?,
      large2x: fields[2] as String?,
      medium: fields[3] as String?,
      small: fields[4] as String?,
      portrait: fields[5] as String?,
      tiny: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WallpaperSource obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.original)
      ..writeByte(1)
      ..write(obj.large)
      ..writeByte(2)
      ..write(obj.large2x)
      ..writeByte(3)
      ..write(obj.medium)
      ..writeByte(4)
      ..write(obj.small)
      ..writeByte(5)
      ..write(obj.portrait)
      ..writeByte(6)
      ..write(obj.tiny);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallpaperSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
