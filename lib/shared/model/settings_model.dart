import 'package:gestor_fire/shared/model/feedback_model.dart';
import 'package:gestor_fire/shared/model/gps_model.dart';
import 'package:gestor_fire/shared/model/manutencao_model.dart';
import 'package:gestor_fire/shared/model/pesquisa_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  SettingsModel({
    required this.feedback,
    required this.gps,
    required this.manutencao,
    required this.pesquisa,
  });

  @JsonKey(name: 'feedback', toJson: _feedbackToJson)
  FeedbackModel feedback;

  @JsonKey(name: 'gps', toJson: _gpsToJson)
  GpsModel gps;

  @JsonKey(name: 'manutencao', toJson: _manutencaoToJson)
  ManutencaoModel manutencao;

  @JsonKey(name: 'pesquisa', toJson: _pesquisaToJson)
  PesquisaModel pesquisa;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  static _feedbackToJson(FeedbackModel? data) => data?.toJson();

  static _gpsToJson(GpsModel? data) => data?.toJson();

  static _manutencaoToJson(ManutencaoModel? data) => data?.toJson();

  static _pesquisaToJson(PesquisaModel? data) => data?.toJson();
}
