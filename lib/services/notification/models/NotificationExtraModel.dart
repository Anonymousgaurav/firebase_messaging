import 'package:json_annotation/json_annotation.dart';

part 'NotificationExtraModel.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationExtraModel {
  @JsonKey(name: "image_url")
  final String? imageUrl;

  NotificationExtraModel({
    this.imageUrl,
  });

  factory NotificationExtraModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationExtraModelFromJson(json);

  bool get hasImage => imageUrl != null;

  Map<String, dynamic> toJson() => _$NotificationExtraModelToJson(this);
}
