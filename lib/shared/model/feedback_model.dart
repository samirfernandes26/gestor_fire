import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel {
  FeedbackModel({
    required this.ativo,
    required this.periodo,
    required this.usarLocal,
  });

  int ativo;
  int periodo;

  @JsonKey(name: 'usar_local')
  int usarLocal;

  FeedbackModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..ativo = json['ativo'] as int
        ..periodo = json['periodo'] as int
        ..usarLocal = json['usar_local'] as int;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);
}
