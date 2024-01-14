import 'dart:convert';

import 'package:firebase_messaging_demo/services/notification/models/NotificationExtraModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NotificationModel.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "body")
  String? body;
  @JsonKey(name: "type")
  @visibleForTesting
  final String? type;
  @JsonKey(name: "extra")
  @visibleForTesting
  final String? extra;

  final NotificationExtraModel? notificationExtra;
  int? id;

  NotificationModel({
    required this.id,
    this.title,
    this.body,
    this.type,
    this.extra,
  }) : this.notificationExtra = extra == null
            ? null
            : NotificationExtraModel.fromJson(jsonDecode(extra));

  NotificationModel.fromExtraModel({
    required this.id,
    this.title,
    this.body,
    this.notificationExtra,
    NotificationType? notificationType,
  })  : this.extra = jsonEncode(notificationExtra),
        this.type = notificationType?.name;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  NotificationType? get notificationType {
    switch (type) {
      case "postlike":
        return NotificationType.like;
      case "postcomment":
        return NotificationType.comment;
      case "newfollower":
        return NotificationType.follow;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  String toString() {
    return '''
    id : ${this.id} 
   title : ${this.title} 
   body : ${this.body} 
   type : ${this.type} 
   extras : ${this.extra} 
    ''';
  }
}

enum NotificationType { like, comment, follow }

extension NotificationTypeEx on NotificationType {
  String get name {
    switch (this) {
      case NotificationType.like:
        return "postlike";
      case NotificationType.comment:
        return "postcomment";
      case NotificationType.follow:
        return "newfollower";
      default:
        return "";
    }
  }
}
