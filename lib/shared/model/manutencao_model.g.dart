// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manutencao_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManutencaoModel _$ManutencaoModelFromJson(Map<String, dynamic> json) =>
    ManutencaoModel(
      controle: (json['controle'] as num).toInt(),
      mdm: (json['mdm'] as num).toInt(),
      senha: (json['senha'] as num).toInt(),
      logoutUserIdPermission:
          (json['logout_user_id_permission'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
    );

Map<String, dynamic> _$ManutencaoModelToJson(ManutencaoModel instance) =>
    <String, dynamic>{
      'controle': instance.controle,
      'mdm': instance.mdm,
      'senha': instance.senha,
      'logout_user_id_permission': instance.logoutUserIdPermission,
    };
