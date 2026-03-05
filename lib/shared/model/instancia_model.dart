import 'package:json_annotation/json_annotation.dart';

part 'instancia_model.g.dart';

@JsonSerializable()
class InstanciaModel {
  InstanciaModel({
    required this.ativo,
    required this.ace,
    required this.acs,
    required this.motorista,
    required this.nome,
    required this.url,
    required this.localidadeId,
    required this.documentoId,
  });

  @JsonKey(name: 'document_id')
  String documentoId;

  bool ativo;

  bool ace;

  bool acs;

  bool motorista;

  String nome;

  String url;

  @JsonKey(name: 'localidade_id')
  int localidadeId;

  InstanciaModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..ativo = json['ativo'] as bool
        ..ace = json['ace'] as bool
        ..acs = json['acs'] as bool
        ..motorista = json['motorista'] as bool
        ..nome = json['nome'] as String
        ..url = json['url'] as String
        ..localidadeId = json['localidade_id'] as int
        ..documentoId = json['document_id'] as String;

  factory InstanciaModel.fromJson(Map<String, dynamic> json) =>
      _$InstanciaModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstanciaModelToJson(this);
}
