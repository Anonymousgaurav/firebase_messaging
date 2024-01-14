// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      type: json['type'] as String?,
      extra: json['extra'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'extra': instance.extra,
      'id': instance.id,
    };
