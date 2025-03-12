// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) =>
    FeedbackModel(
      ativo: (json['ativo'] as num).toInt(),
      periodo: (json['periodo'] as num).toInt(),
      usarLocal: (json['usar_local'] as num).toInt(),
    );

Map<String, dynamic> _$FeedbackModelToJson(FeedbackModel instance) =>
    <String, dynamic>{
      'ativo': instance.ativo,
      'periodo': instance.periodo,
      'usar_local': instance.usarLocal,
    };
