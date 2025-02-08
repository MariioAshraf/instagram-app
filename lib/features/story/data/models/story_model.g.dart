// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryModelAdapter extends TypeAdapter<StoryModel> {
  @override
  final int typeId = 1;

  @override
  StoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryModel(
      fileUrl: fields[0] as String?,
      caption: fields[1] as String,
      mediaType: fields[2] as MediaType,
      duration: fields[3] as int,
      userId: fields[4] as String,
      createdAt: fields[5] as DateTime,
      localFilePath: fields[6] as String?,
      viewersModels: (fields[9] as Map?)?.cast<String, UserModel>(),
      viewersIds: (fields[8] as Map?)?.cast<String, String>(),
      storyId: fields[7] as String,
      storyUserModel: fields[10] as UserModel?,
    );
  }

  @override
  void write(BinaryWriter writer, StoryModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.fileUrl)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.mediaType)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.localFilePath)
      ..writeByte(7)
      ..write(obj.storyId)
      ..writeByte(8)
      ..write(obj.viewersIds)
      ..writeByte(9)
      ..write(obj.viewersModels)
      ..writeByte(10)
      ..write(obj.storyUserModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MediaTypeAdapter extends TypeAdapter<MediaType> {
  @override
  final int typeId = 0;

  @override
  MediaType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MediaType.image;
      case 1:
        return MediaType.video;
      default:
        return MediaType.image;
    }
  }

  @override
  void write(BinaryWriter writer, MediaType obj) {
    switch (obj) {
      case MediaType.image:
        writer.writeByte(0);
        break;
      case MediaType.video:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
