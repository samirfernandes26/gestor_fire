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

  FeedbackModel feedback;
  GpsModel gps;
  ManutencaoModel manutencao;
  PesquisaModel pesquisa;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
