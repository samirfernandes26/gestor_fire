import 'package:json_annotation/json_annotation.dart';

part 'manutencao_model.g.dart';

@JsonSerializable()
class ManutencaoModel {
  ManutencaoModel({
    required this.controle,
    required this.mdm,
    required this.senha,
    required this.logoutUserIdPermission,
  });

  int controle;
  int mdm;
  int senha;

  @JsonKey(name: 'logout_user_id_permission')
  List<int> logoutUserIdPermission;

  ManutencaoModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..controle = json['controle'] as int
        ..mdm = json['mdm'] as int
        ..senha = json['senha'] as int
        ..logoutUserIdPermission =
            json['logout_user_id_permission'] as List<int>;

  factory ManutencaoModel.fromJson(Map<String, dynamic> json) =>
      _$ManutencaoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManutencaoModelToJson(this);
}
