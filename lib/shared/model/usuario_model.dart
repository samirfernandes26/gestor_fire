import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  UsuarioModel({
    this.userId,
    required this.sexo,
    required this.ativo,
    required this.cpf,
    required this.funcao,
    required this.nome,
  });

  String? userId;
  String sexo;
  int ativo;
  int cpf;
  String funcao;
  String nome;

  UsuarioModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..sexo = json['sexo'] as String
        ..sexo = json['userId'] as String
        ..ativo = json['ativo'] as int
        ..cpf = json['cpf'] as int
        ..funcao = json['funcao'] as String
        ..nome = json['nome'] as String;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
