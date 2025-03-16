// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioModel _$UsuarioModelFromJson(Map<String, dynamic> json) => UsuarioModel(
  userId: json['userId'] as String?,
  sexo: json['sexo'] as String,
  ativo: (json['ativo'] as num).toInt(),
  cpf: (json['cpf'] as num).toInt(),
  funcao: json['funcao'] as String,
  nome: json['nome'] as String,
);

Map<String, dynamic> _$UsuarioModelToJson(UsuarioModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'sexo': instance.sexo,
      'ativo': instance.ativo,
      'cpf': instance.cpf,
      'funcao': instance.funcao,
      'nome': instance.nome,
    };
