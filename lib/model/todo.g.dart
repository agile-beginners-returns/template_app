// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      todo: json['todo'] as String,
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'todo': instance.todo,
      'id': instance.id,
      'isCompleted': instance.isCompleted,
    };
