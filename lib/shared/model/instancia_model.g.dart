// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instancia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstanciaModel _$InstanciaModelFromJson(Map<String, dynamic> json) =>
    InstanciaModel(
      settings: SettingsModel.fromJson(
        json['settings'] as Map<String, dynamic>,
      ),
      ativo: (json['ativo'] as num).toInt(),
      cidade: json['cidade'] as String,
      cidadeId: json['cidade_id'] as String,
      id: json['id'] as String,
      municipioId: json['municipio_id'] as String,
      text: json['text'] as String,
      uf: json['uf'] as String,
    );

Map<String, dynamic> _$InstanciaModelToJson(InstanciaModel instance) =>
    <String, dynamic>{
      'settings': instance.settings,
      'ativo': instance.ativo,
      'cidade': instance.cidade,
      'cidade_id': instance.cidadeId,
      'id': instance.id,
      'municipio_id': instance.municipioId,
      'text': instance.text,
      'uf': instance.uf,
    };
