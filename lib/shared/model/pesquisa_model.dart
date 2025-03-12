import 'package:json_annotation/json_annotation.dart';

part 'pesquisa_model.g.dart';

@JsonSerializable()
class PesquisaModel {
  PesquisaModel({required this.covid, required this.usarLocal});

  int covid;

  @JsonKey(name: 'usar_local')
  int usarLocal;

  PesquisaModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..covid = json['covid'] as int
        ..usarLocal = json['usar_local'] as int;

  factory PesquisaModel.fromJson(Map<String, dynamic> json) =>
      _$PesquisaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PesquisaModelToJson(this);
}
