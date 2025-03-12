// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pesquisa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PesquisaModel _$PesquisaModelFromJson(Map<String, dynamic> json) =>
    PesquisaModel(
      covid: (json['covid'] as num).toInt(),
      usarLocal: (json['usar_local'] as num).toInt(),
    );

Map<String, dynamic> _$PesquisaModelToJson(PesquisaModel instance) =>
    <String, dynamic>{
      'covid': instance.covid,
      'usar_local': instance.usarLocal,
    };
