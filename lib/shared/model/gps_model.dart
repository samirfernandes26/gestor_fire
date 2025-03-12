import 'package:json_annotation/json_annotation.dart';

part 'gps_model.g.dart';

@JsonSerializable()
class GpsModel {
  GpsModel({required this.precisionGps, required this.searchTypeGps});

  @JsonKey(name: 'precision_GPS')
  int precisionGps;

  @JsonKey(name: 'search_type_GPS')
  int searchTypeGps;

  GpsModel copyWithFromJson(Map<String, dynamic> json) =>
      this
        ..precisionGps = json['precision_GPS'] as int
        ..searchTypeGps = json['search_type_GPS'] as int;

  factory GpsModel.fromJson(Map<String, dynamic> json) =>
      _$GpsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpsModelToJson(this);
}
