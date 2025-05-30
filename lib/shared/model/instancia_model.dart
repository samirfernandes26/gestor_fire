import 'package:gestor_fire/shared/model/settings_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instancia_model.g.dart';

@JsonSerializable()
class InstanciaModel {
  InstanciaModel({
    required this.settings,
    required this.ativo,
    required this.cidade,
    required this.cidadeId,
    required this.id,
    required this.municipioId,
    required this.text,
    required this.uf,
  });

  @JsonKey(name: 'settings', toJson: _settingsToJson)
  SettingsModel settings;

  int ativo;

  String cidade;

  @JsonKey(name: 'cidade_id')
  String cidadeId;

  String id;

  @JsonKey(name: 'municipio_id')
  String municipioId;

  String text;

  String uf;

  InstanciaModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..ativo = json['ativo'] as int
        ..cidade = json['cidade'] as String
        ..cidadeId = json['cidade_id'] as String
        ..id = json['id'] as String
        ..municipioId = json['municipio_id'] as String
        ..text = json['text'] as String
        ..uf = json['uf'] as String;

  factory InstanciaModel.fromJson(Map<String, dynamic> json) =>
      _$InstanciaModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstanciaModelToJson(this);

  static _settingsToJson(SettingsModel? instituicao) => instituicao?.toJson();
}
