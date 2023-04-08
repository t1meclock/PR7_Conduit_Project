// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      number: json['number'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      dateofcreation: json['dateofcreation'] as String?,
      dateofedit: json['dateofedit'] as String?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'dateofcreation': instance.dateofcreation,
      'dateofedit': instance.dateofedit,
      'deleted': instance.deleted,
    };
