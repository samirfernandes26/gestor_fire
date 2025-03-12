// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(
  Map<String, dynamic> json,
) => SettingsModel(
  feedback: FeedbackModel.fromJson(json['feedback'] as Map<String, dynamic>),
  gps: GpsModel.fromJson(json['gps'] as Map<String, dynamic>),
  manutencao: ManutencaoModel.fromJson(
    json['manutencao'] as Map<String, dynamic>,
  ),
  pesquisa: PesquisaModel.fromJson(json['pesquisa'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'feedback': instance.feedback,
      'gps': instance.gps,
      'manutencao': instance.manutencao,
      'pesquisa': instance.pesquisa,
    };
