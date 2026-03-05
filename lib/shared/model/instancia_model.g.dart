// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instancia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstanciaModel _$InstanciaModelFromJson(Map<String, dynamic> json) =>
    InstanciaModel(
      ativo: json['ativo'] as bool,
      ace: json['ace'] as bool,
      acs: json['acs'] as bool,
      motorista: json['motorista'] as bool,
      nome: json['nome'] as String,
      url: json['url'] as String,
      localidadeId: (json['localidade_id'] as num).toInt(),
      documentoId: json['document_id'] as String,
    );

Map<String, dynamic> _$InstanciaModelToJson(InstanciaModel instance) =>
    <String, dynamic>{
      'document_id': instance.documentoId,
      'ativo': instance.ativo,
      'ace': instance.ace,
      'acs': instance.acs,
      'motorista': instance.motorista,
      'nome': instance.nome,
      'url': instance.url,
      'localidade_id': instance.localidadeId,
    };
